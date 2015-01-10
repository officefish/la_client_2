/**
 * Created by root on 9/16/14.
 */
package com.la.mvc.view.collection {
import com.la.mvc.view.card.CollectionCard;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class BookPage extends Sprite {

    private var shiftX:int = 20;
    private var shiftY:int = 100;
	
	private var titleLabel:TextField;
	private var descriptionLabel:TextField;
	
	private var cardsStack:Sprite;

    public function BookPage(title:String, desription:String) {
        graphics.beginFill(0x888888, 1);
        graphics.drawRect(0,0,620,550);
        graphics.endFill();
		
		titleLabel = new TextField ();
		titleLabel.width = 400;
		titleLabel.defaultTextFormat = BookPage.titleFormat;
		titleLabel.x = (this.width - titleLabel.width) / 2;
		titleLabel.y = 30;
		titleLabel.mouseEnabled = false;
		titleLabel.text = title;
		
		descriptionLabel = new TextField ();
		descriptionLabel.width = 500;
		descriptionLabel.defaultTextFormat = BookPage.descriptionFormat;
		descriptionLabel.x = (this.width - descriptionLabel.width) / 2;
		descriptionLabel.y = 55;
		descriptionLabel.mouseEnabled = false;
		descriptionLabel.text = desription;
		
		addChild (titleLabel);
		addChild (descriptionLabel);
		
		cardsStack = new Sprite();
		addChild (cardsStack);
		
		
    }

    public function get cardsCount () :int {
        return cardsStack.numChildren;
    }

    public function addCard (card:CollectionCard) {
        card.x = shiftX;
		card.y = shiftY;
		cardsStack.addChild (card);
		shiftX += (card.width + 15);
        if (cardsStack.numChildren == 4) {
            shiftX = 20;
            shiftY += 10 + card.height;
        }
	}
	
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
}
}
