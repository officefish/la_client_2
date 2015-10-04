package com.sla.mvc.view.collection.deck 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CountBar extends Sprite 
	{
		private var closeButton:Button;
		private var saveButton:Button;
		private var countLabel:Label;
		private var typeLabel:Label;
		
		private var count:int = 0;
		
		private static const MAX_DECKS:int = 9;
		private static const DECKS:String = 'Decks';
		
		private static const MAX_CARDS:int = 30;
		private static const CARDS:String = 'Cards';
		
		private var mode:int;
		
		public function CountBar() 
		{
			var quad:Quad = new Quad (180, 50, 0xEEEEEE);
			addChild(quad);
					
			closeButton = new Button ();
			closeButton.label = 'Close';
			closeButton.useHandCursor = true;
			closeButton.styleNameList.add('countBarButton');
			closeButton.x = 105;
			closeButton.y = 7;
			
			saveButton = new Button ();
			saveButton.label = 'Save';
			saveButton.useHandCursor = true;
			saveButton.styleNameList.add('countBarButton');
			saveButton.x = 105;
			saveButton.y = 7;
						
			countLabel = new Label();
			countLabel.styleNameList.add('countBarLabel');
			countLabel.width = 105;
			countLabel.height = 20;
			countLabel.text = count + '/' + MAX_DECKS;
			addChild (countLabel);
			countLabel.y = 8;
			
			typeLabel = new Label();
			typeLabel.styleNameList.add('countBarLabel');
			typeLabel.width = 105;
			typeLabel.height = 20;
			typeLabel.text = DECKS;
			typeLabel.y = 25;
			addChild (typeLabel);
			
		}
		
		public function setMode (mode:int) :void {
			if (contains(saveButton)) removeChild (saveButton);
			if (contains(closeButton)) removeChild (closeButton);
			
			this.mode = mode;
			if (mode) {
				addChild (saveButton);
			} else {
				addChild (closeButton);
			}
		}
		
		public function setCount (value:int) :void {
			this.count = value;
			if (mode) {
				countLabel.text = count + '/' + MAX_CARDS;
				typeLabel.text = CARDS;
			} else {
				countLabel.text = count + '/' + MAX_DECKS;
				typeLabel.text = DECKS;
			}
		}
		
		public function getCloseButton () :Sprite {
			return closeButton;
		}
		
		public function getSaveButton () :Sprite {
			return saveButton;
		}		
	}

}