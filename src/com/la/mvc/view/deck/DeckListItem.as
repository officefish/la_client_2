/**
 * Created by root on 11/3/14.
 */
package com.la.mvc.view.deck {
import com.la.assets.Assets;
import com.la.event.DeckEvent;
import com.la.mvc.model.DeckData;
import fl.controls.Button;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class DeckListItem extends Sprite {

    private var titleSprite;
    private var titleLabel:TextField;
    private var editButton:Button;

    private var shirme:Sprite;
    private var id:int;
    private var uid:int;
    private var hero_id:int;
	private var deckData:DeckData;

    public function DeckListItem(deckData:DeckData) {

        this.id = deckData.id;
        this.uid = deckData.uid;
		this.deckData = deckData;

        var asset:Bitmap = Assets.getHeroAssetById(uid);
        addChild(asset);

        shirme = new Sprite();
        shirme.graphics.beginFill(0x222222, 0.7);
        shirme.graphics.drawRect(0,0,asset.width,asset.height);
        shirme.graphics.endFill();

        editButton = new Button();
        editButton.label = 'собрать';
        editButton.x = (this.width - editButton.width) / 2;
        editButton.y = (this.height - editButton.height) / 2;
		editButton.addEventListener (MouseEvent.CLICK, onEditClick);

        if (deckData.complicated) {
            this.buttonMode = true;
            addEventListener(MouseEvent.CLICK, onClick);
        } else {
            addChild(shirme);
            addChild(editButton);
        }

        titleSprite = new Sprite();
        titleSprite.graphics.beginFill(0x222222, 0.8);
        titleSprite.graphics.drawRect(0,0,asset.width, 25);
        titleSprite.graphics.endFill();
        titleSprite.y = asset.height - 25;
        addChild(titleSprite);

        var format:TextFormat = new TextFormat();
        format.bold = true;
        format.color = 0xEEEEEE;
        format.size = 15;
        format.align = TextFormatAlign.CENTER;

        titleLabel = new TextField();
        titleLabel.width = this.width;
        titleLabel.defaultTextFormat = format;
        titleLabel.text = deckData.title;
        titleLabel.mouseEnabled = false;
        titleLabel.height = 25;
        titleSprite.addChild(titleLabel);

    }
	public function getDeckData () :DeckData {
		return deckData;
	}

    private function onClick (event:MouseEvent) :void {
        dispatchEvent(new DeckEvent(DeckEvent.SELECT, {}))
    }

    public function select () :void {
        this.filters = [new GlowFilter (0x00FFFF)];
    }

    public function deselect () :void {
        this.filters = [];
    }

    public function getUid () :int {
        return uid;
    }
	private function onEditClick (event:MouseEvent) :void {
		dispatchEvent (new DeckEvent(DeckEvent.INTRO_EDIT_CLICK, { deckData:deckData }));
	}
}
}
