/**
 * Created by root on 11/1/14.
 */
package com.la.mvc.view.deck {
import com.la.event.DeckEvent;
<<<<<<< HEAD
import com.la.mvc.model.DeckData;
import com.la.mvc.view.ui.SmallButton;
=======
import com.la.event.DeckServiceEvent;

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import fl.controls.Button;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class DeckList extends Sprite {

    private var stageWidth:int;
    private var stageHeight:int;

    private var deckContainer:Sprite;
<<<<<<< HEAD
=======
    private var infoContainer:Sprite;

    private var items:Object;
    private var heroes:Object;

    private var selectedDeckId:int;
    private var selectedHeroId:int;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    private var selectedDeckItem:DeckListItem;

    private var widget:DeckHeroWidget;

    private var matchButton:Button;
<<<<<<< HEAD
	private var decks:Object;
	
	private var closeButton:SmallButton; 
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public function DeckList() {

    }

    public function resize (stageWidth:int, stageHeight:int) :void {
        this.stageWidth = stageWidth;
        this.stageHeight = stageHeight;

        if (!deckContainer) deckContainer = new Sprite();
<<<<<<< HEAD
=======
        if (!infoContainer) infoContainer = new Sprite();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        if (!widget)  widget = new DeckHeroWidget();

        deckContainer.graphics.clear();
        deckContainer.graphics.beginFill(0xBBBBBB, 1);
        deckContainer.graphics.drawRect(0,0, Math.round(stageWidth*0.66), Math.round(stageHeight*0.98));
        deckContainer.graphics.endFill();
        deckContainer.x = Math.round(stageWidth * 0.01);
        deckContainer.y = Math.round(stageHeight * 0.01);
        addChild(deckContainer);

        widget.y = 180;
        widget.x = stageWidth * 0.71;

        matchButton = new Button();
        matchButton.width = 200;
        matchButton.height = 50;
        matchButton.label = 'В бой';
        matchButton.x = stageWidth * 0.71;
<<<<<<< HEAD
		matchButton.buttonMode = true;
        matchButton.y = stageHeight - (15 + matchButton.height);
        matchButton.addEventListener(MouseEvent.CLICK, deckSelect);
       
		addEventListener(DeckEvent.SELECT, onItemSelect, true);
		addEventListener(DeckEvent.INTRO_EDIT_CLICK, onItemEdit, true);
		
		closeButton = new SmallButton ('закрыть');
		closeButton.x = widget.x + (widget.width - closeButton.width);
		closeButton.y = deckContainer.y;
		closeButton.addEventListener (MouseEvent.CLICK, onCloseClick);
		addChild (closeButton);
    }

    public function initDecks (list:Array) :void {

		var shiftX:int = 40;
		var shiftY:int = 90;
		var shift:int = 0;
		var deckData:DeckData;
		var item:DeckListItem;
		decks = {};
		for (var i:int = 0; i < list.length; i ++) {
			deckData = list[i] as DeckData;
			item = new DeckListItem(deckData);
			item.x = shiftX;
			item.y = shiftY;
			shiftX += item.width + 41;
			shift ++;
			if (shift == 3) {
				shiftY += 150;
				shift = 0;
				shiftX = 40;
			}
			decks[deckData.id] = item;
			deckContainer.addChild (item);
		}
    }
	
	public function activateDeck (id:int) :void {
		var item:DeckListItem = decks[id] as DeckListItem;
		if (!item) return;
				
		if (selectedDeckItem) {
            selectedDeckItem.deselect ();
        }
		selectedDeckItem = item;
		item.select();
		if (!contains(widget)) addChild (widget);
		widget.setHeroData (item.getDeckData().hero);
		
		if (!contains(matchButton)) addChild(matchButton);
	}

    private function onItemSelect (event:DeckEvent) :void {
		var item:DeckListItem = event.target as DeckListItem;
		activateDeck(item.getDeckData().id);
    }

    private function deckSelect (event:MouseEvent) :void {
        if (selectedDeckItem)
		var id:int = selectedDeckItem.getDeckData().id;
		var heroId:int = selectedDeckItem.getDeckData().hero.id;
		dispatchEvent(new DeckEvent(DeckEvent.SELECT_DECK, {'deckId':id, 'heroId':heroId}))
    }

    private function onCloseClick (event:MouseEvent) :void {
        dispatchEvent(new DeckEvent(DeckEvent.CLOSE, {}));
    }
	
	private function onItemEdit (event:DeckEvent) :void {
		dispatchEvent(event);
	}
	
	
=======
        matchButton.y = stageHeight - (15 + matchButton.height);
        matchButton.addEventListener(MouseEvent.CLICK, deckSelect);
        addChild(matchButton);


        addEventListener(DeckEvent.SELECT, onItemSelect, true);
    }

    public function setDeckListData (data:Object) :void {


        var heroes:Array = data.heroes;


        var decks:Array = [];
        var item:DeckListItem;
        var hero_uid:int;
        var hero_id:int;
        var deck:Object;
        var shift:int = 40;

        items = {};
        this.heroes = {};

        var hero:Object;

        for (var i:int = 0; i < heroes.length; i ++) {
            var row:Sprite = new Sprite();
            row.x = shift;
            row.y = shift + 120 * i;
            deckContainer.addChild(row);
            hero = {};
            hero.vocation = heroes[i].vocation;
            hero.title = heroes[i].title;
            hero.description = heroes[i].description;
            hero.level =  heroes[i].level;
            decks = heroes[i].decks;
            hero_uid = heroes[i].uid;
            hero.uid = hero_uid;
            hero_id = heroes[i].id;
            this.heroes[hero_uid] = hero;
            for (var j:int = 0; j < decks.length; j ++) {
                deck = decks[j];
                item = new DeckListItem(deck.title, deck.id, hero_id, hero_uid, deck.complicated);
                item.x = (item.width + shift) * j;
                row.addChild(item);
                items[deck.id] = item;
            }
        }

        activateDeck(data.activeDeck, data.activeHero);
    }

    private function onItemSelect (event:DeckEvent) :void {
        activateDeck(event.data.id, event.data.hero_id)
    }

    private function activateDeck (deckId:int, heroId:int) :void {
        if (!contains(widget)) addChild(widget);

        var item:DeckListItem = items[deckId]
        var heroData:Object =  heroes[item.getUid()]

        if (selectedDeckItem) {
            selectedDeckItem.deselect ();
            selectedDeckItem = item;
        }

        item.select();

        selectedDeckId = deckId;
        selectedHeroId = heroId;

        widget.setHeroData (heroData);
    }

    private function deckSelect (event:MouseEvent) :void {
        dispatchEvent(new DeckServiceEvent(DeckServiceEvent.RESPONSE_SELECT_DECK, {'deck':selectedDeckId, 'hero':selectedHeroId}))
    }

    public function close () :void {
        dispatchEvent(new DeckEvent(DeckEvent.CLOSE, {}));
    }
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public function destroy () :void {

    }
}
}
