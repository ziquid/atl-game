<?php

/**
 * @file inc/map.inc
 * Map inc file
 */

/**
 * Map callback function.
 *
 * @param \stdClass $game_user
 *   The game user object.
 *
 * @return array
 *   A render array.
 */
function game_map_callback($game_user) {

  // Don't show home if the user is too new.
  if ($game_user->level < 6) {
    db_set_active('default');
    return array(
      array(
        '#theme' => 'title_image',
      ),
      array(
        '#theme' => 'game_too_new_for_home',
        '#game_user' => $game_user,
      ),
      array(
        '#theme' => 'game_button',
        '#link' => 'quests',
      ),
    );
  }

  $game = check_plain(arg(0));
  $phone_id = $game_user->phone_id;
  db_set_active('game');

  $arr = array(
    array(
      '#theme' => 'game_header',
      '#game_user' => $game_user,
    ),
    array(
      '#theme' => 'game_map',
      '#game_user' => $game_user,
    ),
  );

  drupal_add_js('//unpkg.com/leaflet@1.0.3/dist/leaflet.js');
  drupal_add_css('//unpkg.com/leaflet@1.0.3/dist/leaflet.css', 'external');

  $coords = array(
    'lat' => $game_user->lat,
    'lon' => $game_user->lon,
  );
  drupal_add_js(array('atl' => array('coords' => $coords)), 'setting');

  // Map markers.
  $markers = array();

  // Hoods never visited.
  $query = db_select('neighborhoods', 'n');
  $query->leftJoin(
      'neighborhoods_visited',
      'nv',
      'n.id = nv.fkey_neighborhoods_id AND nv.fkey_users_id = :guid',
      array(':guid' => $game_user->id)
    );
  $query->condition('lat', 0, '<>')
    ->condition('lat', 0, '<>')
    ->fields('n');
  $query->addField('nv', 'timestamp');
  $hoods = $query->execute()->fetchAll();

  foreach ($hoods as $hood) {
    // Only show clouds if user has last visited over a week ago.
    if (time() - strtotime($hood->timestamp) > 604800) {
      $markers[] = array(
        'lat' => $hood->lat,
        'lon' => $hood->lon,
        'type' => 'cloud',
      'text' => '<a href="/' . $game . '/move/' . $phone_id . '/' . $hood->lat .
        '/' . $hood->lon . '">Go to ' . $hood->name . '</a>',
//        'text' => $hood->timestamp,
      );
    }
  }

  // Player's current location.
  $markers[] = array(
    'lat' => $game_user->lat,
    'lon' => $game_user->lon,
    'type' => 'player',
    'text' => '<a href="/' . $game . '/move/' . $phone_id . '/' .
      $game_user->lat . '/' . $game_user->lon . '">Zoom In</a>',
  );

  drupal_add_js(array('atl' => array('markers' => $markers)), 'setting');
  drupal_add_js(drupal_get_path('module', 'atl') . '/js/map.js');

  /*
  global $game, $phone_id;

  $fetch_user = '_' . arg(0) . '_fetch_user';
  $fetch_header = '_' . arg(0) . '_header';

  $game_user = $fetch_user();
  $fetch_header($game_user);
  include(drupal_get_path('module', $game) . '/game_defs.inc');
  $arg2 = check_plain(arg(2));

  $sql = 'select name from neighborhoods where id = %d;';
  $result = db_query($sql, $game_user->fkey_neighborhoods_id);
  $item = db_fetch_object($result);
  $location = $item->name;

  if ($neighborhood_id == $game_user->fkey_neighborhoods_id) {

    echo <<< EOF
<div class="title">You are already in $location</div>
<div class="election-continue"><a href="0">Try again</a></div>
EOF;

    db_set_active('default');
    return;

  }

  if ($neighborhood_id > 0) {

    $sql = 'select * from neighborhoods where id = %d;';
    $result = db_query($sql, $game_user->fkey_neighborhoods_id);
    $cur_hood = db_fetch_object($result);
//firep($cur_hood);

    $sql = 'select * from neighborhoods where id = %d;';
    $result = db_query($sql, $neighborhood_id);
    $new_hood = db_fetch_object($result);
//firep($new_hood);

    $distance = floor(sqrt(pow($cur_hood->xcoor - $new_hood->xcoor, 2) +
      pow($cur_hood->ycoor - $new_hood->ycoor, 2)));

    $actions_to_move = floor($distance / 8);
    $verb = t('Walk');

    $sql = 'SELECT equipment.speed_increase as speed_increase,
      action_verb from equipment

      left join equipment_ownership
        on equipment_ownership.fkey_equipment_id = equipment.id
        and equipment_ownership.fkey_users_id = %d

      where equipment_ownership.quantity > 0

      order by equipment.speed_increase DESC limit 1;';

    $result = db_query($sql, $game_user->id);
    $eq = db_fetch_object($result);

    if ($eq->speed_increase > 0) {

      $actions_to_move -= $eq->speed_increase;
      $verb = t($eq->action_verb);

    }

    $actions_to_move = max($actions_to_move, 6);

    if (($game_user->meta == 'frozen') && ($actions_to_move > 6)) {

      echo <<< EOF
<div class="title">Frozen!</div>
<div class="subtitle">You have been tagged and cannot move more than
  6 actions at a time</div>
<div class="subtitle">Call on a teammate to unfreeze you!</div>
<div class="try-an-election-wrapper"><div
  class="try-an-election"><a href="/$game/home/$arg2">Go to the home page</a></div></div>
<div class="try-an-election-wrapper"><div
  class="try-an-election"><a href="0">Let me choose again</a></div></div>
EOF;

      db_set_active('default');
      return;

    }


    echo <<< EOF
<div class="title">$verb from $cur_hood->name to $new_hood->name</div>
<div class="subtitle">It will cost $actions_to_move Action to move</div>
<div class="try-an-election-wrapper"><div
  class="try-an-election"><a href="/$game/move_do/$arg2/$neighborhood_id">Yes,
  I want to go</a></div></div>
<div class="try-an-election-wrapper"><div
  class="try-an-election"><a href="0">No, let me choose again</a></div></div>
EOF;

    db_set_active('default');
    return;

  }

*/

  db_set_active('default');
  return $arr;
}
