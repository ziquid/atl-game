<?php
  $failureText = '@' . $failureType;
  $failureText[1] = drupal_strtoupper($failureText[1]);
  $game_button = array(
    '#theme' => 'game_button',
    '#type' => gt('Refill Your ' . $failureText),
    '#link' => 'elders_do_fill',
    '#extra_link' => '/' . $failureType . '?destination=' . $_GET['q'],
    '#subhead' => gt('(1 @Luck)'),
  );
?>

<div class="quest-failed">
  <?php ge('Not Enough ' . $failureText); ?>
</div>
<?php print drupal_render($game_button); ?>
