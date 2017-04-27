<?php

  if (FALSE /*$game_user->level > 1*/) { // don't show extra quests at first

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
