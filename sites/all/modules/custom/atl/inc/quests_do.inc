<?php

/**
 * @file inc/quests_do.inc
 */

/**
 * Home page callback function.  Do a quest.
 *
 * @param \stdClass $game_user
 *   The game user object.
 * @param int $questId
 *   The ID of the quest to perform.
 *
 * @return array
 *   A render array.
 */
function game_quests_do_callback($game_user, $questId) {

  $gameSettings = atlGetGameSettings();

  // Don't let them do quests at levels 6-25 without being in a party.
  if ($game_user->fkey_values_id == 0 && $game_user->level >= 6 &&
    $game_user->level <= 25) {
    game_goto('choose_party', '0');
  }

  $game = check_plain(arg(0));
  $phone_id = $game_user->phone_id;
  db_set_active('game');

//  if ($event_type == EVENT_QUESTS_100)
//    $game_quest->required_energy = min($game_quest->required_energy, 100);

  $questSucceeded = TRUE;
  $outcome = array(array(
    '#markup' => '<div class="quest-succeeded">' .
      t('Success!') .
      '</div>',
  ));
  $aiOutput = 'quest-succeeded';
  $experienceAddedHtml = $moneyAddedHtml = $disbursementsDoubled = NULL;
  $moneyAdded = 0;

  // Load the quest from the db.
  $query = db_select('quests', 'q');
  $query->leftJoin('quest_completion', 'qc', 'qc.fkey_users_id = :id AND qc.fkey_quests_id = q.id',
    array(':id' => $game_user->id));
  $query->condition('q.id', $questId)
    ->fields('q')
    ->addField('qc', 'percent_complete', 'percent_completed' );
  $query->addField('qc', 'bonus_given' );
  if ($phone_id != 'abc123') {
    $query->condition('q.active', 1);
  }
  $quest = $query->execute()->fetchObject();
  $group_to_show = $quest->fkey_quest_groups_id;

  // Quest group names.
  $query = db_select('quest_groups', 'qg')
    ->condition('id', $group_to_show, '=')
    ->fields('qg', array('name'));
  $qg = $query->execute()->fetchField();
  $query = db_select('quest_groups', 'qg')
    ->condition('id', $group_to_show - 1, '=')
    ->fields('qg', array('name'));
  $qgo = $query->execute()->fetchField();
  $query = db_select('quest_groups', 'qg')
    ->condition('id', $group_to_show + 1, '=')
    ->fields('qg', array('name'));
  $qgn = $query->execute()->fetchField();
  if ($qgn) {
    $qgn = game_url('quests', $qgn);
  }

  // Does next quest group have a minimum level not attained yet?
  $query = db_select('quests', 'q')
    ->condition('fkey_quest_groups_id', $group_to_show + 1, '=');
  $query->addExpression('min(required_level)', 'mrl');
  $qgnmrl = $query->execute()->fetchField();

  // No next quest group if the minimum level isn't attained.
  if (is_null($qgnmrl) || $qgnmrl > $game_user->level + 1) {
    $qgn = NULL;
  }
//  $location = str_replace('%location', $location, $qg);
//  if ($game_user->level < 6) $location = '';

  // Get quest and quest group completion stats.
  $query = db_select('quests', 'q');
  $query->leftJoin('quest_completion', 'qc', 'qc.fkey_quests_id = q.id AND qc.fkey_users_id = :id',
    array(':id' => $game_user->id));
  $query->condition('q.fkey_quest_groups_id', $group_to_show);
  if ($phone_id != 'abc123') {
    $query->condition('q.active', 1);
  }
  $query->addExpression('sum(qc.bonus_given)', 'completed');
  $query->addExpression('count(q.id)', 'total');
  $questGroup = $query->execute()->fetchObject();
  $questGroup->completed += 0;

  $query = db_select('quest_group_completion', 'qgc')
    ->condition('qgc.fkey_users_id', $game_user->id)
    ->condition('qgc.fkey_quest_groups_id', $group_to_show)
    ->fields('qgc', array('times_completed'));
  $questGroup->timesCompleted = $query->execute()->fetchField();

  $percentage_target = 100;
  $percentage_divisor = 1;

  if ($questGroup->timesCompleted > 0) {
    $percentage_target = 200;
    $percentage_divisor = 2;
    $questGroup->completed -= ($questGroup->total * min($questGroup->timesCompleted, 1));
  }

  // Check to see if quest prerequisites are met.

  // Required energy?
  if (($game_user->energy < $quest->required_energy) &&
    ($game_user->level >= 6)) { // unlimited quests below level 6

    $questSucceeded = FALSE;
    $outcome = array(
      '#theme' => 'quest_failed',
      '#game_user' => $game_user,
      '#failureType' => 'energy',
    );
    $ai_output = 'quest-failed not-enough-energy';
    competency_gain($game_user, 'too tired');
  }

  if ($questSucceeded) {
    competency_gain($game_user, 'quester');

    // Update user stats.
    $old_energy = $game_user->energy;
    $game_user->energy -= $quest->required_energy;
    $game_user->experience += $quest->experience;
    $moneyAdded = mt_rand($quest->min_money, $quest->max_money);
    $game_user->money += $moneyAdded;
    $moneyAddedHtml = "+$moneyAdded";
    $experienceAddedHtml = "+$quest->experience";

    // Update user table with new stats.
    $query = db_update('users')
      ->expression('energy', 'energy - :energy', array(':energy' => $quest->required_energy))
      ->expression('experience', 'experience + :exp', array(':exp' => $quest->experience))
      ->expression('money', 'money + :money', array(':money' => $moneyAdded))
      ->condition('id', $game_user->id);
    if ($quest->fkey_quest_groups_id < 1000) {
      $query->expression('fkey_last_played_quest_groups_id', $quest->fkey_quest_groups_id);
    }
    if ($old_energy == $game_user->energy_max) {
      $query->expression('energy_next_gain', 'NOW() + :energy_wait', array(':energy_wait' => $gameSettings->getEnergyWait()));
    }
//    dpq($query);
    $query->execute();

    // Update quest completion stats.
    $quest->percent_completed = min($quest->percent_completed +
      floor($quest->percent_complete / $percentage_divisor),
      $percentage_target);

    // Update quest completion table with new stats.
    db_merge('quest_completion')
      ->key(array('fkey_users_id' => $game_user->id, 'fkey_quests_id' => $quest->id))
      ->fields(array(
        'fkey_users_id' => $game_user->id,
        'fkey_quests_id' => $quest->id,
        'percent_complete' => $quest->percent_completed,
      ))
      ->expression(
        'percent_complete',
        'least(percent_complete + :pc, :max)',
        array(':pc' => $quest->percent_complete, ':max' => $percentage_target)
      )
      ->execute();

    // If they have completed the quest for the first time in a round,
    // give them a bonus.
    if ($quest->percent_completed == $percentage_target) {
      if ($quest->bonus_given < $percentage_divisor) {
        competency_gain($game_user, 'quest finisher');

        $game_user->experience += $quest->experience;
        $game_user->money += $moneyAdded;
        $disbursementsDoubled = '<span class="x2">(doubled)</span>';
        $moneyAddedHtml = '+' . ($moneyAdded * 2);
        $experienceAddedHtml = '+' . ($quest->experience * 2);

        db_update('users')
          ->expression('experience', 'experience + :exp', array(':exp' => $quest->experience))
          ->expression('money', 'money + :money', array(':money' => $moneyAdded))
          ->condition('id', $game_user->id)
          ->execute();
        db_update('quest_completion')
          ->expression('bonus_given', 'bonus_given + 1')
          ->condition('fkey_users_id', $game_user->id)
          ->condition('fkey_quests_id', $quest->id)
          ->execute();

        array_unshift($outcome, array(
          '#markup' => 'You completed this quest!'
        ));
//        $quest_completion_html = <<< EOF
//  <div class="title loot">$quest Completed!</div>
//  <p>You have completed this $quest_lower and gained an extra $money_added
//    $game_user->values and $quest->experience $experience!&nbsp; Complete
//    all ${quest_lower}s in this group for an extra reward.</p>
//EOF;

        if (!empty($quest->completion_sound)) {
          game_sound($quest->completion_sound);
        }

      } // did they get the mission completion bonus?
    }

  }

  $arr = array(
    array(
      '#theme' => 'game_header',
      '#game_user' => $game_user,
    )
  );

  // Show help text for almost new user.
  if ($game_user->experience > 0 && $game_user->level < 6) {
    $arr[] = array(
      '#theme' => 'quests_help_text',
      '#game_user' => $game_user,
    );
  }

  $arr[] = array(
    '#theme' => 'show_goal',
    '#game_user' => $game_user,
  );

  $arr[] = array(
    '#theme' => 'quest',
    '#game_user' => $game_user,
    '#quest' => $quest,
    '#percentageTarget' => $percentage_target,
    '#percentageDivisor' => $percentage_divisor,
    '#questGroup' => $questGroup,
    '#outcome' => $outcome,
    '#experienceAddedHtml' => $experienceAddedHtml,
    '#moneyAddedHtml' => $moneyAddedHtml,
    '#disbursementsDoubled' => $disbursementsDoubled,
  );

  $arr[] = array(
    '#theme' => 'quests_header',
    '#game_user' => $game_user,
    '#qg' => $qg,
    '#qgo' => $qgo,
    '#qgn' => $qgn,
    '#groupToShow' => $group_to_show,
    '#questLocation' => $game_user->location,
  );

  $arr[] = array(
    '#theme' => 'quest_group_completion',
    '#game_user' => $game_user,
    '#questGroup' => $questGroup,
  );

  // Find next quest ID.
  $query = db_select('quest_completion', 'qc')
    ->condition('qc.fkey_users_id', $game_user->id)
    ->condition('qc.percent_complete', 100, '>=')
    ->orderBy('qc.fkey_quests_id', 'DESC')
    ->range(0, 1)
    ->fields('qc', array('fkey_quests_id'));
  $nextQuestId = $query->execute()->fetchField() + 1;
//  dpm($nextQuestId, 'nextQuestId');

  // Show each quest.
  $query = db_select('quests', 'q');
  $query->leftJoin('quest_completion', 'qc', 'qc.fkey_users_id = :id AND qc.fkey_quests_id = q.id',
    array(':id' => $game_user->id));
  $query->condition('q.fkey_quest_groups_id', $group_to_show)
    ->condition('q.id', $nextQuestId, '<=')
    ->orderBy('q.id', 'ASC')
    ->fields('q')
    ->addField('qc', 'percent_complete', 'percent_completed' );
  if ($phone_id != 'abc123') {
    $query->condition('q.active', 1);
  }
  $quests = $query->execute()->fetchAllAssoc('id');

  drupal_add_js(drupal_get_path('module', 'atl') . '/js/quests_list.js');
  foreach ($quests as $quest) {
//    if ($event_type == EVENT_QUESTS_100)
//      $item->required_energy = min($item->required_energy, 100);
    $arr[] = array(
      '#theme' => 'quest',
      '#game_user' => $game_user,
      '#quest' => $quest,
      '#percentageTarget' => $percentage_target,
      '#percentageDivisor' => $percentage_divisor,
      '#questGroup' => $questGroup,
    );
  }

  db_set_active('default');
  return $arr;
}

/*

  if (FALSE || $game_user->level > 1) { // don't show extra quests at first

    $data = array();
    $sql = 'select * from quests ' . $sql_quest_neighborhood .
      ' and required_level = %d ' . $active_quests .
      ' order by required_level ASC;';
    $result = db_query($sql, $game_user->level + 1);

    while ($item = db_fetch_object($result)) $data[] = $item;

    foreach ($data as $item) {

      if ($event_type == EVENT_QUESTS_100)
        $item->required_energy = min($item->required_energy, 100);

      $description = str_replace('%clan', "<em>$clan_title</em>",
        $item->description);

      $active = ($item->active) ? '' : ' (inactive)';

      echo <<< EOF
<div class="quests-soon">
  <div class="quest-name">$item->name $active</div>
  <div class="quest-description">$description</div>
  <div class="quest-required_level">Requires level $item->required_level</div>
  <div class="quest-experience">+$item->experience $experience</div>
  <div class="quest-money">+$item->min_money to $item->max_money
    $game_user->values</div>
  <div class="quest-required_energy">Requires $item->required_energy energy</div>
</div>
EOF;

    }

  }

*/
