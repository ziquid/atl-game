<div class="game-header game-hood-<?php echo $game_user->fkey_neighborhoods_id; ?>">
 <div class="col-xs-12 col-sm-6">
  <div class="money col-xs-4">
    <span id="money-id">
      <?php echo $moneyStr; ?>
    </span>
    <span class="money-text">
      <?php echo $game_user->values_name; ?>
    </span>
    <div id="income-time">
      <?php echo $incomeText; ?>
    </div>
  </div>
  <div class="actions col-xs-4">
    <span id="actions-id">
      <?php echo $game_user->actions; ?>
    </span>
    /
    <?php echo $game_user->actions_max; ?>
    <span class="actions-text">
      <?php ge('@actions'); ?>
    </span>
    <br>
    <div id="actions-time">
      <?php echo $actionsText; ?>
    </div>
  </div>
  <div class="experience col-xs-4">
    <strong><?php echo $game_user->experience; ?></strong>
    <?php echo $experience_pct; ?>
    <div class="experience-text">
      Experience
    </div>
  </div>
 </div>
 <div class="col-xs-12 col-sm-6">
  <div class="energy col-xs-4">
    <span id="energy-id">
      <?php echo $game_user->energy; ?>
    </span>
    /
    <?php echo $game_user->energy_max; ?>
    <span class="energy-text">
      <?php ge('@energy'); ?>
    </span>
    <br>
    <div id="energy-time">
      <?php echo $energyText; ?>
    </div>
  </div>
  <div class="home col-xs-4">
    <a href="/<?php echo $game; ?>/home/<?php echo $arg2; ?>">
      <!--<img src="/sites/default/files/images/<?php echo $game; ?>_home_icon_large.png"/>-->
      <img src="//placeholdit.imgix.net/~text?txtsize=12&txt=ATL+HOME&w=48&h=26&txttrack=0&txtpad=1" class="center-block
    img-responsive">
    </a>
  </div>
  <div class="level col-xs-4">
    <?php echo $level_text; ?>
  </div>
 </div>
</div>
