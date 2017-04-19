<?php

/**
 * @file show_goal.inc
 */

/**
 * Get the data ready to show the goal.
 */
function game_preprocess_show_goal(&$vars) {
//  dpm($vars, 'vars');
  $vars += array(
    'classes_array' => [],
    'attributes_array' => [],
    'title_attributes_array' => [],
    'content_attributes_array' => [],
  );
}

/*

function _show_goal($game_user) {

global $game;

$sql = 'select goals.* from goals
left join goals_achieved on fkey_goals_id = goals.id
and fkey_users_id = %d
where goals_achieved.id is NULL
order by goals.id asc limit 1;';
$result = db_query($sql, $game_user->id);
$item = db_fetch_object($result);

if (substr(arg(1), 0, strlen($item->type)) == $item->type)
$current = 'current';

$finished = eval($item->code_to_check);

if ($finished) {

// save an entry showing that this goal has been achieved

$sql = 'insert into goals_achieved
(fkey_users_id, fkey_goals_id)
values (%d, %d);';
$result = db_query($sql, $game_user->id, $item->id);

// congratulate user

$extra_title =<<< EOF
<div class="title goal-achieved">
  Goal Achievement
  <span class="arrows">&raquo; </span>
  <span class="nowrap">$item->title</span>
</div>
EOF;

$next = t('Next Goal');
$current = 'current';

// find next goal

$sql = 'select goals.* from goals
left join goals_achieved on fkey_goals_id = goals.id
and fkey_users_id = %d
where goals_achieved.id is NULL
order by goals.id asc limit 1;';
$result = db_query($sql, $game_user->id);
$item = db_fetch_object($result);

} else {

$extra_title = '';
$next = t('Current Goal');

}

if (empty($item->title) && empty($extra_title)) return; // no goal

if (empty($item->title)) $item->title = t('None');

$description = t($item->description, array(
'@level' => $game_user->level,
));

echo <<< EOF


<script type="text/javascript">
    Element.prototype.hasClass = function(cName) {
        return this.className &&
            new RegExp('(^|\\\\s)' + cName + '(\\\\s|$)').test(this.className);
    };
    Element.prototype.removeClass = function(className) {
        this.className = this.className.replace(
            new RegExp('(^|\\\\s)' + className + '(\\\\s|$)', 'm'), ''
        );
    };

    function toggle_goal_desc() {
        var d = document.getElementById('goal-desc');
        if (d.hasClass('show')) {
            d.removeClass('show');
        } else {
            d.className = d.className + ' show';
        }
    }
</script>
EOF;

}

*/
