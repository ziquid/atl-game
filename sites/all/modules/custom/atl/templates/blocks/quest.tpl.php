<?php if (isset($outcome)): ?>
  <div class="quest-outcome">
    <?php print drupal_render($outcome); ?>
  </div>
<?php endif; ?>
<?php if (is_null($experienceAddedHtml)): // Quest to do ?>
  <div class="col-sm-6 col-md-4">
<?php endif; ?>
<div class="quest">
  <div class="row">
    <div class="quest-icon">
      <a href="/<?php echo $game; ?>/quests_do/<?php echo $arg2; ?>/<?php echo $quest->id; ?>">
        <img src="<?php echo $img; ?>"/>
      </a>

      <div class="progress" style="border-color: #<?php echo $rgb; ?>;">
        <div class="progress-bar" role="progressbar"
          aria-valuenow="<?php echo $quest->percent_completed; ?>"
          aria-valuemin="0" aria-valuemax="100" style="
          background-color: #<?php echo $rgb; ?>;
          width: <?php echo $quest->percent_completed; ?>%;">
          <?php echo $quest->percent_completed; ?>%&nbsp;complete
        </div>
      </div>

    </div>
    <div class="quest-details">
<!--      <div class="quest-num">$item->group.$seq_num</div>-->
      <h2 class="quest-name">
        <a href="/<?php echo $game; ?>/quests_do/<?php echo $arg2; ?>/<?php echo $quest->id; ?>">
          <?php echo $quest->name; ?> <?php echo $active; ?>
        </a>
      </h2>
      <p class="quest-description">
<!--          $laquo --><?php echo $quest->description; ?><!-- $raquo-->
      </p>
      <div class="row">

        <?php if (is_null($experienceAddedHtml)): // Quest to do ?>

          <div class="col-xs-6">
            <div class="quest-requisites">
              <?php ge('@Requisites'); ?>
            </div>
            <ul>
              <li class="quest-required quest-required_energy">
                <?php echo $quest->required_energy; ?> <?php ge('@energy'); ?>
              </li>
              <?php if ($quest->clan_equipment_1_consumed_quantity > 0): ?>
                <li class="quest-required quest-required_stuff">
    <!--            _clan_required_equipment($game_user,-->
    <!--            $item->fkey_clan_equipment_1_consumed_id,-->
    <!--            $item->clan_equipment_1_consumed_quantity);-->
                </li>
              <?php endif; ?>
            </ul>
          </div>
  <?php
  /**

          if ($item->land_required_quantity +
          $item->equipment_1_required_quantity +
          $item->equipment_2_required_quantity +
          $item->equipment_3_required_quantity +
          $item->clan_equipment_1_required_quantity +
          $item->staff_required_quantity > 0) {

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
  ?>
        <div class="col-xs-6">
          <div class="quest-disbursements">
            <?php ge('@Disbursements'); ?>
          </div>
          <ul>
            <li class="quest-disbursed quest-experience">
              +<?php echo $quest->experience; ?> <?php ge('@Experience'); ?>
            </li>
            <li class="quest-disbursed quest-experience">
              +<?php echo $quest->min_money; ?> to
              <?php echo $quest->max_money; ?>
              <?php echo $game_user->values_name; ?>
            </li>
            <?php if (($quest->chance_of_loot + $quest->chance_of_loot_staff) > 0): ?>
              <li class="quest-disbursed quest-loot">
                Chance of loot!
                <!--<span>
                  <?php echo $quest->chance_of_loot; ?>%
                </span>-->
              </li>
            <?php endif; ?>
          </ul>
        </div>
        <div class="col-xs-12">
          <div class="quest-slider"
             data-quest-do-url="/<?php echo $game . '/quests_do/' . $arg2 . '/' . $quest->id; ?>">
            <div class="ui-slider-handle"></div>
          </div>
        </div>

      <?php else: // Quest done ?>

        <div class="col-xs-6">
          <div class="quest-requisites ">
            Consumed By You
          </div>
          <ul>
            <li class="quest-required quest-required_energy">
              <?php echo $quest->required_energy; ?> <?php ge('@Energy'); ?>
            </li>
          </ul>
          <!--$consumption_html-->
        </div>
        <div class="col-xs-6">
          <div class="quest-disbursements">
            Disbursed To You
          </div>
          <ul>
            <li class="quest-disbursed quest-experience">
              <?php echo $experienceAddedHtml; ?> <?php ge('@Experience'); ?>
              <?php echo $disbursementsDoubled; ?>
            </li>
            <li class="quest-disbursed quest-experience">
              <?php echo $moneyAddedHtml; ?> <?php echo $game_user->values_name; ?>
              <?php echo $disbursementsDoubled; ?>
            </li>
          </ul>
  <!--      $disbursement_html-->
        </div>
  <!--      $quest_completion_html-->
        <div class="col-xs-12">
          <div class="quest-slider"
             data-quest-do-url="/<?php echo $game . '/quests_do/' . $arg2 . '/' . $quest->id; ?>">
            <div class="ui-slider-handle"></div>
          </div>
        </div>
      <?php endif; // Quest to do or done ?>
      </div>
    </div>
  </div>
</div>
<?php if (is_null($experienceAddedHtml)): // Quest to do ?>
  </div>
<?php endif; ?>
