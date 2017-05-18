(function ($) {
  Drupal.behaviors.atlBehavior = {
    attach: function (context, settings) {
console.log(Drupal.settings.atl.gameSettings);
  var energy_minutes = Drupal.settings.atl.gameSettings.energyMinutes;
  var energy_seconds = Drupal.settings.atl.gameSettings.energySeconds;
  var energy = Drupal.settings.atl.gameUser.energy;
  var energy_max = Drupal.settings.atl.gameUser.energy_max;
  var energy_to_add = Drupal.settings.atl.gameUser.energy_bonus;
  var energy_interval = Drupal.settings.atl.gameSettings.energyWait;

  var money_minutes = Drupal.settings.atl.gameSettings.moneyMinutes;
  var money_seconds = Drupal.settings.atl.gameSettings.moneySeconds;
  var money = Drupal.settings.atl.gameUser.money;
  var money_to_add = Drupal.settings.atl.gameSettings.moneyBonus;
  var money_interval = 3600;

  var actions_minutes = Drupal.settings.atl.gameSettings.actionsMinutes;
  var actions_seconds = Drupal.settings.atl.gameSettings.actionsSeconds;
  var actions = Drupal.settings.atl.gameUser.actions;
  var actions_max = Drupal.settings.atl.gameUser.actions_max;
  var actions_to_add = 1;
  var actions_interval = 180;

  function display_energy() {
    document.getElementById('energy-id').innerHTML = energy;
    if ((energy < energy_max) && (energy_to_add > 0)) {
      document.getElementById('energy-time').innerHTML =
        '+' + energy_to_add + ' in ' + energy_minutes + ':' +
        (energy_seconds < 10 ? '0' + energy_seconds : energy_seconds);
    } else {
      document.getElementById('energy-time').innerHTML = '';
    }
  }

  function display_actions() {

    document.getElementById('actions-id').innerHTML = actions;

    if (actions != actions_max) {

      if (actions > actions_max) {
        var operand = '-';
      } else {
        var operand = '+';
      }

      document.getElementById('actions-time').innerHTML =
        operand + actions_to_add + ' in ' + actions_minutes + ':' +
        (actions_seconds < 10 ? '0' + actions_seconds : actions_seconds);

    } else {

      document.getElementById('actions-time').innerHTML = '';

    }

  }

  function display_money() {

    if (money_to_add > 0) {

      if (money.toString().length > 8) {
        moneyStr = money.toString().substr(0,money.toString().length - 6) + "M";
      } else if (money.toString().length > 5) {
        moneyStr = money.toString().substr(0,money.toString().length - 3) + "K";
      } else {
        moneyStr = money.toString();
      }

      if (money_to_add.toString().length > 5) {
        money_to_addStr =
          money_to_add.toString().substr(0,money_to_add.toString().length - 3) +
            "K";
        // money_secondsStr = "m";
        money_secondsStr = ':' + (money_seconds < 10 ? '0' + money_seconds : money_seconds);
      } else {
        money_to_addStr = money_to_add.toString();
        money_secondsStr = ':' + (money_seconds < 10 ? '0' + money_seconds : money_seconds);
      }

      document.getElementById('money-id').innerHTML = moneyStr;

      document.getElementById('income-time').innerHTML =
        '+' + money_to_addStr + ' in ' + money_minutes + money_secondsStr;

    }

  }

  function add_all_stuff() {

    if ((energy_seconds == 0) && (energy_minutes > 0)) {

      energy_seconds = 60;
      energy_minutes -= 1;

    }

    if ((money_seconds == 0) && (money_minutes > 0)) {

      money_seconds = 60;
      money_minutes -= 1;

    }

    if ((actions_seconds == 0) && (actions_minutes > 0)) {

      actions_seconds = 60;
      actions_minutes -= 1;

    }

    energy_seconds--;
    actions_seconds--;
    money_seconds--;

    if ((energy_seconds == 0) && (energy_minutes == 0)) {

      energy += energy_to_add;
      energy_seconds = energy_interval % 60;
      energy_minutes = Math.floor(energy_interval / 60);

    }

    if ((money_seconds == 0) && (money_minutes == 0)) {

      money += money_to_add;
      money_seconds = money_interval % 60;
      money_minutes = Math.floor(money_interval / 60);

    }

    if ((actions_seconds == 0) && (actions_minutes == 0) &&
      (actions < actions_max)) {

      actions += actions_to_add;
      actions_seconds = actions_interval % 60;
      actions_minutes = Math.floor(actions_interval / 60);

    }

    if ((actions_seconds == 0) && (actions_minutes == 0) &&
      (actions > actions_max)) {

      actions -= actions_to_add;
      actions_seconds = actions_interval % 60;
      actions_minutes = Math.floor(actions_interval / 60);

    }

    if (energy >= energy_max) {
      energy = energy_max;
    }

    display_energy();
    display_actions();
    display_money();

  }

  var interval_timer = setInterval(add_all_stuff, 1000);
      }
 };


})(jQuery);
