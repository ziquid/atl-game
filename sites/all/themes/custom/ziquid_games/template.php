<?php

/**
 * Implementation of hook_preprocess_html.
 */
function ziquid_games_preprocess_html(&$variables) {

  drupal_add_js('//code.jquery.com/ui/1.12.1/jquery-ui.js');
  drupal_add_css('//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css', array('type' => 'external'));
  // Include jQuery Mobile stylesheets.
  drupal_add_css('//code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css');

  // Include the jQuery Mobile library.
  drupal_add_js('//code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js');

  // FontAwesome fonts.
  drupal_add_js('//use.fontawesome.com/5d2746f8be.js');

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

} // preprocess_html

/**
 * Implementation of hook_preprocess_page.
 */
function ziquid_games_preprocess_page(&$vars) {
  // Is the first content block the game header?  Move to the header region.
  $first_block = @$vars['page']['content']['system_main'][0];
  if ($first_block['#theme'] == 'game_header' || $first_block['#theme'] == 'title_image') {
    $vars['page']['header'] = array(
      'header' => array(
        $first_block
      )
    );
    unset($vars['page']['content']['system_main'][0]);
  };

  $vars['page']['footer'] = '
    <div class="uprising-atlanta">
      <div class="uprising">Uprising:</div>
      <div class="atlanta">Atlanta</div>
    </div>
    game by
    <img class="center-block" src="http://www.ziquid.com/sites/default/files/ziquid_800_2.png"/>
    <div class="design-studio">Design Studio</div>';

}
