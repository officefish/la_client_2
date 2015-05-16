/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
import com.la.assets.Assets;
import com.transform.Transform;
import flash.geom.Point;
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

	private var asset:Bitmap;
	private var type:int;
	private var hideHealthFlag:Boolean = true;
	
	private var freezeSprite:Sprite;
	private var freezeFlag:Boolean = false;

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
        //addChild(healthBackground);
        addChild(healthBackground);
		
		freezeSprite = new Sprite ();
		freezeSprite.graphics.beginFill (0x56A5EC, 0.7);
		freezeSprite.graphics.drawRect (0, 0, 80, 80);
		freezeSprite.graphics.endFill ();
		freezeSprite.mouseEnabled = false;
	
    }
	
	public function clear () :void {
		while (this.numChildren) this.removeChildAt(0);
		freezeFlag = false;
	}

    public function set isEnemy (value:Boolean) :void {
        enemy = value;
    }
    public function get isEnemy () :Boolean {
        return enemy;
    }
	
	public function getDefaultHealth () :int {
		return health; 
	}

    public function hideHealth () :void {

        this.hideHealthFlag = true;
		
        graphics.clear();
        graphics.beginFill (0xAAAAAA, 1);
        graphics.drawRect (0, 0, 80, 80);
        graphics.endFill ();

        if (contains(healthBackground)) removeChild(healthBackground);
        if (contains(healthLabel)) removeChild(healthLabel);
    }

    public function showHealth () :void {

        this.hideHealthFlag = false;
        graphics.clear();
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
        this.type = value;
		asset = Assets.getHeroAssetById(value);
        asset = Transform.scale(asset, 80/asset.width);
        addChildAt(asset, 0);
    }

    public function setHealth (value:int) :void {
        this.health = value;
        healthLabel.text = "" + health;
    }
	
	public function setAttack (value:int) :void {
		
	}
	
	public function getAttack () :int {
		return 0;
	}
	
	public function setMaxHealth (value:int) :void {
		this.maxHealth = value;
	}
	
	public function getMaxHealth () :int {
		return maxHealth;
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
		if (isFreeze()) {
			cloneHero.activateFreeze();
		}
		return cloneHero;
	}
	
	public function getAttackBob () :int {
        return 0
    }
    public function setAttackBob (value:int) :void {
        
    }
	
	public function treatment (value:int) :void {
		health += value;
		if (health > maxHealth) {
			health = maxHealth;
		}
        healthLabel.text = "" + health;
	}
	
	public function activateShield () :void {
         
    }

    public function destroyShield () :void {
    
	}
	
	public function activateShadow () :void {
		
	}
	
	public function destroyShadow() :void {
		
	}
	
	public function dumbness () :void {
		
	}
	
	public function activateDoubleAttack()  :void { };
	public function deactivateDoubleAttack() :void { };
	public function set canAttack (value:Boolean) :void {};
	public function get canAttack () :Boolean { return false };
	public function activateProvocation () :void {};
	public function deactivateProvocation () :void { };
	
	public function activateFreeze () :void {
		freezeFlag = true;
		addChild (freezeSprite);
	}
		
	public function deactivateFreeze () :void {
		freezeFlag = false;
		if (contains(freezeSprite)) {
			removeChild (freezeSprite);
		}
	}
	
	public function isFreeze () :Boolean {
		return freezeFlag;
	}
	
	public function activateSpellInvisible () :void {
     
    }
    public function deactivateSpellInvisible () :void {
           
    }
	
	public function activateSpellUp() :void {
		
	}
	
	public function deactivateSpellUp () :void {
		
	}


}
}
