/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
import com.la.assets.Assets;
import com.transform.Transform;
<<<<<<< HEAD
import flash.geom.Point;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class Hero extends Sprite implements IHero{

    private var health:int;
    private var healthLabel:TextField;
    private var enemy:Boolean = false;
    private var maxHealth:int;
    private var spellBob:int = 0;

    public static const ADVENTURER:int = 0;
    public static const MONK:int = 1;
    public static const HUNTER:int = 2;

    private var healthBackground:Sprite;
<<<<<<< HEAD
	
	private var asset:Bitmap;
	private var type:int;
	private var hideHealthFlag:Boolean = true;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public function Hero() {

        this.health = health;
        this.enemy = enemy;
        this.maxHealth = health;

        var format:TextFormat = new TextFormat ();
        format.size = 15;
        format.color = 0x222222;
        format.align = TextFormatAlign.CENTER;
        format.bold = true;

        graphics.beginFill (0xAAAAAA, 1);
        graphics.drawRect (0, 0, 80, 80);
        graphics.endFill ();

        healthLabel = new TextField ();
        healthLabel.width = 20;
        healthLabel.defaultTextFormat = format;
        healthLabel.text = "" + health;
        healthLabel.autoSize = TextFieldAutoSize.LEFT;
        healthLabel.wordWrap = true;
        healthLabel.mouseEnabled = false;
        healthLabel.selectable = false;

        healthLabel.x = 60;
        healthLabel.y = 60;

        healthBackground = new Sprite();
        healthBackground.graphics.beginFill(0xEEEEEE,1);
        healthBackground.graphics.drawRect(0,0,20,20);
        healthBackground.graphics.endFill();
        healthBackground.x = healthBackground.y = 60;
<<<<<<< HEAD
        //addChild(healthBackground);
=======
        addChild(healthBackground);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }

    public function set isEnemy (value:Boolean) :void {
        enemy = value;
    }
    public function get isEnemy () :Boolean {
        return enemy;
    }

    public function hideHealth () :void {

<<<<<<< HEAD
        this.hideHealthFlag = true;
		
		graphics.clear();
=======
        graphics.clear();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        graphics.beginFill (0xAAAAAA, 1);
        graphics.drawRect (0, 0, 80, 80);
        graphics.endFill ();

        if (contains(healthBackground)) removeChild(healthBackground);
        if (contains(healthLabel)) removeChild(healthLabel);
    }

    public function showHealth () :void {

<<<<<<< HEAD
        this.hideHealthFlag = false;
		
		graphics.clear();
=======
        graphics.clear();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        graphics.beginFill (0xAAAAAA, 1);
        graphics.drawRect (0, 0, 80, 80);
        graphics.endFill ();

        graphics.beginFill (0x0FFFFFF, 1);
        graphics.drawRect (60, 60, 20, 20);
        graphics.endFill ();

        addChild(healthBackground);
        addChild(healthLabel);
    }

    public function setType (value:int) :void {
<<<<<<< HEAD
        this.type = value;
		asset = Assets.getHeroAssetById(value);
=======
        var asset:Bitmap = Assets.getHeroAssetById(value);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        asset = Transform.scale(asset, 80/asset.width);
        addChildAt(asset, 0);
    }

    public function setHealth (value:int) :void {
        this.health = value;
        healthLabel.text = "" + health;
<<<<<<< HEAD
    }
	
	public function setAttack (value:int) :void {
		
	}
	
	public function getAttack () :int {
		return 0;
	}
	
	public function setMaxHealth (value:int) :void {
		
	}
	
	public function getMaxHealth () :int {
		return health;
	}
	
	
	
	public function getHealth () :int {
		return health;
	}
	
	public function glow () :void { };
	public function stopGlow () :void { };
	
	public function getPosition () :Point {
		return new Point (this.x, this.y);
	}
	
	public function clone () :IHero {
		var cloneHero:Hero = new Hero ();
		if (contains(asset)) {
			cloneHero.setType (type);
			cloneHero.setHealth(health);
			if (!hideHealthFlag) {
				cloneHero.showHealth();
			}
		}
		return cloneHero;
	}
=======

    }
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
}
}
