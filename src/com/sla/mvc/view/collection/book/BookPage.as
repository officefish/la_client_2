package com.sla.mvc.view.collection.book 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.view.card.CollectionCard;
	import feathers.controls.Label;
	import feathers.controls.TextArea;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BookPage extends Sprite 
	{
		private var shiftX:int = 15;
		private var shiftY:int = 100;
		
		private var titleLabel:Label;
		private var descriptionArea:TextArea;
		
		private var cardsStack:Sprite;

		public function BookPage(title:String, desription:String) {
			
			var quad:Quad = new Quad(620, 550, 0x888888);
			addChild(quad);
			
			cardsStack = new Sprite();
			addChild (cardsStack);
			
			titleLabel = new Label ();
			titleLabel.width = 400;
			titleLabel.styleNameList.add('bookTitleLabel');
			titleLabel.x = (this.width - titleLabel.width) / 2;
			titleLabel.y = 30;
			titleLabel.text = title;
			
			descriptionArea = new TextArea ();
			descriptionArea.width = 500;
			descriptionArea.height = 80;
			descriptionArea.touchable = false;
			descriptionArea.styleNameList.add('bookDescriptionArea');
			descriptionArea.x = (this.width - descriptionArea.width) / 2;
			descriptionArea.y = 55;
			descriptionArea.text = desription;
			
			addChild (titleLabel);
			addChild (descriptionArea);
			
			
			
			
		}

		public function get cardsCount () :int {
			return cardsStack.numChildren;
		}

		
		public function addCard (card:CollectionCard) :void {
			card.x = shiftX + CollectionCard.CARD_WIDTH/2; 
			card.y = shiftY + CollectionCard.CARD_HEIGHT/2;
			cardsStack.addChild (card);
			shiftX += (CollectionCard.CARD_WIDTH + 15);
			if (cardsStack.numChildren == 4) {
				shiftX = 15;
				shiftY += 35 + CollectionCard.CARD_HEIGHT;
			}
		}
		
		
		/*
		private static var _titleFormat:TextFormat;
		private static function get titleFormat () :TextFormat {
			if (!_titleFormat) {
				_titleFormat = new TextFormat ();
				_titleFormat.align = TextFormatAlign.CENTER;
				_titleFormat.size = 15;
				_titleFormat.color = 0xEEEEEE;
				_titleFormat.bold = true;
			}
			return _titleFormat;
		}
		
		private static var _descriptionFormat:TextFormat;
		private static function get descriptionFormat () :TextFormat {
			if (!_descriptionFormat) {
				_descriptionFormat = new TextFormat ();
				_descriptionFormat.align = TextFormatAlign.CENTER;
				_descriptionFormat.size = 13;
				_descriptionFormat.color = 0xDDDDDD;
			}
			return _descriptionFormat;
		}
		*/
		
	}

}