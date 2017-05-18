<?php



// required equipment 1?
  if ($quest->equipment_1_required_quantity > 0) {

    $sql = 'select quantity from equipment_ownership
      where fkey_equipment_id = %d and fkey_users_id = %d;';
    $result = db_query($sql, $quest->fkey_equipment_1_required_id,
      $game_user->id);
    $quantity = db_fetch_object($result);

    if ($quantity->quantity < $quest->equipment_1_required_quantity) {

      $questSucceeded = FALSE;
      $outcomeHtml = '<div class="quests failed">
          <div class="title">' .
            t('∆ Equipment Requisite ∆<br/><span>Missing</span>') . '
          </div>
          <div class="quest-required">
            <a href="/' . $game . '/equipment_buy/' . $arg2 . '/' .
              $quest->fkey_equipment_1_required_id . '/' .
              ($quest->equipment_1_required_quantity - $quantity->quantity)
              . '">
              <img width="48"
                src="/sites/default/files/images/equipment/' .
                $game . '-' . $quest->fkey_equipment_1_required_id .
                '.png" />
            </a>
            <div class="quest-required-num">
              x' . $quest->equipment_1_required_quantity . '
            </div>
          </div>
        </div>';
      $ai_output = 'quest-failed need-equipment-' .
        $quest->fkey_equipment_1_required_id;

      competency_gain($game_user, 'hole in pockets');
    }

  } // no required equipment_1

// required equipment 2?
  if ($quest->equipment_2_required_quantity > 0) {

    $sql = 'select quantity from equipment_ownership
      where fkey_equipment_id = %d and fkey_users_id = %d;';
    $result = db_query($sql, $quest->fkey_equipment_2_required_id,
      $game_user->id);
    $quantity = db_fetch_object($result);

    if ($quantity->quantity < $quest->equipment_2_required_quantity) {

      $questSucceeded = FALSE;
      $outcomeHtml = '<div class="quest-failed">' . t('Failed!') .
        '</div><div class="quest-required_stuff missing centered">Missing
        <div class="quest-required_equipment"><a href="/' . $game . '/equipment_buy/' .
        $arg2 . '/' . $quest->fkey_equipment_2_required_id . '/' .
        ($quest->equipment_2_required_quantity - $quantity->quantity) . '"><img
        src="/sites/default/files/images/equipment/' .
        $game . '-' . $quest->fkey_equipment_2_required_id . '.png"
        width="48"></a></div>&nbsp;x' . $quest->equipment_2_required_quantity .
        '</div>';
      $ai_output = 'quest-failed need-equipment-' .
        $quest->fkey_equipment_2_required_id;

      competency_gain($game_user, 'hole in pockets');

    }

  } // no required equipment_2

