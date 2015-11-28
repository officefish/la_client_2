package com.sla.mvc.view.ability 
{
	import com.sla.event.starling.StarlingCollectionEvent;
	import com.sla.mvc.model.data.AbilityData;
	import com.sla.mvc.view.collection.CollectionCursor;
	import com.sla.mvc.view.collection.CraftBar;
	import feathers.controls.Button;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftAbilitiesView extends Sprite 
	{
		
		private var container:Sprite;
		private var pagesStack:Sprite;
		private var cardLinks:Object;
		private var pages:Vector.<AbilityPage>;
		private var cards:Vector.<AbilityCraftCard>;
		private var actualPage:AbilityPage;
		private var pagesIndex:int;
		
		private var navigationInit:Boolean = false;
		
		private var leftSencor:Sprite;
		private var rightSencor:Sprite;
		
		private var readyButton:Button;
		private var craftBar:CraftBar;
		
		public function CraftAbilitiesView() 
		{
			container = new Sprite();
			addChild(container);
			
			var quad:Quad = new Quad(800, 600, 0x222222);
			container.addChild(quad);
			
			readyButton = new Button ();
			readyButton.label = 'Ready';
			readyButton.useHandCursor = true;
			readyButton.styleNameList.add('countBarButton');
			readyButton.addEventListener( Event.TRIGGERED, onCraftReady); 
						
			craftBar = new CraftBar('Craft Abilities',readyButton);
			craftBar.x = 620;
			container.addChild(craftBar);
			
			
			pagesStack = new Sprite();
			container.addChild(pagesStack);
			
		}
		
		public function setDust (value:int) :void {
			craftBar.setDust(value);
		}
		
		private function onCraftReady (event:Event) :void {
			parent.dispatchEvent(new StarlingCollectionEvent(StarlingCollectionEvent.CRAFT_ABILITIES_READY));
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			container.x = (stageWidth - 800) / 2;
			container.y = (stageHeight - 600) / 2;
		}
		
		public function initAbilities (abilities:Vector.<AbilityData>) :void {
			
			if (navigationInit) {
				if (container.contains(leftSencor)) {
					container.removeChild(leftSencor);
				}
				if (container.contains(rightSencor)) {
					container.removeChild(rightSencor);
				}
			}
			
			
			cardLinks = { };
			pagesIndex = 0;
			pages = new Vector.<AbilityPage>();
			
			pagesStack.removeChildren();
			
			var cards:Vector.<AbilityCraftCard> = new Vector.<AbilityCraftCard>();
			var card:AbilityCraftCard; 
			
			for (var i:int = 0; i < abilities.length; i ++) {
				card = new AbilityCraftCard(abilities[i]);
				cardLinks[abilities[i].id] = card;
				cards.push(card);
			}
			
			var page:AbilityPage = new AbilityPage();
			page.y = 120;
			pages.push(page);
			
			for (i = 0; i < cards.length; i ++) {
				if (page.cardsCount == 8) {
					page = new AbilityPage();
					page.y = 120;
					pages.push(page);
				}
				card = cards[i];
				page.addCard(card);
			}
            actualPage = pages[0];
			pagesStack.addChild(actualPage);
			
			
			
			if (pages.length > 1) {
				if (navigationInit) {
					container.addChild(rightSencor);
				} else {
					initPagesNavigation();
				}
			}
			
		}
		
		private function initPagesNavigation () :void {
			
			CollectionCursor.init();
			
			leftSencor = new Sprite();
			leftSencor.addChild(new Quad(40, 480, 0x444444));
			leftSencor.alpha = 0.01;
			leftSencor.y = 120;
			leftSencor.addEventListener (TouchEvent.TOUCH, onLeftClick); 
			
			rightSencor = new Sprite();
			rightSencor.addChild(new Quad(60, 420, 0x444444));
			rightSencor.y = 180;
			rightSencor.alpha = 0.01;
			rightSencor.x = 560;
			rightSencor.addEventListener (TouchEvent.TOUCH, onRightClick);
			
			navigationInit = true;
			
			if (pages.length > 1) {
				container.addChild(rightSencor);
			}

		}
		
		private function onLeftClick (event:TouchEvent) :void {  
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.HOVER)) {
				CollectionCursor.setState (CollectionCursor.LEFT);
			} else {
				CollectionCursor.setState (CollectionCursor.DEFAULT);
			}
			if (event.getTouch(this, TouchPhase.BEGAN)) 
			{
				CollectionCursor.setState (CollectionCursor.LEFT);
				previous();  
			}
		}
		
		private function onRightClick (event:TouchEvent) :void {
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.HOVER)) {
				CollectionCursor.setState (CollectionCursor.RIGHT);
			} else {
				CollectionCursor.setState (CollectionCursor.DEFAULT);
			}
			if (event.getTouch(this, TouchPhase.BEGAN)) 
			{
				CollectionCursor.setState (CollectionCursor.RIGHT);
				next();
			}
		}
		
		private function next () :void {
			pagesStack.removeChildren();
			if (pagesIndex < pages.length) {
				pagesIndex ++;
			}
			
			pagesStack.addChild(pages[pagesIndex]);
			controlSencors();
		}
		
		private function previous () :void {
			pagesStack.removeChildren();
			if (pagesIndex > 0) {
				pagesIndex --;
			}
			pagesStack.addChild(pages[pagesIndex]);
			controlSencors();
		}
		
		private function controlSencors () :void {
			if (pagesIndex > 0) {
				container.addChild(leftSencor);
			} else {
				if (container.contains(leftSencor)) { 
					container.removeChild(leftSencor);
				}
			}
			if (pagesIndex == pages.length - 1) {
				if (container.contains(rightSencor)) container.removeChild(rightSencor)
			} else {
				container.addChild(rightSencor);
			}
		}
		
	}

}