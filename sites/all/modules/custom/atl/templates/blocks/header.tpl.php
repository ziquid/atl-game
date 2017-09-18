<div class="game-header game-hood-<?php echo $game_user->fkey_neighborhoods_id; ?>">
  <div class="pull-left">

    <div class="header-item level">
      <div class="progress">
        <div class="progress-bar" role="progressbar"
             aria-valuenow="<?php echo $experience_pct; ?>"
             aria-valuemin="0" aria-valuemax="100"
             style="width:<?php echo $experience_pct; ?>%">
          <span id="level-id">
            <?php echo $experience_pct; ?>%
          </span>
        </div>
      </div>
      <strong><?php echo $game_user->level; ?></strong>
    </div>

    <div class="header-item money">
      <div class="progress">
        <div class="progress-bar" role="progressbar"
             aria-valuenow="<?php echo $game_user->money; ?>"
             aria-valuemin="0" aria-valuemax="100"
             style="width:100%">
          <span id="money-id">
            <?php echo $moneyStr; ?>
          </span>
        </div>
      </div>
      <i class="fa fa-btc" aria-hidden="true">
      </i>
      <div id="income-time">
        <?php echo $incomeText; ?>
      </div>
    </div>

    <div class="header-item actions">
      <div class="progress">
        <div class="progress-bar" role="progressbar"
             aria-valuenow="<?php echo $game_user->actions; ?>"
             aria-valuemin="0" aria-valuemax="100"
             style="width:<?php echo $game_user->actions * 100 / $game_user->actions_max; ?>%">
          <span id="actions-id">
            <?php echo $game_user->actions; ?>
          </span>&nbsp;/&nbsp;<?php echo $game_user->actions_max; ?>
        </div>
      </div>
      <i class="fa fa-at" aria-hidden="true">
      </i>
      <div id="actions-time">
        <?php echo $actionsText; ?>
      </div>
    </div>

    <div class="header-item energy">
      <div class="progress">
        <div class="progress-bar" role="progressbar"
          aria-valuenow="<?php echo $game_user->energy; ?>"
          aria-valuemin="0" aria-valuemax="100"
          style="width:<?php echo $game_user->energy * 100 / $game_user->energy_max; ?>%">
          <span id="energy-id">
            <?php echo $game_user->energy; ?>
          </span>&nbsp;/&nbsp;<?php echo $game_user->energy_max; ?>
        </div>
      </div>
      <i class="fa fa-bolt" aria-hidden="true">
      </i>
      <div id="energy-time">
        <?php echo $energyText; ?>
      </div>
    </div>
  </div>

</div>