// required equipment 3?
  if ($quest->equipment_3_required_quantity > 0) {

    $sql = 'select quantity from equipment_ownership
      where fkey_equipment_id = %d and fkey_users_id = %d;';
    $result = db_query($sql, $quest->fkey_equipment_3_required_id,
      $game_user->id);
    $quantity = db_fetch_object($result);

    if ($quantity->quantity < $quest->equipment_3_required_quantity) {

      $questSucceeded = FALSE;
      $outcomeHtml = '<div class="quest-failed">' . t('Failed!') .
        '</div><div class="quest-required_stuff missing centered">Missing
        <div class="quest-required_equipment"><a href="/' . $game . '/equipment_buy/' .
        $arg2 . '/' . $quest->fkey_equipment_3_required_id . '/' .
        ($quest->equipment_3_required_quantity - $quantity->quantity) . '"><img
        src="/sites/default/files/images/equipment/' .
        $game . '-' . $quest->fkey_equipment_3_required_id . '.png"
        width="48"></a></div>&nbsp;x' . $quest->equipment_3_required_quantity .
        '</div>';
      $ai_output = 'quest-failed need-equipment-' .
        $quest->fkey_equipment_3_required_id;
    }

      competency_gain($game_user, 'hole in pockets');
  } // no required equipment_3

  // required clan equipment 1?
  if ($quest->clan_equipment_1_required_quantity > 0) {

    $sql = 'select quantity from clan_equipment_ownership
      where fkey_equipment_id = %d and fkey_clans_id = %d;';
    $result = db_query($sql, $quest->fkey_clan_equipment_1_required_id,
      $game_user->fkey_clans_id);
    $quantity = db_fetch_object($result);

    if ($quantity->quantity < $quest->clan_equipment_1_required_quantity) {

      $questSucceeded = FALSE;
      $outcomeHtml = '<div class="quests failed">
        <div class="title">' .
          t('∆ Requisite <span>Missing</span> ∆',
          array('@party' => $party_lower)) . '
        </div>
        <div class="equipment-required-wrapper">
          <div class="equipment-required missing">
            <img src="/sites/default/files/images/equipment/' . $game . '-' .
              $quest->fkey_clan_equipment_1_required_id . '.png"
              width="48"/>
            <span class="required-num">
              x ' . $quest->clan_equipment_1_required_quantity . '
            </span>
          </div>
        </div>
        <div class="subtitle">
          (Hint: Help your clan create more)
        </div>
      </div>';
      $ai_output = 'quest-failed need-equipment-' .
        $quest->fkey_clan_equipment_1_required_id;
    }

  } // no required clan equipment_1

// required staff 1?
  if ($quest->staff_required_quantity > 0) {

    $sql = 'select quantity from staff_ownership
      where fkey_staff_id = %d and fkey_users_id = %d;';
    $result = db_query($sql, $quest->fkey_staff_required_id,
      $game_user->id);
    $quantity = db_fetch_object($result);

    if ($quantity->quantity < $quest->staff_required_quantity) {

      $questSucceeded = FALSE;
      $outcomeHtml = '<div class="quest-failed">' . t('Failed!') .
        '</div><div class="quest-required_stuff missing centered">Missing
        <div class="quest-required_equipment"><img
        src="/sites/default/files/images/staff/' .
        $game . '-' . $quest->fkey_staff_required_id . '.png"
        width="48"></div>&nbsp;x' . $quest->staff_required_quantity .
        '</div>';
      $ai_output = 'quest-failed need-staff-' .
        $quest->fkey_staff_required_id;

      competency_gain($game_user, 'friendless');

    }

  } // no required staff

// required party?
  if (($quest->need_party > 0) && $game_user->fkey_values_id == 0) {

    $questSucceeded = FALSE;
    $outcomeHtml = '<div class="quests failed">
      <div class="title">' .
        t('∆ @party Affiliation <span>Unrecognized</span> ∆',
        array('@party' => $party_lower)) . '
      </div>
      <div class="try-an-election-wrapper">
        <div class="try-an-election">
          <a href="/' . $game . '/choose_clan/' . $arg2 . '/0">' .
            t('Join a @party', array('@party' => $party_lower)) . '
          </a>
        </div>
      </div>
    </div>';
    $ai_output = 'quest-failed need-party';

  } // no required party

// required clan?
  if (($quest->need_clan > 0) && $game_user->fkey_clans_id == 0) {

    $questSucceeded = FALSE;
    $outcomeHtml = '<div class="quests failed">
      <div class="title">' .
        t('∆ Clan Affiliation ∆<br/><span>Unrecognized</span>') . '
      </div>
      <div class="try-an-election-wrapper">
        <div class="try-an-election">
          <a href="/' . $game . '/clan_list_available/' . $arg2 . '">' .
            t('Find a clan') . '
          </a>
        </div>
      </div>
    </div>';
    $ai_output = 'quest-failed need-clan';
      competency_gain($game_user, 'homeless');

  } // no required clan

