<?php

/**
 * @file
 */

/**
 * Bounce to home page.
 */
function game_bounce_callback($game_id) {
/*
  if ($arg2 == 'facebook') {
    echo <<< EOF
<style>
body {
  text-align: center;
}
img {
  width: 320px;
}
input {
  position: relative;
  top: -256px;
  font-size: 200%;
}
</style>
<img src="/sites/default/files/images/cg_splash_new.jpg"/>
<form method=post action="/$game/home/$arg2">
<input type="Submit" value="Continue to the game"/>
</form>
EOF;

    db_set_active('default');
    return;
  }
*/
  game_goto('home');
}
