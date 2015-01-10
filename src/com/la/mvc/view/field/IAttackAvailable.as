/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
<<<<<<< HEAD
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
	
=======
public interface IAttackAvailable {
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
}
}