// required job?
  if ($quest->need_job > 0) {

    $sql = 'SELECT COUNT(*) AS jobs FROM `land_ownership`
      LEFT JOIN land ON fkey_land_id = land.id
      WHERE fkey_users_id = %d
      AND land.id > 0
      AND land.type = "job";';
    $result = db_query($sql, $game_user->id);
    $quantity = db_fetch_object($result);

    if ($quantity->jobs < 1) {
// wrong hood
  if (($quest->group > 0) && ($quest->fkey_neighborhoods_id != 0) &&
    ($quest->fkey_neighborhoods_id != $game_user->fkey_neighborhoods_id)) {

      $questSucceeded = FALSE;
      $outcomeHtml = '<div class="quests failed">
        <div class="title">' .
          t('∆ Employment <span>Nonexistant</span> ∆') . '
    $questSucceeded = FALSE;
    $outcomeHtml = '<div class="quest-failed">'
    . t('Wrong @hood!', array('@hood' => $hood_lower))
    . '</div>
        <p>This ' . $quest_lower . ' can only be completed in '
        . $quest->hood . '.
        </p>
      <div class="try-an-election-wrapper">
        <div class="try-an-election">
          <a href="/' . $game . '/move/' . $arg2 . '/'
          . $quest->fkey_neighborhoods_id . '">
            Go there
          </a>
        </div>
        <div class="try-an-election-wrapper">
          <div class="try-an-election">
            <a href="/' . $game . '/land/' . $arg2 . '">' .
              t('Get a Job') . '
            </a>
          </div>
        </div>
      </div>';
      $ai_output = 'quest-failed need-job';
    $extra_html = '<p>&nbsp;</p><p class="second">&nbsp;</p>';
    $ai_output = 'quest-failed wrong-hood';

    }
    competency_gain($game_user, 'lost');

  } // no required job
  } // wrong hood



  if ($questSucceeded) {

    if ($percent_complete == $percentage_target) {

// did they complete all quests in the group?

      $sql = 'select * from quest_group_completion
        where fkey_users_id = %d and fkey_quest_groups_id = %d;';
      $result = db_query($sql, $game_user->id, $quest->group);
      $qgc = db_fetch_object($result);
//firep($qgc);

      if (empty($qgc) || $qgc->times_completed == 0) {
// if no quest_group bonus has been given

// get quest group stats
        $sql = 'SELECT sum( bonus_given ) AS completed,
          count( quests.id ) AS total, quest_groups.ready_for_bonus
          FROM `quests`
          LEFT OUTER JOIN quest_completion
          ON quest_completion.fkey_quests_id = quests.id
          AND fkey_users_id = %d
          LEFT JOIN quest_groups
          ON quests.group = quest_groups.id
          WHERE `group` = %d
          AND quests.active =1';
        $result = db_query($sql, $game_user->id, $quest->group);
        $quest_group = db_fetch_object($result);
//firep($quest_group);

        if (($quest_group->completed == $quest_group->total) &&
          ($quest_group->ready_for_bonus == 1)) {
// woohoo!  user just completed an entire group!

          $quest_completion_html .=<<< EOF
<div class="title loot">Congratulations!</div>
<p>You have completed all {$quest_lower}s in this group and have gained extra skill
  points!</p>
<p class="second"><a href="/$game/increase_skills/$arg2/none">You
  have <span class="highlighted">$quest_group->completed</span> new skill points
  to spend</a></p>
EOF;
          competency_gain($game_user, 'quest groupie', 3);

// update user stats
          $sql = 'update users set skill_points = skill_points + %d
            where id = %d;';
          $result = db_query($sql, $quest_group->completed, $game_user->id);

// update quest_groups_completion
          if (empty($qgc)) { // no record exists - insert one

            $sql = 'insert into quest_group_completion (fkey_users_id,
              fkey_quest_groups_id, times_completed) values (%d, %d, 1);';
            $result = db_query($sql, $game_user->id, $quest->group);

          } else { // existing record - update it

            $sql = 'update quest_group_completion set times_completed = 1
              where fkey_users_id = %d and fkey_quest_groups_id = %d;';
            $result = db_query($sql, $game_user->id, $quest->group);

          } // insert or update the qgc record

          $quest_group_completion->times_completed = 1;
          $percentage_target = 200;
          $percentage_divisor = 2;

        } // if quest group completed

      } // if no quest_group bonus has been given

      if ($qgc->times_completed == 1) { // what?  they've completed a 2nd time?

// get quest group stats
        $sql = 'SELECT sum( bonus_given ) AS completed,
          count( quests.id ) AS total, quest_groups.ready_for_bonus
          FROM `quests`
          LEFT OUTER JOIN quest_completion
          ON quest_completion.fkey_quests_id = quests.id
          AND fkey_users_id = %d
          LEFT JOIN quest_groups
          ON quests.group = quest_groups.id
          WHERE `group` = %d
          AND quests.active =1';
        $result = db_query($sql, $game_user->id, $quest->group);
        $quest_group = db_fetch_object($result);
//firep($quest_group);

        if ($quest_group->completed == ($quest_group->total * 2)) {
// woohoo!  user just completed an entire group the second time!

          competency_gain($game_user, 'second-mile saint', 3);

          $sql = 'select * from quest_group_bonus
            where fkey_quest_groups_id = %d;';
          $result = db_query($sql, $quest->group);
          $item = db_fetch_object($result); // limited to 1 in db
//firep($item);
          $eq_id = $item->fkey_equipment_id;
          $land_id = $item->fkey_land_id;
          $st_id = $item->fkey_staff_id;

          if (($eq_id + $land_id + $st_id) > 0) {
// anything to give him/her?

            if ($eq_id > 0) { // equipment bonus

              equipment_gain($game_user, $eq_id, 1);

              $sql = 'select * from equipment
                where id = %d;';
              $result = db_query($sql, $eq_id);
              $game_equipment = db_fetch_object($result); // limited to 1 in db

// tell the user about it
              $quest_completion_html .=<<< EOF
<div class="quest-succeeded title loot">Congratulations!</div>
<div class="subsubtitle">You have completed the second round of {$quest_lower}s!</div>
<div class="subsubtitle">Here is your bonus:</div>
<div class="quest-icon"><img
 src="/sites/default/files/images/equipment/$game-{$eq_id}.png" width="96"></div>
<div class="quest-details">
  <div class="quest-name loot">$game_equipment->name</div>
  <div class="quest-description">$game_equipment->description</div>
EOF;

              if ($game_equipment->energy_bonus > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Energy: +$game_equipment->energy_bonus immediate energy bonus
      </div>
EOF;

              } // energy bonus?

              if ($game_equipment->energy_increase > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Energy: +$game_equipment->energy_increase every $energy_wait_str
      </div>
EOF;

              } // energy increase?

              if ($game_equipment->initiative_bonus > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">$initiative: +$game_equipment->initiative_bonus
      </div>
EOF;

              } // initiative bonus?

              if ($game_equipment->endurance_bonus > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Endurance: +$game_equipment->endurance_bonus
      </div>
EOF;

              } // endurance bonus?

              if ($game_equipment->elocution_bonus > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">$elocution: +$game_equipment->elocution_bonus
      </div>
EOF;

              } // elocution bonus?

              if ($game_equipment->speed_increase > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Speed Increase: $game_equipment->speed_increase fewer Action
      needed to move to a new $hood_lower
      </div>
EOF;

              } // speed increase?

              if ($game_equipment->upkeep > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout negative">Upkeep: $game_equipment->upkeep every 60 minutes</div>
EOF;

              } // upkeep

              if ($game_equipment->chance_of_loss > 0) {

                $lifetime = floor(100 / $game_equipment->chance_of_loss);
                $use = ($lifetime == 1) ? 'use' : 'uses';
                $quest_completion_html .=<<< EOF
    <div class="quest-payout negative">Expected Lifetime: $lifetime $use</div>
EOF;

              } // expected lifetime

              $quest_completion_html .= '</div>';

            } // equipment bonus

            // FIXME: land bonus here


            if ($st_id > 0) { // staff bonus

              $data = array();
              $sql = 'SELECT staff.*, staff_ownership.quantity
                FROM staff

                LEFT OUTER JOIN staff_ownership
                ON staff_ownership.fkey_staff_id = staff.id
                AND staff_ownership.fkey_users_id = %d

                WHERE staff.id = %d;';
              $result = db_query($sql, $game_user->id, $st_id);
              $game_staff = db_fetch_object($result); // limited to 1 in DB

// give the stuff
              if ($game_staff->quantity == '') { // no record exists - insert one

                $sql = 'insert into staff_ownership
                  (fkey_staff_id, fkey_users_id, quantity)
                  values (%d, %d, %d);';
                $result = db_query($sql, $st_id, $game_user->id, 1);

              } else { // existing record - update it

                $sql = 'update staff_ownership set quantity = quantity + 1 where
                  fkey_staff_id = %d and fkey_users_id = %d;';
                $result = db_query($sql, $st_id, $game_user->id);

              } // insert or update record

// tell the user about it
              $quest_completion_html .=<<< EOF
<div class="quest-succeeded title loot">Congratulations!</div>
<div class="subsubtitle">You have completed the second round of {$quest_lower}s!</div>
<div class="subsubtitle">Here is your bonus:</div>
<div class="quest-icon"><img
 src="/sites/default/files/images/staff/$game-{$st_id}.png" width="96"></div>
<div class="quest-details">
  <div class="quest-name loot">$game_staff->name</div>
  <div class="quest-description">$game_staff->description</div>
EOF;

              if ($game_staff->energy_bonus > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Energy: +$game_staff->energy_bonus immediate energy bonus
      </div>
EOF;

              } // energy bonus?

              if ($game_staff->energy_increase > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Energy: +$game_staff->energy_increase every $energy_wait_str
      </div>
EOF;

              } // energy increase?

              if ($game_staff->initiative_bonus > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">$initiative: +$game_staff->initiative_bonus
      </div>
EOF;

              } // initiative bonus?

              if ($game_staff->endurance_bonus > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">$endurance: +$game_staff->endurance_bonus
      </div>
EOF;

              } // endurance bonus?

              if ($game_staff->elocution_bonus > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">$elocution: +$game_staff->elocution_bonus
      </div>
EOF;

              } // elocution bonus?

              if ($game_staff->speed_increase > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Speed Increase: $game_staff->speed_increase fewer Action
      needed to move to a new $hood_lower
      </div>
EOF;

              } // speed increase?

              if ($game_staff->extra_votes > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Extra Votes: $game_staff->extra_votes</div>
EOF;

              } // extra votes

              if ($game_staff->extra_defending_votes > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout">Extra Defending Votes: $game_staff->extra_defending_votes</div>
EOF;

              } // extra defending votes

              if ($game_staff->upkeep > 0) {

                $quest_completion_html .=<<< EOF
    <div class="quest-payout negative">Upkeep: $game_staff->upkeep every 60 minutes</div>
EOF;

              } // upkeep

              if ($game_staff->chance_of_loss > 0) {

                $lifetime = floor(100 / $game_staff->chance_of_loss);
                $use = ($lifetime == 1) ? 'use' : 'uses';
                $quest_completion_html .=<<< EOF
    <div class="quest-payout negative">Expected Lifetime: $lifetime $use</div>
EOF;

              } // expected lifetime

              $quest_completion_html .= '</div>';

            } // staff bonus

// update quest_groups_completion
          $sql = 'update quest_group_completion set times_completed = 2
            where fkey_users_id = %d and fkey_quest_groups_id = %d;';
          $result = db_query($sql, $game_user->id, $quest->group);

//          $quest_group_completion->times_completed = 1;
//          $percentage_target = 200;
//          $percentage_divisor = 2;

          } else { // we don't have a bonus yet

            $quest_completion_html .=<<< EOF
<div class="title loot">Congratulations!</div>
<div class="quest-icon"><img
 src="/sites/default/files/images/quests/stlouis-soon.png"></div>
<div class="quest-details">
  <div class="quest-name loot">You have completed all {$quest_lower}s in
    this group a second time!</div>
  <div class="quest-description">Unfortunately, we have nothing to give you
    yet!&nbsp; We're still coding it!</div>
  <p class="second">&nbsp;</p>
</div>
EOF;
          } // if we actually have a bonus to give

        } // if quest group completed

      } // if one quest_group bonus has been given

    } // if quest completed

    if ($percent_complete > floor($percentage_target / 2)) {

      $rgb = dechex(floor(($percentage_target - $percent_complete) /
        (4 * $percentage_divisor))) . 'c0';

    } else {

      $rgb = 'c' . dechex(floor(($percent_complete) /
        (4 * $percentage_divisor))) . '0';

    }

    $width = floor($percent_complete * 94 / $percentage_target) + 2;

