/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
public interface IAttackAvailable extends IEventDispatcher {
	function set isEnemy (value:Boolean) :void;
    function get isEnemy () :Boolean;
	function glow () :void;
	function stopGlow () :void;
	function getPosition () :Point;
	
	function setHealth (value:int) :void;
	function getHealth () :int;
	function setAttack (value:int) :void;
	function getAttack () :int;
	function setMaxHealth (value:int):void;
	function getMaxHealth () :int;

}
}
