<?php

/**
 * @file quest.inc
 */

/**
 * Get the data ready to show the quest.
 */
function game_preprocess_quest(&$vars) {
//  dpm($vars, 'vars');
  $vars += array(
    'classes_array' => [],
    'attributes_array' => [],
    'title_attributes_array' => [],
    'content_attributes_array' => [],
    'game' => check_plain(arg(0)),
    'arg2' => check_plain(arg(2)),
  );

  /*

    $money_added_str = '', $disbursements_doubled = '',
    $consumption_html = '', $disbursement_html = '',
    $quest_completion_html = '') {

    static $location;

    if (empty($location)) {

      $sql = 'select name from `neighborhoods` where id = %d;';
      $result = db_query($sql, $game_user->fkey_neighborhoods_id);
      $data = db_fetch_object($result);
      $location = preg_replace('/^The /', '', $data->name);

    }

    $sql = 'select id from quests where `group` = %d
      order by id asc limit 1;';
    $result = db_query($sql, $item->group);
    $data = db_fetch_object($result);
    $seq_num = $item->id - $data->id;

    if (substr($item->description, 0, 3) != '<p ') $laquo = '&laquo;';
    if (substr($item->description, -1) != '>') $raquo = '&raquo;';

    $name = t($item->name, array(
      '@clan' => $game_user->clan_name,
      '@hood' => $hood,
      '@location' => $location,
      '%party' => $party_title,
      '@username' => $game_user->username,
    ));

    $description = t($item->description, array(
      '@clan' => $game_user->clan_name,
      '@hood' => $hood,
      '@location' => $location,
      '%party' => $party_title,
      '@username' => $game_user->username,
    ));
  */
//  dpm($vars['quest'], 'quest');
  if (empty($vars['quest']->percent_complete)) {
    $vars['quest']->percent_complete = 0;
  }

  // Get RGB color for percent_complete.
  if ($vars['quest']->percent_complete > floor($vars['percentageTarget'] / 2)) {
    $vars['rgb'] = dechex(floor(($vars['percentageTarget'] - $vars['quest']->percent_complete) /
      (4 * $vars['percentageDivisor']))) . 'c0';
  }
  else {
    $vars['rgb'] = 'c' . dechex(floor(($vars['quest']->percent_complete) /
      (4 * $vars['percentageDivisor']))) . '0';
  }

  $vars['width'] = floor($vars['quest']->percent_complete * 94 / $vars['percentageTarget']) + 2;
  $vars['active'] = ($vars['quest']->active) ? '' : ' (inactive)';
  /*
    if (strpos($item->meta, 'use_job_picture') !== FALSE) {

      $sql = 'SELECT land.id FROM `land_ownership`
        LEFT JOIN land ON fkey_land_id = land.id
        WHERE fkey_users_id = %d
        AND land.type = "job";';
      $result = db_query($sql, $game_user->id);
      $job = db_fetch_object($result);

      $img = '/sites/default/files/images/land/' . "$game-$job->id.png?3";

    } else {

      $img = '/sites/default/files/images/quests/' . "$game-$item->id.png?3";

    }
  */
  $vars['img'] = '//placeholdit.imgix.net/~text?txtsize=20&txt=Mission+Picture&w=96&h=144&txttrack=1';
  /*
    if ($item->land_required_quantity +
      $item->equipment_1_required_quantity +
      $item->equipment_2_required_quantity +
      $item->equipment_3_required_quantity +
      $item->clan_equipment_1_required_quantity +
      $item->staff_required_quantity > 0) {

        echo <<< EOF
      <div class="quest-requisites">
        // Requisites //
      </div>
  EOF;

    // required land

        if ($item->land_required_quantity > 0)
          _required_land($game_user, $item->fkey_land_required_id,
            $item->land_required_quantity);

    // required equipment

        if ($item->equipment_1_required_quantity +
          $item->equipment_2_required_quantity +
          $item->equipment_3_required_quantity +
          $item->clan_equipment_1_required_quantity > 0) {

          echo '<div class="quest-required_stuff">';

          if ($item->equipment_1_required_quantity > 0)
            _required_equipment($game_user, $item->fkey_equipment_1_required_id,
              $item->equipment_1_required_quantity);

          if ($item->equipment_2_required_quantity > 0)
            _required_equipment($game_user, $item->fkey_equipment_2_required_id,
              $item->equipment_2_required_quantity);

          if ($item->equipment_3_required_quantity > 0)
            _required_equipment($game_user, $item->fkey_equipment_3_required_id,
              $item->equipment_3_required_quantity);

          if ($item->clan_equipment_1_required_quantity > 0)
            _clan_required_equipment($game_user,
              $item->fkey_clan_equipment_1_required_id,
              $item->clan_equipment_1_required_quantity);

          echo '</div>';

        }

    // required staff

        if ($item->staff_required_quantity > 0)
          _required_staff($game_user, $item->fkey_staff_required_id,
            $item->staff_required_quantity);

    // required party

        if ($item->need_party > 0)
          echo <<< EOF
      <div class="quest-required_energy">
        You must belong to a non-Underground $party_lower
      </div>
  EOF;

    // required clan

        if ($item->need_clan > 0)
          echo <<< EOF
      <div class="quest-required_energy">
        You must belong to a clan
      </div>
  EOF;

    // required job

        if ($item->need_job > 0)
          echo <<< EOF
      <div class="quest-required_energy">
        You must have a job
      </div>
  EOF;

      } // requirement


  */
}
