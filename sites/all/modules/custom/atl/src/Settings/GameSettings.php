<?php

namespace Drupal\atl\Settings;

/**
 * @file GameSettings.php
 */

class GameSettings {

  /**
   * The amount of time, in seconds, to wait before energy increases.
   *
   * @var int
   */
  protected $energyWait;

  /**
   * GameSettings constructor.
   */
  public function __construct() {
    $this->energyWait = 300;
  }

  public function getEnergyWait() {
    return $this->energyWait;
  }

  public function addJs() {
    drupal_add_js(array('atl' => array('gameSettings' => array(
      'energyWait' => $this->energyWait,
    ))), 'setting');
  }

}
