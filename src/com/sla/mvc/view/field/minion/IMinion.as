package com.sla.mvc.view.field.minion 
{
	import com.sla.mvc.view.card.Card;
	import flash.geom.Point;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public interface IMinion 
	{
		function set isEnemy (value:Boolean) :void;
		function get isEnemy () :Boolean;
		
		function glow () :void;
		function stopGlow ():void;
		
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
		function get hasShield () :Boolean;
	
		function activateShadow() :void;
		function destroyShadow() :void;
		function get inShadow():Boolean;
	
		function activateDoubleAttack()  :void;
		function deactivateDoubleAttack() :void;
	
		function dumbness () :void;
	
		function set canAttack (value:Boolean) :void;
		function get canAttack () :Boolean;
	
		function activateProvocation () :void;
		function deactivateProvocation () :void;
		function get isProvocation () :Boolean;
	
		function activateFreeze () :void;
		function deactivateFreeze() :void;
	
		function activateSpellInvisible () :void;
		function  deactivateSpellInvisible () :void;
		function get isSpellInvisible () :Boolean
		
		function activateSpellUp () :void;
		function deactivateSpellUp() :void;
		
		function clone () :IMinion;
		function asDO () :Sprite;
		
		function get globalPosition () :Point; 
		
		function set block (value:Boolean) :void;
		function get block () :Boolean;
		
		function set copy (value:IMinion) :void;
		function get copy () :IMinion;
		
		function get attackValue () :int;
		
		function dropShadow () :void;
		function stopDropShadow () :void;
		
		function activateWidget () :void;
		function get hasActiveAptitude () :Boolean 
		function get activeManacost () :int; 
		
		function get activeBlock () :Boolean;
		function set activeBlock (value:Boolean) :void;
		
		function getCard () :Card;
		function set showMirror (value:Boolean) :void;
		function get showMirror () :Boolean;
		
		function activateFly () :void;
		function deactivateFly () :void;
		function get canFly () :Boolean;
		
		function attachWidget (widget:int) :void;
		
		
		
	}
	
}