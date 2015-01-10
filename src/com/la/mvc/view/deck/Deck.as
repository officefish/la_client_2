/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.deck {

import com.la.mvc.view.card.Card;
import com.la.mvc.view.scene.IScene;
<<<<<<< HEAD
import com.la.mvc.model.CardData;
=======
import com.ps.cards.CardData;

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import flash.display.Sprite;

public class Deck extends Sprite implements IDeck {

    protected var cardsStack:Sprite;
    protected var _price:int = 0;
    protected var _sales:Array;
    protected var stageWidth:int;
    protected var stageHeight:int;
    protected var scene:IScene;

    public function Deck() {
        cardsStack = new Sprite ();
        addChild (cardsStack);
    }
    public function addCard (card:CardData, quick:Boolean = false) :Card {
        return null;
    }
    public function addCards (cards:Vector.<CardData>, animation:Boolean = false) :Vector.<Card> {
        return null;
    }
    public function resize (stageWidth:int, stageHeight:int) :void {
        this.stageWidth = stageWidth;
        this.stageHeight = stageHeight;
    }
    public function set price (value:int) :void {
        this._price = value;
    }
    public function get price () :int {
        return _price;
    }

    public function get shiftX () :int {
        return 0;
    }

    public function setScene (scene:IScene) :void {
        this.scene = scene;
    }

<<<<<<< HEAD
    public function unblock (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
=======
    public function unblock () :void {
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    }

    public function block () :void {

    }
<<<<<<< HEAD
	
	public function sort (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false):void {
		
	}

=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
}
}
