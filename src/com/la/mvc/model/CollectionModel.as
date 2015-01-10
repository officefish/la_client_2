/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.model {
import com.la.event.MatchEvent;
<<<<<<< HEAD
import com.la.mvc.model.CardData;
import com.la.mvc.view.card.CollectionCard;
import com.la.mvc.view.collection.DeckItemSlot;

=======
import com.ps.cards.CardData;
import com.ps.collection.CardsCache;
import com.ps.collection.Collection;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import org.robotlegs.mvcs.Actor;

public class CollectionModel extends Actor {

<<<<<<< HEAD
    private var _collectionCard:CollectionCard;
	private var _deckSlot:DeckItemSlot;
	private var _deckData:DeckData;
=======
    private static var collections:Object = {};

    private var cards:Vector.<CardData>
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public function CollectionModel() {

    }
<<<<<<< HEAD
	
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
	
	
	

   
=======

    public function init (collectionId:int) :void {
        collections[collectionId] = generateCollection(35);
        dispatch(new MatchEvent(MatchEvent.COLLECTION_INIT));
    }

    public function getCollectionById (collectionId:int) :Vector.<CardData> {
        if (!collections[collectionId]) throw new Error('No collection found with id: ' + collectionId);
        return collections[collectionId];
    }

    public function generateCollection (count:int) :Vector.<CardData> {
        var cards:Vector.<CardData> = new Vector.<CardData>();
        for (var i:int = 0; i < count; i ++) {
            var card:CardData = CardsCache.getInstance().getRandomCardData();
            cards.push (card);
        }
        return cards;
    }

    public function initMatchCollection (collectionId:int) :void {
        cards = blend(collections[collectionId]);
    }

    private function blend (collection:Vector.<CardData>) :Vector.<CardData> {
        var _result:Vector.<CardData> = new Vector.<CardData>();
        var _source:Vector.<CardData> = collection.concat();

        while (_source.length > 0) {
            _result.push(_source.splice(Math.round(Math.random() * (_source.length - 1)), 1)[0]);
        }

        return _result;
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
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
}
}
