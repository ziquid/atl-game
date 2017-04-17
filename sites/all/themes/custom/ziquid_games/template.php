<?php

/**/
function ziquid_games_preprocess_html(&$variables) {

// viewport
  $meta_viewport = array(
    '#type' => 'html_tag',
    '#tag' => 'meta',
    '#attributes' => array(
      'name' => 'viewport',
      'content' =>  'width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0',
    )
  );

  drupal_add_html_head($meta_viewport, 'meta_viewport');

  // Include Roboto font from Google.
  $font = array(
    '#type' => 'html_tag',
    '#tag' => 'link',
    '#attributes' => array(
      'href' =>  'https://fonts.googleapis.com/css?family=Roboto:300,300italic,400,400italic,700,700italic&subset=latin,latin-ext',
      'rel'  => 'stylesheet',
      'type' => 'text/css',
    )
  );
  drupal_add_html_head($font, 'font_roboto');

  // Include Roboto Slab font from Google.
  $font = array(
    '#type' => 'html_tag',
    '#tag' => 'link',
    '#attributes' => array(
      'href' =>  'https://fonts.googleapis.com/css?family=Roboto+Slab:300,400&subset=latin,latin-ext&effect=putting-green',
      'rel'  => 'stylesheet',
      'type' => 'text/css',
    )
  );
  drupal_add_html_head($font, 'font_roboto_slab');

} // preprocess_html()

/**
 * Implementation of hook_preprocess_page().
 */
function ziquid_games_preprocess_page(&$vars) {
  // Is the first content block the game header?  Move to the header region.
  $first_block = $vars['page']['content']['system_main'][0];
  if ($first_block['#theme'] == 'game_header') {
    $vars['page']['header'] = array(
      'header' => array(
        $first_block
      )
    );
    unset($vars['page']['content']['system_main'][0]);
  };

  $vars['page']['footer'] = '
    <div class="turf-wars-atlanta">
      <div class="turf-wars">Turf Wars:</div>
      <div class="atlanta">Atlanta</div>
    </div>
    game by
    <img class="center-block" src="http://www.ziquid.com/sites/default/files/ziquid_800_2.png"/>
    <div class="design-studio">Design Studio</div>';

}
