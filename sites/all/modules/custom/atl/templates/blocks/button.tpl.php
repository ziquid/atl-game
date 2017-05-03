<?php

$game = check_plain(arg(0));
$arg2 = check_plain(arg(2));
$link = $game . '/' . $link . '/' . $arg2 . $extra_link;

?>
<button class="game-button-exterior center-block">
  <span class="game-button-interior game-button-<?php echo drupal_html_class($type); ?>">
    <a href="/<?php echo $link;?>">
      <?php echo $type; ?> &raquo;
    </a>
  </span>
</button>
