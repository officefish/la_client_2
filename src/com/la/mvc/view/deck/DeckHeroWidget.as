/**
 * Created by root on 11/3/14.
 */
package com.la.mvc.view.deck {
import com.la.assets.Assets;
<<<<<<< HEAD
import com.la.mvc.model.HeroData;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class DeckHeroWidget extends Sprite {
<<<<<<< HEAD
    
	private var title:TextField;
	private var vocation:TextField;
	private var level:TextField;
	private var description:TextField;
	
	public function DeckHeroWidget() {
        graphics.beginFill(0xEEEEEE, 1);
        graphics.drawRect(0,0,200, 330);
        graphics.endFill();
		
		var titleFormat:TextFormat = new TextFormat();
=======
    public function DeckHeroWidget() {
        graphics.beginFill(0xEEEEEE, 1);
        graphics.drawRect(0,0,200, 330);
        graphics.endFill();
    }

    public function setHeroData (data:Object) :void {
        while (numChildren) removeChildAt(0);

        var asset:Bitmap = Assets.getHeroAssetById(data.uid);
        asset.x = 40;
        asset.y = - 30;
        addChild(asset);

        var titleFormat:TextFormat = new TextFormat();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        titleFormat.bold = true;
        titleFormat.size = 18;
        titleFormat.align = TextFormatAlign.CENTER;

<<<<<<< HEAD
        title = new TextField();
        title.defaultTextFormat = titleFormat;
        title.width = this.width;
		title.mouseEnabled = false;
        title.y = 110;
		
		var vocationFormat:TextFormat = new TextFormat();
=======
        var title:TextField = new TextField();
        title.defaultTextFormat = titleFormat;
        title.width = this.width;
        title.y = 110;
        title.text = data.title;
        addChild(title);

        var vocationFormat:TextFormat = new TextFormat();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        vocationFormat.bold = true;
        vocationFormat.size = 14;
        vocationFormat.align = TextFormatAlign.CENTER;

<<<<<<< HEAD
        vocation = new TextField();
        vocation.defaultTextFormat = vocationFormat;
        vocation.width = this.width;
		vocation.mouseEnabled = false;
        vocation.y = 135;
		
		var descriptionFormat:TextFormat = new TextFormat();
=======
        var vocation:TextField = new TextField();
        vocation.defaultTextFormat = vocationFormat;
        vocation.width = this.width;
        vocation.y = 135;
        vocation.text = data.vocation;
        addChild(vocation);

        var descriptionFormat:TextFormat = new TextFormat();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        descriptionFormat.bold = true;
        descriptionFormat.size = 12;
        descriptionFormat.align = TextFormatAlign.LEFT;
        descriptionFormat.leftMargin = 10;

<<<<<<< HEAD
        description = new TextField();
=======
        var description:TextField = new TextField();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        description.defaultTextFormat = descriptionFormat;
        description.width = this.width;
        description.height = 140;
        description.wordWrap = true;
<<<<<<< HEAD
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
=======
        description.y = 210;
        description.text = data.description;
        addChild(description);

        var levelSprite:Sprite = new Sprite();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        levelSprite.graphics.beginFill(0xCCCCCC,1);
        levelSprite.graphics.drawRect(0,0,30,30);
        levelSprite.graphics.endFill();
        levelSprite.y = 80;
        levelSprite.x = (this.width - levelSprite.width) / 2;
        addChild(levelSprite);
<<<<<<< HEAD
   		level.width = levelSprite.width;
		levelSprite.addChild(level);

        title.text = data.title;
        vocation.text = data.vocation;
        description.text = data.description;
		
        level.text = data.level.toString();
		
		var achiveSprite:Sprite = new Sprite();
=======

        var levelFormat:TextFormat = new TextFormat();
        levelFormat.bold = true;
        levelFormat.size = 22;
        levelFormat.align = TextFormatAlign.CENTER;

        var level:TextField = new TextField();
        level.defaultTextFormat = levelFormat;
        level.width = levelSprite.width;
        level.text = data.level;
        levelSprite.addChild(level);

        var achiveSprite = new Sprite();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
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
<<<<<<< HEAD
=======




>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }
}
}
