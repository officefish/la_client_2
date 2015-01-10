/**
 * Created by root on 11/3/14.
 */
package com.la.mvc.view.deck {
import com.la.assets.Assets;
import com.la.mvc.model.HeroData;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class DeckHeroWidget extends Sprite {
	private var title:TextField;
	private var vocation:TextField;
	private var level:TextField;
	private var description:TextField;
	
	public function DeckHeroWidget() {
        graphics.beginFill(0xEEEEEE, 1);
        graphics.drawRect(0,0,200, 330);
        graphics.endFill();
		
		var titleFormat:TextFormat = new TextFormat();
        titleFormat.bold = true;
        titleFormat.size = 18;
        titleFormat.align = TextFormatAlign.CENTER;

        title = new TextField();
        title.defaultTextFormat = titleFormat;
        title.width = this.width;
		title.mouseEnabled = false;
        title.y = 110;
		
		var vocationFormat:TextFormat = new TextFormat();
        vocationFormat.bold = true;
        vocationFormat.size = 14;
        vocationFormat.align = TextFormatAlign.CENTER;

        vocation = new TextField();
        vocation.defaultTextFormat = vocationFormat;
        vocation.width = this.width;
		vocation.mouseEnabled = false;
        vocation.y = 135;
		
		var descriptionFormat:TextFormat = new TextFormat();
        descriptionFormat.bold = true;
        descriptionFormat.size = 12;
        descriptionFormat.align = TextFormatAlign.LEFT;
        descriptionFormat.leftMargin = 10;

		description = new TextField();
        description.defaultTextFormat = descriptionFormat;
        description.width = this.width;
        description.height = 140;
        description.wordWrap = true;
		description.mouseEnabled = false;
        description.y = 210;
		
        var levelFormat:TextFormat = new TextFormat();
        levelFormat.bold = true;
        levelFormat.size = 22;
        levelFormat.align = TextFormatAlign.CENTER;

        level = new TextField();
		level.mouseEnabled = false;
        level.defaultTextFormat = levelFormat;
       
    }

    public function setHeroData (data:HeroData) :void {
        while (numChildren) removeChildAt(0);

        var asset:Bitmap = Assets.getHeroAssetById(data.uid);
        asset.x = 40;
        asset.y = - 30;
        addChild(asset);
		
        addChild(title);
        addChild(vocation);
        addChild(description);
		
		var levelSprite:Sprite = new Sprite();
        levelSprite.graphics.beginFill(0xCCCCCC,1);
        levelSprite.graphics.drawRect(0,0,30,30);
        levelSprite.graphics.endFill();
        levelSprite.y = 80;
        levelSprite.x = (this.width - levelSprite.width) / 2;
        addChild(levelSprite);
   		level.width = levelSprite.width;
		levelSprite.addChild(level);

        title.text = data.title;
        vocation.text = data.vocation;
        description.text = data.description;
		
        level.text = data.level.toString();
		
		var achiveSprite:Sprite = new Sprite();
        achiveSprite.y = 170;
        addChild(achiveSprite);

        var shift:int = 14;

        for (var i:int = 0; i < 4; i ++) {
            var achive:Sprite = new Sprite();
            achive.graphics.beginFill(0x777777, 1);
            achive.graphics.drawRect(0,0,30,30);
            achive.graphics.endFill();
            achive.x = 20 + (achive.width * i + shift * i);
            achiveSprite.addChild(achive);
        }
    }
}
}
