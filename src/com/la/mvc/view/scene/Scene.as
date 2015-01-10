/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.scene {
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.la.event.SceneEvent;
import com.la.mvc.view.card.Card;
import com.la.mvc.view.card.PreflopCard;
import com.la.mvc.view.field.IHero;
import com.la.mvc.model.CardData;
import com.la.mvc.view.scene.popup.WarningPopup;
import com.la.mvc.view.ui.StepTimerWidget;
import flash.events.Event;


import fl.controls.Button;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.Dictionary;

public class Scene extends Sprite implements IScene{

    private var stageWidth:int;
    private var stageHeight:int;

    private var _preflopCards:Vector.<PreflopCard>;
    private var animationCof:int = 0;
    private var _preflopButton:Button;
    private var _newPreflopPositions:Vector.<Point>;

    private var backToDeckCards:Array;

    private var placeCardLevel:Sprite;
	private var trajectoryLevel:Sprite; 


    private static const SCALE_INDEX:Number = 0.72;

    private var darkenSprite:Sprite;

    private var playerHero:IHero;
    private var opponentHero:IHero;
    private var heroesSprite:Sprite;
    private var preflopContainer:Sprite;

	private var attackTokenPosition:Point;
	
	private var previewContainer:Sprite;

	private var stepTimer:StepTimerWidget;

    public function Scene() {
		this.placeCardLevel = new Sprite();
		placeCardLevel.mouseEnabled = false;
		placeCardLevel.name = 'placeCardLevel';
        addChild(placeCardLevel);

        darkenSprite = new Sprite();
        darkenSprite.mouseEnabled = false;
		darkenSprite.name = 'darkenSprite';
		addChild(darkenSprite);

        heroesSprite = new Sprite ();
		heroesSprite.mouseEnabled = false;
        heroesSprite.name = 'heroesSprite';
		addChild(heroesSprite);

        preflopContainer = new Sprite();
        preflopContainer.mouseEnabled = false;
		preflopContainer.name = 'preflopContainer';
		addChild(preflopContainer);
			
		trajectoryLevel = new Sprite();
		trajectoryLevel.name = 'trajectoryLevel';
		trajectoryLevel.mouseEnabled = false;
		addChild (trajectoryLevel);
		
		previewContainer = new Sprite();
		previewContainer.mouseEnabled = false;
		previewContainer.name = 'previewContainer';
		addChild(previewContainer);
		
		this.mouseEnabled = false;
		
		
    }

    public function resize (stageWidth:int, stageHeight:int) :void {
        this.stageWidth = stageWidth;
        this.stageHeight = stageHeight;
    }

    public function preflopCards (cards:Vector.<CardData>) :void {

        var card:Card;
        var shift:int = 20;

        var cardsTotalWidth:int = cards.length * Card.MIRROR_WIDTH;
        var totalShift:int = (cards.length - 1) * 20;
        var startX:int = (stageWidth - (cardsTotalWidth + totalShift)) / 2;

        for (var i:int = 0; i < cards.length; i ++) {
            card = new PreflopCard(cards[i]);
            preflopContainer.addChild(card);
            card.x = 500 + shift * i;
            card.y = (this.stageHeight - card.getMirror().height) / 2 - 40;
            card.buttonMode = true;
            animationCof ++;
            TweenLite.to (card, 1.0, {x:startX, ease:Expo.easeOut, onComplete:onPreviewComplete});
            startX += (card.width + shift);
        }
    }

    private function onPreviewComplete () :void {
        animationCof --;
        if (!animationCof) {
            for (var i:int = 0; i < preflopContainer.numChildren; i ++) {
                var card:PreflopCard = preflopContainer.getChildAt(i) as PreflopCard;
                if (card) card.glow();
            }
            preflopButton.x = (stageWidth - preflopButton.width) / 2;
            preflopButton.y = stageHeight/2 + 100;
            preflopButton.addEventListener(MouseEvent.CLICK, onPreflopButtonClick);
            addChild(preflopButton);
        }
    }

    private function get preflopButton () :Button {
        if (_preflopButton == null) {
            _preflopButton = new Button();
            _preflopButton.height = 35;
            _preflopButton.label = 'Выбрать';
            _preflopButton.buttonMode = true;
        }
        return _preflopButton;
    }

    private function onPreflopButtonClick (event:MouseEvent) :void {
        changePreflopCards()
    }

    public function changePreflopCards () :void {

        preflopButton.removeEventListener(MouseEvent.CLICK, onPreflopButtonClick);
        if (contains(preflopButton)) {
            removeChild(preflopButton);
        }

        backToDeckCards = [];
        var delay:Number = 0;
        _newPreflopPositions = new Vector.<Point>();

        var cards:Vector.<DisplayObject> = getClassInstances(preflopContainer, PreflopCard);

        for (var i:int = 0; i < cards.length; i ++) {
            var preflopCard:PreflopCard  = cards[i] as PreflopCard;
            preflopCard.block ();
            if (!preflopCard.select) {
                _newPreflopPositions.push(new Point (preflopCard.x, preflopCard.y));
                var data:Object = {'index':preflopContainer.getChildIndex(preflopCard), 'id':preflopCard.getCardData().id}
                backToDeckCards.push(data);
                animationCof ++;
                preflopContainer.addChild(preflopCard);
                TweenLite.to (preflopCard, 1.0, {
                    x:stageWidth + 200,
                    y:preflopCard.y,
                    ease:Expo.easeIn,
                    onComplete:onReplaceComplete,
                    onCompleteParams: [preflopCard],
                    delay:delay
                });
                delay += 0.2;
            }
        }

        if (!animationCof) {
            dispatchEvent(new SceneEvent (SceneEvent.CHANGE_PREFLOP, {'replacement':[]}))
        }

    }

    private function getClassInstances (container:DisplayObjectContainer, cl:Class) :Vector.<DisplayObject> {
        var vector:Vector.<DisplayObject> = new Vector.<DisplayObject>();
        for (var i:int = container.numChildren - 1; i > -1; i --) {
            var child:DisplayObject = container.getChildAt(i);
            if (child is cl) {
                vector.push(child)
            }
        }
        return vector;
    }

    private function onReplaceComplete (target:Sprite) :void {
        preflopContainer.removeChild(target);
        animationCof --;
        if (!animationCof) {
            dispatchEvent(new SceneEvent (SceneEvent.CHANGE_PREFLOP, {'replacement':backToDeckCards}));
            return;
        }
    }

    public function replacePreflopCards (replacement:Vector.<CardData>) :void {
        if (!replacement.length) {
            preflopInit();
            return;
        }
        animationCof = 0;
        var delay:Number = 0;
        var position:Point;
        for (var i:int = 0; i < replacement.length; i ++) {
            var card:PreflopCard = new PreflopCard(replacement[i]);
            preflopContainer.addChild(card);
            card.x = stageWidth + 100;
            card.y = (this.stageHeight - card.getMirror().height) / 2 - 40;
            animationCof ++;
            position = _newPreflopPositions.shift();
            TweenLite.to (card, 1.0, {delay:delay, x:position.x, ease:Expo.easeOut, onComplete:onPreflopComplete});
            delay += 0.2;
        }
    }

    private function onPreflopComplete () :void {
        animationCof --;
        if (!animationCof) {
           preflopInit();
           return;
        }
    }

    private function preflopInit () :void {
        var markToRemove:Vector.<Card> = new Vector.<Card>();
        initPreflopCards();
        for (var i:int = 0; i < _preflopCards.length; i ++) {
            preflopContainer.addChild(_preflopCards[i]);
            _preflopCards[i].stopGlow();
        }
        dispatchEvent(new SceneEvent(SceneEvent.PREFLOP_INIT, {}));
    }

    private function initPreflopCards () :void {
        _preflopCards = new Vector.<PreflopCard>();
        var item:PreflopCard;
        for (var i:int = 0; i < preflopContainer.numChildren; i ++) {
            item = preflopContainer.getChildAt(i) as PreflopCard;
            if (item) {
                _preflopCards.push(item);
            }

        }
        _preflopCards.sort(sortByXPosition);
        for (i = 0; i < _preflopCards.length; i ++) {

            preflopContainer.addChild(_preflopCards[i]);
        }
    }

    private function sortByXPosition (a, b) :int {
       var x1:int = a.x;
       var x2:int = b.x;
       if (x1 < x2)
       {
            return -1;
       }
       else if (x1 > x2)
       {
            return 1;
       }
       else
       {
            return 0;
       }
    }

    public function moveDownPreflop (cards:Vector.<Card>, shiftX:int) :void {
        if (!_preflopCards) initPreflopCards();

        var card:Card;
        var preflopCard:PreflopCard;
        animationCof = 0;
        for (var i:int = 0; i < cards.length; i ++) {
            card = cards[i];
            preflopCard = _preflopCards[i] as PreflopCard;
            animationCof ++;

            TweenLite.to (preflopCard, 1, {
                x:card.x + shiftX,
                y:card.y,
                scaleX:SCALE_INDEX,
                scaleY:SCALE_INDEX,
                ease:Expo.easeInOut,
                onComplete:onMoveDownComplete});

        }
    }

    private function onMoveDownComplete () :void {
        animationCof --;
        if (!animationCof) {
            clearPreflop ();
            dispatchEvent(new SceneEvent(SceneEvent.PREFLOP_COMPLETE, {}));
        }
    }

    private function clearPreflop () :void {
        while(preflopContainer.numChildren) preflopContainer.removeChildAt(0);
    }

    public function placeCard (card:DisplayObject) :void {
        placeCardLevel.addChild(card);
    }
	
	public function warning  (msg:String, confirmFlag:Boolean = false, cancelFlag:Boolean = false) :void {
		var popup:WarningPopup = new WarningPopup (msg, confirmFlag, cancelFlag, onConfirm, onCancel);
		popup.x = (stageWidth - popup.width) / 2;
		popup.y = (stageHeight - popup.height) / 2;
		preflopContainer.addChild (popup);
		
		if (!confirmFlag && !cancelFlag) {
			popup.addEventListener (MouseEvent.CLICK, onWarningStageClick);
		}
	}
	
	private function onConfirm () :void {
		clearPreflop();
		dispatchEvent (new SceneEvent(SceneEvent.WARNING_CONFIRM, {}));
	}
	
	private function onCancel () :void {
		clearPreflop();
		dispatchEvent (new SceneEvent(SceneEvent.WARNING_CANCEL, {}));
	}
	
	private function onWarningStageClick (event:MouseEvent) :void {
		event.target.removeEventListener (MouseEvent.CLICK, onWarningStageClick);
		clearPreflop();
		dispatchEvent (new SceneEvent(SceneEvent.WARNING_CLOSE, {}));
	}



    public function endPlaceCard () :void {
        while (placeCardLevel.numChildren) placeCardLevel.removeChildAt(0);
    }

    public function setPlayerHero (hero:IHero) :void {
        this.playerHero = hero;
    }

    public function setOpponentHero (hero:IHero) :void {
        this.opponentHero = hero;
    }

    private function get playerHeroDO () :DisplayObject {
        return playerHero as DisplayObject;
    }

    private function get opponentHeroDO () :DisplayObject {
        return opponentHero as DisplayObject;
    }

    public function welcomeAnimation () :void {

        playerHeroDO.x = (stageWidth/2 - playerHeroDO.width) / 2;
        playerHeroDO.y = (stageHeight - playerHeroDO.height) / 2;

        opponentHeroDO.x = (stageWidth/2 - opponentHeroDO.width) / 2 + stageWidth/2;
        opponentHeroDO.y = (stageHeight - opponentHeroDO.height) / 2;

        heroesSprite.addChild(playerHeroDO);
        heroesSprite.addChild(opponentHeroDO);

        var playerPosition:Point = new Point();
        playerPosition.x = (stageWidth - playerHeroDO.width) / 2;
        playerPosition.y = stageHeight - 60 - playerHeroDO.height;

        var opponentPosition:Point = new Point();
        opponentPosition.x = (stageWidth - playerHeroDO.width) / 2;
        opponentPosition.y = 40;

        animationCof = 2;

        TweenLite.to (playerHeroDO, 1.0, {delay:1.5, x:playerPosition.x, y:playerPosition.y, ease:Expo.easeOut, onComplete:onWelcomeComplete});
        TweenLite.to (opponentHeroDO, 1.0, {delay:1.5, x:opponentPosition.x, y:opponentPosition.y, ease:Expo.easeOut,onComplete:onWelcomeComplete});
    }

    private function onWelcomeComplete () :void {
        animationCof --;
        if (!animationCof) {
            dispatchEvent(new SceneEvent(SceneEvent.WELCOME_COMPLETE, {}));
        }
    }

    public function darken () :void {
        if (!contains(darkenSprite)) {
			addChildAt(darkenSprite, 1);
		}
		darkenSprite.alpha = 1;
		darkenSprite.graphics.clear();

        darkenSprite.graphics.beginFill(0x222222,0.8);
        darkenSprite.graphics.drawRect(0,0,stageWidth,stageHeight);
        darkenSprite.graphics.endFill();
    }

    public function lighten (dispatch:Boolean = true) :void {
		if (dispatch) {
	        TweenLite.to (darkenSprite, 1.0, {alpha:0, ease:Expo.easeOut, onComplete:onLightenComplete});
		} else {
	        TweenLite.to (darkenSprite, 1.0, {alpha:0, onComplete:onLightenNoDispatchComplete, ease:Expo.easeOut});
		}
    }
	
	private function onLightenNoDispatchComplete () :void {
		if (contains(darkenSprite)) {
            removeChild(darkenSprite);
            darkenSprite.alpha = 1;
		}
	}

    private function onLightenComplete () :void {
        if (contains(darkenSprite)) {
            removeChild(darkenSprite);
            darkenSprite.alpha = 1;
            dispatchEvent(new SceneEvent(SceneEvent.LIGHTEN_COMPLETE, {}))
        }
    }
	
	public function setAttackTokenPosition (position:Point) :void {
			this.attackTokenPosition = position	
	}
	
	public function startDraw () :void {
		this.stage.addEventListener (Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function stopDraw () :void {
		this.stage.removeEventListener (Event.ENTER_FRAME, onEnterFrame);
		trajectoryLevel.graphics.clear ();
	}
		
		
		
	private function onEnterFrame (event:Event) :void {
		trajectoryLevel.graphics.clear ();
		trajectoryLevel.graphics.lineStyle (1, 0xFFFF00, 1);
		trajectoryLevel.graphics.moveTo (attackTokenPosition.x, attackTokenPosition.y);
		trajectoryLevel.graphics.lineTo (mouseX, mouseY);
	}
	
	public function clear () :void {
		while (placeCardLevel.numChildren) {
		    placeCardLevel.removeChildAt (0);
		}
		while (darkenSprite.numChildren) {
		    darkenSprite.removeChildAt (0);
		}
		while (heroesSprite.numChildren) {
			heroesSprite.removeChildAt (0);
		}
		while (preflopContainer.numChildren) {
		    preflopContainer.removeChildAt (0);
		}
		while (trajectoryLevel.numChildren) {
		    trajectoryLevel.removeChildAt (0);
		}
	}
	
	public function placePreview (value:DisplayObject) :void {
		previewContainer.addChild (value);
	}
	public function endPreview () :void {
		while (previewContainer.numChildren) {
			previewContainer.removeChildAt (0);
		}
	}
	
	public function placeCopy (copy:DisplayObject) :void {
		heroesSprite.addChild (copy);
	}
	
	public function endCopy() :void {
		while (heroesSprite.numChildren) heroesSprite.removeChildAt(0);
	}
	
	public function runStepTimer () :void {
		stepTimer = new StepTimerWidget();
		stepTimer.initTimer (10);
		stepTimer.resize (stageWidth, stageHeight);
		stepTimer.y = stageHeight / 2;
		trajectoryLevel.addChild (stepTimer);
		stepTimer.run();
	}
	
	public function stopStepTimer () :void {
		if (stepTimer) {
			stepTimer.stop();
			stepTimer.destroy();
		}
		while (trajectoryLevel.numChildren) trajectoryLevel.removeChildAt(0);
	}









}
}