//firep($rgb);
//firep($width);

    $disbursement_html = $consumption_html = '';

// check for consumption - clan equipment

    if ($quest->clan_equipment_1_consumed_quantity > 0) {

      $sql = 'SELECT * FROM equipment
        WHERE equipment.id = %d;';
      $result = db_query($sql, $quest->fkey_clan_equipment_1_consumed_id);
      $game_equipment = db_fetch_object($result); // limited to 1 in DB

      $consumption_html .=<<< EOF
  <div class="quest-required_stuff">
    <div class="quest-required">
      $a_start
        <img class="$not_yet"
          src="/sites/default/files/images/equipment/$game-{$game_equipment->id}.png"
          width="48">
      $a_end
      <div class="quest-required-num">
        Clan
        <br/>
        -{$quest->clan_equipment_1_consumed_quantity}
      </div>
    </div>
  </div>
EOF;

      clan_equipment_lose($game_user, $game_equipment->id,
        $quest->clan_equipment_1_consumed_quantity);
    } // check for consumption - clan equipment

// check for loot - equipment

    $sql = 'SELECT equipment.quantity_limit, equipment_ownership.quantity
      FROM equipment

      LEFT OUTER JOIN equipment_ownership
      ON equipment_ownership.fkey_equipment_id = equipment.id
      AND equipment_ownership.fkey_users_id = %d

      WHERE equipment.id = %d;';
    $result = db_query($sql, $game_user->id,
      $quest->fkey_loot_equipment_id);
    $game_equipment = db_fetch_object($result); // limited to 1 in DB

    $limit = $game_equipment->quantity_limit > (int) $game_equipment->quantity;

    if ($quest->chance_of_loot >= mt_rand(1,100) &&
    ($limit || $game_equipment->quantity_limit == 0)) {

      equipment_gain($game_user, $quest->fkey_loot_equipment_id, 1);

      $sql = 'select * from equipment where id = %d;';
      $result = db_query($sql, $quest->fkey_loot_equipment_id);
      $loot = db_fetch_object($result);

      $cumulative_expenses = $game_user->expenses + $loot->upkeep;
      if((int)$game_user->income >= $cumulative_expenses) {
        $game_user->expenses = $cumulative_expenses;
        $sql = 'UPDATE users SET expenses = %d WHERE id = %d';
        $result = db_query($sql, $game_user->expenses, $game_user->id);

        $loot_html =<<< EOF
  <div class="title loot">You Found</div>
  <div class="quest-icon"><img
   src="/sites/default/files/images/equipment/$game-$loot->id.png" width="96"></div>
  <div class="quest-details">
    <div class="quest-name loot">$loot->name</div>
    <div class="quest-description">$loot->description &nbsp;</div>
EOF;

      if ($loot->initiative_bonus > 0) {

        $loot_html .=<<< EOF
      <div class="quest-payout">$initiative: +$loot->initiative_bonus
        </div>
EOF;

      } // initiative bonus?

      if ($loot->endurance_bonus > 0) {

        $loot_html .=<<< EOF
    <div class="quest-payout">$endurance: +$loot->endurance_bonus
      </div>
EOF;

      } // endurance bonus?

      if ($loot->elocution_bonus > 0) {

        $loot_html .=<<< EOF
      <div class="quest-payout">$elocution: +$loot->elocution_bonus
        </div>
EOF;

      } // elocution bonus?

      $loot_html .=<<< EOF
      <p class="second">&nbsp;</p>
    </div>
EOF;

// add/update db entry

        competency_gain($game_user, 'looter');

        if ($quest->fkey_loot_equipment_id == 51 &&
          $event_type == EVENT_GATHER_AMETHYST) {

          $sql = 'update users set meta_int = meta_int + 1
            where id = %d;';
          $result = db_query($sql, $game_user->id);

        }

        $sql = 'SELECT equipment.*, equipment_ownership.quantity
          FROM equipment

          LEFT OUTER JOIN equipment_ownership
          ON equipment_ownership.fkey_equipment_id = equipment.id
          AND equipment_ownership.fkey_users_id = %d

          WHERE equipment.id = %d;';
        $result = db_query($sql, $game_user->id,
          $quest->fkey_loot_equipment_id);
        $game_equipment = db_fetch_object($result); // limited to 1 in DB

        if ($game_equipment->quantity == '') { // no record exists - insert one

          $sql = 'insert into equipment_ownership (fkey_equipment_id,
            fkey_users_id, quantity) values (%d, %d, 1);';
          $result = db_query($sql, $quest->fkey_loot_equipment_id,
            $game_user->id);

        } else { // existing record - update it

          $sql = 'update equipment_ownership set quantity = quantity + 1 where
            fkey_equipment_id = %d and fkey_users_id = %d;';
          $result = db_query($sql, $quest->fkey_loot_equipment_id,
            $game_user->id);

        } // add/update db entry

      } // check for income < expenses after loot

    } // check for loot - equipment

    // check for loot - staff

    $sql = 'SELECT staff.quantity_limit, staff_ownership.quantity
      FROM staff

      LEFT OUTER JOIN staff_ownership
      ON staff_ownership.fkey_staff_id = staff.id
      AND staff_ownership.fkey_users_id = %d

      WHERE staff.id = %d;';
    $result = db_query($sql, $game_user->id,
      $quest->fkey_loot_staff_id);
    $game_staff = db_fetch_object($result); // limited to 1 in DB

    $limit = $game_staff->quantity_limit > (int) $game_staff->quantity;

    if ($quest->chance_of_loot_staff >= mt_rand(1,100) &&
    ($limit || $game_staff->quantity_limit == 0)) {

      $sql = 'select * from staff where id = %d;';
      $result = db_query($sql, $quest->fkey_loot_staff_id);
      $loot = db_fetch_object($result);

      $disbursement_html .=<<< EOF
  <div class="title loot">You Found</div>
  <div class="quest-icon"><img
   src="/sites/default/files/images/staff/$game-$loot->id.png" width="96"></div>
  <div class="quest-details">
    <div class="quest-name loot">$loot->name</div>
    <div class="quest-description">$loot->description &nbsp;</div>
    <p class="second">&nbsp;</p>
  </div>
EOF;

// add/update db entry

      $sql = 'SELECT staff.*, staff_ownership.quantity
        FROM staff

        LEFT OUTER JOIN staff_ownership
        ON staff_ownership.fkey_staff_id = staff.id
        AND staff_ownership.fkey_users_id = %d

        WHERE staff.id = %d;';
      $result = db_query($sql, $game_user->id,
        $quest->fkey_loot_staff_id);
      $game_staff = db_fetch_object($result); // limited to 1 in DB

      if ($game_staff->quantity == '') { // no record exists - insert one

        $sql = 'insert into staff_ownership (fkey_staff_id,
          fkey_users_id, quantity) values (%d, %d, 1);';
        $result = db_query($sql, $quest->fkey_loot_staff_id,
          $game_user->id);

      } else { // existing record - update it

        $sql = 'update staff_ownership set quantity = quantity + 1 where
          fkey_staff_id = %d and fkey_users_id = %d;';
        $result = db_query($sql, $quest->fkey_loot_staff_id,
          $game_user->id);

      } // add/update db entry

    } // check for loot - staff


