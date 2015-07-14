package com.la.mvc.view.achieves 
{
	import com.la.event.AchieveEvent;
	import com.la.mvc.model.AchieveData;
	import com.la.mvc.view.card.AchieveCard;
	import com.la.mvc.view.collection.CollectionCursor;
	import com.la.mvc.view.collection.LargeButton;
	import com.la.mvc.view.ui.SmallButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchievesView extends Sprite 
	{
		
		private var pages:Vector.<AchievePage>;
		private var actualPage:AchievePage;
		
		private var leftSencor:Sprite;
		private var rightSencor:Sprite;
		
		private var pagesStack:Sprite;
		private var navigationInit:Boolean = false;
		private var pagesIndex:int;
		
		private var bar:AchievesBar;
		
		private var cardLinks:Object;
		
		private var saveButton:LargeButton;
		private var closeButton:SmallButton; 
		
		private var createAchievesButton:SmallButton;
		
		public function AchievesView() 
		{
			graphics.beginFill(0x222222, 1);
			graphics.drawRect(0,0,800,600);
			graphics.endFill();
			
			pagesStack = new Sprite();
			addChild(pagesStack);
			
			bar = new AchievesBar();
			addChild(bar);
			
			saveButton = new LargeButton('Сохранить', 170);
			saveButton.addEventListener(MouseEvent.CLICK, onSaveClick);
			saveButton.x = this.width - 175;
			saveButton.y = this.height - 60;
			addChild(saveButton);
			
			closeButton = new SmallButton("закрыть");
			closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			closeButton.x = this.width - 75;
			closeButton.y = 5;
			addChild(closeButton);
			
			createAchievesButton = new SmallButton('Создание способностей', 165, 35);
			createAchievesButton.addEventListener (MouseEvent.CLICK, onCreateAchievesClick);
			createAchievesButton.x = 430;
			createAchievesButton.y = 127;
			addChild(createAchievesButton)
		}
		
		private function onCreateAchievesClick (event:MouseEvent) :void {
			parent.dispatchEvent(new AchieveEvent(AchieveEvent.CREATE, null))
		}
		
		public function setup(id:int, position:int) :void {
			var achieveCard:AchieveCard = getAchieveCardById(id);
			achieveCard.block();
			var achieveSlot:AchieveSlot = new AchieveSlot(achieveCard.getData());
			bar.addSlot(achieveSlot, position);
		}
		
		public function onCloseClick(event:MouseEvent) :void {
			parent.dispatchEvent(new AchieveEvent(AchieveEvent.CLOSE, null))

		}
		
		public function onSaveClick(event:MouseEvent) :void {
			var data:Array = bar.getSetupData();
			parent.dispatchEvent(new AchieveEvent(AchieveEvent.SAVE, {'setup':data}))
		}
		
		public function initHero(vocation:int) :void {
			bar.initHero(vocation);
		}
		
		public function initAchieves (achieves:Vector.<AchieveData>) :void {
			cardLinks = { };
			pagesIndex = 0;
			pages = new Vector.<AchievePage>();
			var cards:Vector.<AchieveCard> = new Vector.<AchieveCard>();
			var card:AchieveCard;
			for (var i:int = 0; i < achieves.length; i ++) {
				card = new AchieveCard(achieves[i]);
				cardLinks[achieves[i].id] = card;
				cards.push(card);
			}
			
			var page:AchievePage = new AchievePage();
			page.y = 120;
			pages.push(page);
			
			for (i = 0; i < cards.length; i ++) {
				if (page.cardsCount == 8) {
					page = new AchievePage();
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
					addChild(rightSencor);
				} else {
					initPagesNavigation();
				}
			} 
		}
		
		public function getAchieveCardById (id:int) :AchieveCard {
			return cardLinks[id];
		}
		
		private function initPagesNavigation () :void {
			
			if (navigationInit) return; 
			
			CollectionCursor.init(); 
			
			leftSencor = new Sprite();
			leftSencor.graphics.beginFill (0xCCCCC, 0.01);
			leftSencor.graphics.drawRect (0, 0, 30, 410);
			leftSencor.graphics.endFill();
			leftSencor.y = actualPage.y + 70;
			
			
			leftSencor.addEventListener (MouseEvent.MOUSE_OVER, onLeftMouseOver);
			leftSencor.addEventListener (MouseEvent.MOUSE_OUT, onNavOut);
			leftSencor.addEventListener (MouseEvent.CLICK, onLeftClick); 
			
			rightSencor = new Sprite();
			rightSencor.graphics.beginFill (0xCCCCC, 0.01);
			rightSencor.graphics.drawRect (0, 0, 60, 410);
			rightSencor.graphics.endFill();
			rightSencor.y = actualPage.y + 70;
			rightSencor.x = 560;
			
			
			rightSencor.addEventListener (MouseEvent.MOUSE_OVER, onRightMouseOver);
			rightSencor.addEventListener (MouseEvent.MOUSE_OUT, onNavOut);
			rightSencor.addEventListener (MouseEvent.CLICK, onRightClick);
			
			//addChild (leftSencor);
			addChild (rightSencor);
			
			navigationInit = true;
			

		}
		
		private function onLeftMouseOver (event:MouseEvent) :void {
			CollectionCursor.setState (CollectionCursor.LEFT);
		}
		
		private function onRightMouseOver (event:MouseEvent) :void {
			CollectionCursor.setState (CollectionCursor.RIGHT);
		}
		
		private function onLeftClick (event:MouseEvent) :void {
			previous ();
		}
		
		private function onRightClick (event:MouseEvent) :void {
			next ();
		}
		
		private function onNavOut (event:MouseEvent) :void {
			CollectionCursor.setState (CollectionCursor.DEFAULT);
		}
		
		private function previous () :void {
			while (pagesStack.numChildren) pagesStack.removeChildAt(0);
			if (pagesIndex > 0) {
				pagesIndex --;
			}
			pagesStack.addChild(pages[pagesIndex]);
			controlSencors();
		}
		
		private function next () :void {
			while (pagesStack.numChildren) pagesStack.removeChildAt(0);
			if (pagesIndex < pages.length) {
				pagesIndex ++;
			}
			pagesStack.addChild(pages[pagesIndex]);
			controlSencors();
		}
		
		private function controlSencors () :void {
			if (pagesIndex > 0) {
				addChild(leftSencor);
			} else {
				if (contains(leftSencor)) { 
					this.removeChild(leftSencor);
				}
			}
			if (pagesIndex == pages.length - 1) {
				if (contains(rightSencor)) removeChild(rightSencor)
			} else {
				addChild(rightSencor);
			}
		}
		
	}

}