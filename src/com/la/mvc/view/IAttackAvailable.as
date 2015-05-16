/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view {
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
	function getDefaultHealth() :int;
	function setAttack (value:int) :void;
	function getAttack () :int;
	function setMaxHealth (value:int):void;
	function getMaxHealth () :int;
	
	function getAttackBob () :int
    function setAttackBob (value:int) :void 
	
	function treatment (value:int) :void;
	
	function activateShield() :void;
	function destroyShield ():void; 
	
	function activateShadow() :void;
	function destroyShadow() :void;
	
	function activateDoubleAttack()  :void;
	function deactivateDoubleAttack() :void;
	
	function dumbness () :void;
	
	function set canAttack (value:Boolean) :void;
	function get canAttack () :Boolean;
	
	function activateProvocation () :void;
	function deactivateProvocation () :void;
	
	function activateFreeze () :void;
	function deactivateFreeze() :void;
	
	function activateSpellInvisible () :void;
	function  deactivateSpellInvisible () :void;
	function activateSpellUp () :void;
	function deactivateSpellUp() :void;

}
}
