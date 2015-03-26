/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.model {
import com.la.event.MatchEvent;
import com.la.mvc.model.CardData;
import com.la.mvc.view.card.CollectionCard;
import com.la.mvc.view.collection.DeckItemSlot;
import flash.display.Bitmap;
import org.robotlegs.mvcs.Actor;

public class CollectionModel extends Actor {

    private var _collectionCard:CollectionCard;
	private var _deckSlot:DeckItemSlot;
	private var _deckData:DeckData;
    private static var collections:Object = { };
	
	private var _dust:int;

    private var cards:Vector.<CardData>
	
	private var _cardPreview:Bitmap;

    public function CollectionModel() {

    }
	
	public function set collectionCard (card:CollectionCard) :void {
		this._collectionCard = card;
	}
	
	public function get collectionCard () :CollectionCard {
		return this._collectionCard;
	}
	
	public function set deckSlot (slot:DeckItemSlot) :void {
		this._deckSlot = slot;
	}
	
	public function get deckSlot () :DeckItemSlot {
		return this._deckSlot;
	}
	
	public function set deckData (value:DeckData) :void {
		this._deckData = value;
	}
	
	public function get deckData () :DeckData {
		return _deckData;
	}
	
    public function init (collectionId:int) :void {
        dispatch(new MatchEvent(MatchEvent.COLLECTION_INIT));
    }

    public function getCollectionById (collectionId:int) :Vector.<CardData> {
        if (!collections[collectionId]) throw new Error('No collection found with id: ' + collectionId);
        return collections[collectionId];
    }




    public function getPreflopCards (count:int) :Vector.<CardData> {
        return cards.splice(0, count);
    }

    public function replacePreflopCards (replacement:Vector.<CardData>) :Vector.<CardData> {
        var response:Vector.<CardData> = new Vector.<CardData>();
        cards = cards.concat(replacement);
        var random:int;
        for (var i:int = 0; i < replacement.length; i ++ ) {
            random = Math.round(Math.random() * (cards.length - 1));
            response.push(cards.splice(random, 1)[0]);
        }
        return response;
    }
	
	public function setDust (value:int) :void {
		_dust = value;
	}
	
	public function getDust () :int {
		return _dust;
	}
	
	public function setPreview (value:Bitmap) :void {
		_cardPreview = value;
	}
	
	public function getPreview () :Bitmap {
		return _cardPreview;
	}
}
}
