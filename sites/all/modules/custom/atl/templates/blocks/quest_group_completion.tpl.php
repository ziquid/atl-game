<div class="row">
  <div class="quest-group-completion">
    <strong><?php echo $questGroup->completed; ?></strong> of <?php echo $questGroup->total; ?>
    <?php ge('@quest'); ?>s complete
    <?php if ($questGroup->timesCompleted > 0): ?>
      (2nd round)
    <?php endif; ?>
  </div>
</div>
