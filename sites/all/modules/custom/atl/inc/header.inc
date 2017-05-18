<?php

function game_preprocess_header(&$vars) {
//    dpm($vars, 'vars at game_preprocess_header');
  $vars += array(
    'classes_array' => [],
    'attributes_array' => [],
    'title_attributes_array' => [],
    'content_attributes_array' => [],
  );

//   global $game, $phone_id, $extra_messages, $cur_level, $next_level;
  include drupal_get_path('module', 'atl') . '/inc/common/game_defs.inc';
  $game_user = $vars['game_user'];
  $vars['game'] = $arg0 = check_plain(arg(0));
  $vars['arg2'] = $arg2 = check_plain(arg(2));

  // Energy.
  $energy_text = '&nbsp;';
  $energy_minutes = $energy_seconds = 0;
  if ($game_user->energy != $game_user->energy_max) {
    $energy_secs_until = strtotime($game_user->energy_next_gain) - REQUEST_TIME;
    $energy_minutes = (string) (int) ($energy_secs_until / 60);
    $energy_seconds = sprintf('%02d', (int) ($energy_secs_until % 60));
    $energy_text = '+' . $game_user->energy_bonus . ' in ' .
      $energy_minutes . ':' . $energy_seconds;
  }

  $vars['energyText'] = $energy_text;

  // Actions.
  $actions_text = '&nbsp;';

  if ($game_user->actions != $game_user->actions_max) {
    $actions_secs_until = strtotime($game_user->actions_next_gain) - REQUEST_TIME;
    $actions_minutes = (string) (int) ($actions_secs_until / 60);
    $actions_seconds = sprintf('%02d', (int) ($actions_secs_until % 60));
    $actions_text = ($game_user->actions > $game_user->actions_max ? '-' : '+')
    . '1 in ' . $actions_minutes . ':' . $actions_seconds;
  }
  else {
    $actions_minutes = $actions_seconds = 0;
  }

  $vars['actionsText'] = $actions_text;

  // Income.
  $income_text = '&nbsp;';
  $income_bonus = $game_user->income - $game_user->expenses;

  if ($income_bonus != 0) {
    $income_str = $income_bonus . '';
    $money_secs_until = strtotime($game_user->income_next_gain) - REQUEST_TIME;
    $money_minutes = (string) (int) ($money_secs_until / 60);
    $money_seconds = sprintf('%02d', (int) ($money_secs_until % 60));
    $money_secondsStr = ':' . sprintf('%02d', (int) ($money_secs_until % 60));

    if (strlen($income_str) > 6) {
      $income_str = substr($income_str, 0, strlen($income_str) - 3) . 'K';
      $money_secondsStr = 'm';
    }

    $income_text = '+' . $income_str . ' in ' . $money_minutes
    . $money_secondsStr;
  }
  else {
    $money_minutes = $money_seconds = 0;
  }

  $money_str = $game_user->money . '';

  if (strlen($money_str) > 8) {
    $money_str = substr($money_str, 0, strlen($money_str) - 6) . 'M';
  } elseif (strlen($money_str) > 5) {
    $money_str = substr($money_str, 0, strlen($money_str) - 3) . 'K';
  }

  $vars['moneyStr'] = $money_str;
  $vars['incomeText'] = $income_text;

  // Level -- highlight if skill points are available.
  if ($game_user->skill_points > 0) {
    $level_text = '<div><strong><a href="/' . $arg0
    . '/increase_skills/' . $arg2 . '/none">' . $game_user->level
    . '!</a></strong><div class="level-text">' . t('Level') . '</div></div>';
  }
  else {
    $level_text = '<div><strong>' . $game_user->level
    . '</strong><div class="level-text">' . t('Level') .'</div></div>';
  }

  $vars['level_text'] = $level_text;

  // Experience.
  $vars['experience_pct'] = '•' . floor(
    ($game_user->experience - $game_user->cur_level) /
    ($game_user->next_level - $game_user->cur_level)
    * 100) . '%';

  /*
// event points
  $sql = 'select points, last_goal_achieved
    from event_points where fkey_users_id = %d;';
  $result = db_query($sql, $game_user->id);
  $points_obj = db_fetch_object($result);

  $points_text = '';

  if ($points_obj->points > 0) { // user has some points

    $sql = 'select points from event_milestones where points > %d
      order by points asc limit 1;';
    $result = db_query($sql, $points_obj->last_goal_achieved);
    $goal_obj = db_fetch_object($result);

    if ($goal_obj->points == 0) $goal_obj->points = 99999999;

firep('points: ' . $points_obj->points);
firep('points for next prize: ' . $goal_obj->points);

    if ($points_obj->points >= $goal_obj->points) { // user gets a prize!

firep('a prize is deserved!');

// what's goal after this?
      $sql = 'select points from event_milestones where points > %d
        order by points asc limit 1;';
      $result = db_query($sql, $goal_obj->points);
      $new_goal_obj = db_fetch_object($result);

      if ($new_goal_obj->points == 0) $new_goal_obj->points = 99999999;

// which prize should be given?
      if ($goal_obj->points >= 50000) {
        $prize_id = 37; // large gift
      } else if ($goal_obj->points >= 5000) {
        $prize_id = 36; // med gift
      } else {
        $prize_id = 35; // small gift
      }

// does user have any of this present?
      $sql = 'select quantity from equipment_ownership
        where fkey_users_id = %d
        and fkey_equipment_id = %d;';
      $result = db_query($sql, $game_user->id, $prize_id);
      $equip_quantity = db_fetch_object($result);

      if (empty($equip_quantity)) { // create record

        $sql = 'insert into equipment_ownership
          (fkey_users_id, fkey_equipment_id, quantity)
          values
          (%d, %d, 1);';
// if ($phone_id == 'abc123')
        $result = db_query($sql, $game_user->id, $prize_id);

      } else { // update record

        $sql = 'update equipment_ownership
          set quantity = quantity + 1
          where fkey_users_id = %d
          and fkey_equipment_id = %d;';
// if ($phone_id == 'abc123')
        $result = db_query($sql, $game_user->id, $prize_id);

      } // create or update record

// update record of user getting this present
      $sql = 'update event_points set last_goal_achieved = %d
        where fkey_users_id = %d;';
// if ($phone_id == 'abc123')
      $result = db_query($sql, $goal_obj->points, $game_user->id);

// get present title
      $sql = 'select name from equipment
        where id = %d;';
      $result = db_query($sql, $prize_id);
      $equip_obj = db_fetch_object($result);
      $equip_name = str_replace(' ', '&nbsp;', strtolower($equip_obj->name));

// if ($phone_id == 'abc123')
      $points_text = '<div class="subsubtitle">
        Points: ' . $points_obj->points . ' &nbsp; Next prize at: ' .
        $new_goal_obj->points . ' points
      </div>
      <div class="level-up">
        <div class="level-up-header">Prize Received!</div>
        <div class="level-up-image">
          <img src="/sites/default/files/images/equipment/' .
          $game . '-' . $prize_id . '.png" width="96">
        </div>
        <div class="level-up-text">For gaining ' . $goal_obj->points .
          ' points, you have received a bonus of <strong>one&nbsp;' .
          $equip_name . '!</strong></div>
        <div class="level-up-text">Look for another bonus at ' .
          $new_goal_obj->points . '&nbsp;points.</div>
      </div>';

    } else { // user doesn't get a prize

// if ($phone_id == 'abc123')
      $points_text = '<div class="subsubtitle">
        Points: ' . $points_obj->points . ' &nbsp; Next prize at: ' .
        $goal_obj->points . ' points
      </div>';

    } // does user get a prize?

  } // user has no points
  */

  drupal_add_js(
    array(
      'atl' => array(
        'gameSettings' => array(
          'energyMinutes' => (int) $energy_minutes,
          'energySeconds' => (int) $energy_seconds,
          'moneyMinutes' => $money_minutes,
          'moneySeconds' => $money_seconds,
          'moneyBonus' => $income_bonus,
          'actionsMinutes' => $actions_minutes,
          'actionsSeconds' => $actions_seconds,
        )
      )
    ),
    'setting'
  );

  $vars['scripts'] = drupal_get_js();

}
