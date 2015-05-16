/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.deck {

import com.la.mvc.view.card.Card;
import com.la.mvc.view.scene.IScene;
import com.la.mvc.model.CardData;
import flash.display.Sprite;

public class Deck extends Sprite implements IDeck {

    protected var cardsStack:Sprite;
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
   

    public function get shiftX () :int {
        return 0;
    }

    public function setScene (scene:IScene) :void {
        this.scene = scene;
    }
	
	public function clear () :void {
		
	}

    /*
	public function unblock (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {

    }

    public function block () :void {

    }
	*/
	
	public function sort (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false):void {
		
	}

}
}
