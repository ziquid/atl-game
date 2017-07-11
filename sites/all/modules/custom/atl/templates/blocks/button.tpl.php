<?php

$game = check_plain(arg(0));
$arg2 = check_plain(arg(2));
if (strlen($link)) {
  $link = $game . '/' . $link . '/' . $arg2 . $extra_link;
}
if (!strlen($text)) {
  $text = $type;
}

?>
<button class="game-button-exterior center-block">
  <span class="game-button-interior game-button-<?php echo drupal_html_class($type); ?>">
    <?php if (strlen($link)): ?>
      <a href="/<?php echo $link;?>">
    <?php endif; ?>
    <?php echo $text; ?>
    <?php if (strlen($link)): ?>
      </a>
    <?php endif; ?>
  </span>
  <?php if ($subhead): ?>
    <p>
      <?php echo $subhead; ?>
    </p>
  <?php endif; ?>
</button>

