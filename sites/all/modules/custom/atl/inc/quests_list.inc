<?php

/**
 * @file inc/quests_list.inc
 */

/**
 * Home page callback function.
 *
 * @param \stdClass $game_user
 *   The game user object.
 *
 * @return array
 *   A render array.
 */
function game_quests_list_callback($game_user) {

  // Don't let them do quests at levels 6-25 without being in a party.
  if ($game_user->fkey_values_id == 0 && $game_user->level >= 6 &&
    $game_user->level <= 25) {
    game_goto('choose_party', '0');
  }

  $game = check_plain(arg(0));
  $phone_id = $game_user->phone_id;
  db_set_active('game');

  $arr = array(
    array(
      '#theme' => 'game_header',
      '#game_user' => $game_user,
    )
  );

  // Which quest group to show.
  $group_to_show = 0;
  if (is_numeric(arg(3)) && $game_user->level >= 6) {
    $group_to_show = arg(3);
  }
  else {
    $group_to_show = $game_user->fkey_last_played_quest_groups_id;
  }
  $sql_quest_neighborhood = 'where `group` = ' . $group_to_show;

  // @todo: Quests menu.
  if (FALSE || $game_user->level >= 6) {

    if ($group_to_show >= 1000) {
      $merch_active = '';
      $lehite_active = '';
    } elseif ($group_to_show >= 100) {
      $merch_active = 'active';
      $lehite_active = '';
    } else {
      $merch_active = '';
      $lehite_active = 'active';
    }

    $sql = 'select quantity from `equipment_ownership` where
      fkey_equipment_id = 36 and fkey_users_id = %d;';
    $result = db_query($sql, $game_user->id);
    $data = db_fetch_object($result);

    if ($game_user->fkey_values_id == 5 || $data->quantity > 0) {
      $merch_url = '/' . $game . '/quests/' . $arg2 . '/100';
    } else {
      $merch_url = '#';
    }

    echo <<< EOF
<div class="news">
  <a href="/$game/quests/$arg2/0" class="button $lehite_active">Lehites</a>
  <a href="$merch_url"
    class="button $merch_active">Merchants</a>
</div>
EOF;

  }

  // Show more welcome text for new user.
  if ($game_user->experience == 0) {
    $arr[] = array(
      '#theme' => 'quests_welcome_text'
    );
  }

  // Show help text for almost new user.
  if ($game_user->experience > 0 && $game_user->level < 6) {
    $arr[] = array(
      '#theme' => 'quests_help_text'
    );
  }

  $arr[] = array(
    '#theme' => 'show_goal',
    '#game_user' => $game_user,
  );

  // Party welcome message.
  if (!game_get_value($game_user, 'seen_party_welcome', FALSE) && $game_user->level >= 6) {
    $arr[] = array(
      '#theme' => 'party_welcome',
    );
    game_set_value($game_user, 'seen_party_welcome', TRUE);
  }

  db_set_active('default');
  return $arr;
}

/*
  $sql = 'select name from quest_groups where id = %s;';
  $result = db_query($sql, $group_to_show);
  $qg = db_fetch_object($result);
firep($qg);

  $location = str_replace('%location', $location, $qg->name);
  if ($game_user->level < 6) $location = '';

  $sql = 'select name from quest_groups where id = %s;';
  $result = db_query($sql, $group_to_show - 1);
  $qgo = db_fetch_object($result);

  if (!empty($qgo->name)) {

    $older_group = $group_to_show - 1;
    $older_missions_html =<<< EOF
<a href="/$game/quests/$arg2/$older_group">
  <span class="arrows big">&lsaquo;&lsaquo;&lsaquo;</span>
</a>
EOF;

  } else {

    $older_missions_html = '<span class="arrows big">&lsaquo;&lsaquo;</span>';

  }

  $sql = 'select min(required_level) as min from quests
    where `group` = %d;';
  $result = db_query($sql, $group_to_show + 1);
  $item = db_fetch_object($result);
firep($item);

  if (!empty($item->min) && ($item->min <= $game_user->level + 1) &&
    ($group_to_show <= 1000)) {

    $newer_group = $group_to_show + 1;
    $newer_missions_html =<<< EOF
<a href="/$game/quests/$arg2/$newer_group">
  <span class="arrows big">&rsaquo;&rsaquo;&rsaquo;</span>
</a>
EOF;

  } else {

    $newer_missions_html = '<span class="arrows big">&rsaquo;&rsaquo;</span>';

  }

  echo <<< EOF
<div class="title">
  <span class="left">$older_missions_html</span>
  <span class="middle">Chapter $group_to_show:<br/>$location</span>
  <span class="right">$newer_missions_html</span>
</div>
EOF;

// abc123 -- show all quests
  $active_quests = ($phone_id == 'abc123') ? '' : 'and quests.active = 1';

// get quest group stats
  $sql = 'SELECT sum(bonus_given) as completed, count(quests.id) as total
    FROM `quests`
    left outer join quest_completion
    on quest_completion.fkey_quests_id = quests.id
    and fkey_users_id = %d
    where `group` = %d ' . $active_quests . ';';
  $result = db_query($sql, $game_user->id, $group_to_show);

  $quest_group = db_fetch_object($result);
firep($quest_group);

  $quest_group->completed += 0; // haha!  typecasting!

  $sql = 'SELECT times_completed FROM `quest_group_completion`
    where fkey_users_id = %d and fkey_quest_groups_id = %d;';
  $result = db_query($sql, $game_user->id, $group_to_show);
  $quest_group_completion = db_fetch_object($result);

  $percentage_target = 100;
  $percentage_divisor = 1;

  if ($quest_group_completion->times_completed > 0) {

    $next_group_html = t('(2nd round)');
    $percentage_target = 200;
    $percentage_divisor = 2;
    $quest_group->completed -=
      ($quest_group->total * min($quest_group_completion->times_completed, 1));

  }

  echo <<< EOF
<div class="quest-group-completion">
  <strong>$quest_group->completed</strong> of $quest_group->total {$quest}s
  complete $next_group_html
</div>
EOF;

// show each quest
  $data = array();

  $sql = 'select fkey_quests_id from quest_completion
    where fkey_users_id = %d
    and percent_complete >= 100
    order by fkey_quests_id DESC
    limit 1;';
  $result = db_query($sql, $game_user->id);
  $item = db_fetch_object($result);
  $next_quest = $item->fkey_quests_id + 1;

  $sql = 'select quests.*, quest_completion.percent_complete from quests
    LEFT OUTER JOIN quest_completion
    ON quest_completion.fkey_quests_id = quests.id
    AND quest_completion.fkey_users_id = %d
    ' . $sql_quest_neighborhood .
    ' and quests.id <= %d ' . $active_quests .
    ' order by quests.id DESC;';
firep($sql);
  $result = db_query($sql, $game_user->id, $next_quest);

  while ($item = db_fetch_object($result)) $data[] = $item;

  foreach ($data as $item) {

    if ($event_type == EVENT_QUESTS_100)
      $item->required_energy = min($item->required_energy, 100);
    _show_quest($game_user, $item, $percentage_target,
      $percentage_divisor, $quest_group, $party_title);

  }

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

  db_set_active('default');
*/
