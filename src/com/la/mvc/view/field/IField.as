/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
<<<<<<< HEAD
import com.la.mvc.view.card.Card;
import com.la.mvc.view.scene.IScene;
import com.la.mvc.model.CardData;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import flash.geom.Point;
=======
import flash.events.IEventDispatcher;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

public interface IField extends IEventDispatcher{
    function resize (stageWidth:int, stageHeight:int) :void;
    function setBackground (background:IBackground) :void;

    function addPlayerHero (hero:IHero) :void;
    function addOpponentHero (hero:IHero) :void;
<<<<<<< HEAD
	
	function getPlayerHero() :IHero;
	function getOpponentHero() :IHero;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    function enableStepButton () :void;
    function disableStepButton () :void;

<<<<<<< HEAD
    function setPlayerPrice (value:int, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void;
    function setOpponentPrice (value:int, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void;
=======
    function setPlayerPrice (value:int) :void;
    function setOpponentPrice (value:int) :void;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    function findPosition () :void;
    function stopFindPosition () :void;
    function getTokenPreviewIndex () :int;
<<<<<<< HEAD
	
	function playPlayerCardUnit (cardData:CardData, position:int, card:Card, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = true) :void;
    function playOpponentCardUnit (cardData:CardData, position:int, card:Card, mirrorPosition:Point, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = true) :void;

	function placeUnitRowPosition () :void;
	function setScene (scene:IScene):void;
	
	function clearPlayerPrice() :void;
	
    function markAttackAvailable (list:Array, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void;
    function glowTokens (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void;
	function blockTokens (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void;
	
	function getTokenIndex (token:DisplayObject, opponentFlag:Boolean = false) :int;
	
	function getAttackUnit (index:int, playerFlag:Boolean = true) :DisplayObject;
	function getTargetUnit (index:int, playerFlag:Boolean = true) :DisplayObject;
	
	function classicAttack (initiatorIndex:int, targetIndex:int, playerFlag:Boolean = true, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void;
	function backUnitToPosition (unit:DisplayObject,  position:Point, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void;
	function removeToken (index:int, playerFlag:Boolean, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void;

	function getPlayerToken (index:int) :IToken;
	function getOpponentToken (index:int) :IToken;
	
	function blur () :void;
	function stopBlur(): void;
	
	function addToken (attachment:Boolean, cardData:CardData, position:int) :void 
=======


>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2



}
}
