(function ($) {
  Drupal.behaviors.atl_quests_list = {
    attach: function (context, settings) {
      $(".quest-slider", context).each(function() {
        const questDoUrl = $(this).data("quest-do-url");
        $(this).empty().slider({
          create: function() {
            var $handle = $(".ui-slider-handle", this);
            $handle.html("Do&nbsp;it&nbsp;&rsaquo;&rsaquo;");
          },
          slide: function( event, ui ) {
            if (ui.value >= 80) {
              window.location.href = questDoUrl;
            }
          }
        });
      });
    }
  };
}(jQuery));
