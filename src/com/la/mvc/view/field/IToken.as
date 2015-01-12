/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {

	import com.la.mvc.view.IAttackAvailable;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public interface IToken extends IAttackAvailable {
		function set canAttack (value:Boolean) :void;
		function get canAttack () :Boolean;
		function activateProvocation() :void;
		function deactivateProvocation() :void;
		function clone () :IToken;
		function set cloneFlag (value:Boolean):void;
		function get cloneFlag () :Boolean;
		function getMirror() :Sprite; 


	}
}
