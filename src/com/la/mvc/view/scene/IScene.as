/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.scene {
import com.la.mvc.view.card.Card;
import com.la.mvc.view.field.IHero;
import com.la.mvc.model.CardData;
import flash.geom.Point;
import flash.display.DisplayObject;

import flash.events.IEventDispatcher;

public interface IScene extends IEventDispatcher{
    function resize (stageWidth:int, stageHeight:int) :void;

    function preflopCards (vector:Vector.<CardData>) :void;
    function replacePreflopCards (vector:Vector.<CardData>) :void;
    function moveDownPreflop (vector:Vector.<Card>, shiftX:int) :void;
    function  changePreflopCards () :void;
    function placeCard (card:DisplayObject) :void;
    function endPlaceCard () :void;

    function setPlayerHero (hero:IHero) :void;
    function setOpponentHero (hero:IHero) :void;
    function welcomeAnimation () :void;
    function darken () :void;
    function lighten (dispatch:Boolean = true) :void;
	
	function setAttackTokenPosition (position:Point) :void;
	function startDraw () :void; 
	function stopDraw () :void;
	
	function warning  (msg:String, confirmFlag:Boolean = false, cancelFlag:Boolean = false) :void;
	function stopWarning():void;
	
	function block () :void;
	function stopBlock() :void;
	
	
		
	function clear ():void;
	
	function placeCopy (copy:DisplayObject) :void;
	function endCopy() :void;
	
	function runStepTimer () :void;
	function stopStepTimer () :void;
	
	function placePreview (value:DisplayObject) :void;
	function endPreview () :void;
	
	function playerHeroMessage (msg:String, position:Point) :void;
	
	function addDamage (damage:DisplayObject): void;
}
}
