<div class="row">
  <div class="quest-header">
    <div class="left col-xs-1">
      <?php if ($qgo): ?>
        <a href="/<?php echo $qgo; ?>">
          <span class="arrows bigbig">&lsaquo;&lsaquo;&lsaquo;</span>
        </a>
      <?php endif; ?>
    </div>
    <div class="middle col-xs-10">
      <h1 class="chapter">
        <!--Chapter <?php print $groupToShow; ?>: --><?php echo $qg; ?>
      </h1>
      <div class="location">
        <?php print $questLocation; ?>
      </div>
    </div>
    <div class="right col-xs-1">
      <?php if (isset($qgn)): ?>
          <a href="/<?php echo $qgn; ?>">
              <span class="arrows bigbig">&rsaquo;&rsaquo;&rsaquo;</span>
          </a>
      <?php endif; ?>
    </div>
  </div>
</div>
