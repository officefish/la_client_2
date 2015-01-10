/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.collection {
import com.la.mvc.model.CollectionCardData;
import com.la.mvc.model.DeckData;
import com.la.mvc.model.HeroData;
import com.la.mvc.view.card.CollectionCard;
import flash.display.Sprite;
import flash.events.IEventDispatcher;

public interface ICollection extends IEventDispatcher {
	function initBooks (books:Array) :void;	
	function initHeroes (heroes:Array) :void;
	function initDecks (decks:Array) :void;
	function initDeck (deck:DeckData) :void;
	function resize (stageWidth:int, stageHeight:int) :void;
	function blur () :void;
	function stopBlur() :void;
	function setState (value:int) :void;
	function initHero (heroData:HeroData) :void;
	function getDeckItemsStack () :Sprite;
	function addDeckItem (data:CollectionCardData) :void;
	function getCardById (id:int):CollectionCard;
	function removeDeckItem (data:CollectionCardData) :void;
	function getDeckItemsCount() :int; 
	function getDeckItems () :Array;
}
}
