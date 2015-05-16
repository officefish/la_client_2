/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
import com.demonsters.debugger.MonsterDebugger;
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Expo;
import com.greensock.easing.ExpoOut;
import com.hurlant.util.der.OID;
import com.la.event.FieldEvent;
import com.la.event.ScenarioEvent;
import com.la.mvc.view.card.Card;
import com.la.mvc.view.scene.IScene;
import com.la.mvc.view.token.Token;
import com.la.mvc.model.CardData;
import flash.display.DisplayObjectContainer;
import flash.filters.BlurFilter;
import com.la.mvc.view.token.Token;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import com.la.mvc.view.IAttackAvailable;

public class Field extends Sprite implements IField {

    private var stageWidth:int;
    private var stageHeight:int;

    private var playerHero:IHero;
    private var opponentHero:IHero;

    private var stepButton:StepButton;

    private var playerPriceWidget:PriceWidget;
    private var opponentPriceWidget:PriceWidget;
	
	private var overloadWidget:OverloadWidget;


    private var playerRow:UnitRow;
    private var opponentRow:UnitRow;
	private var actualRow:UnitRow;

    private var tokenPreviewIndex:int = 0;
	private var actualToken:Token;
	private var _sygnal:Boolean = false;
	private var scene:IScene;
	
	private var clientCardsWidget:DeckWidget;
	private var opponentCardsWidget:DeckWidget;
	
	private function set sygnal (value:Boolean) :void {
		this._sygnal = value;
	}
	
	private function get sygnal () :Boolean {
		return _sygnal
	}
	
	public function setScene (scene:IScene) :void {
		this.scene = scene;
	}

    public function resize (stageWidth:int, stageHeight:int) :void {
        this.stageWidth = stageWidth;
        this.stageHeight = stageHeight;
        graphics.clear();
        graphics.beginFill (0xDDDDDD, 1);
        graphics.drawRect (0, 40, stageWidth, stageHeight-100);
        graphics.endFill();

        stepButton = new StepButton();
        stepButton.x = stageWidth - 100;
        stepButton.y = stageHeight / 2 - (stepButton.height / 2);
        addChild (stepButton);

        playerPriceWidget = new PriceWidget();
        playerPriceWidget.x = this.width - playerPriceWidget.width;
        playerPriceWidget.y = stageHeight - 90;
        addChild (playerPriceWidget);
		
		overloadWidget = new OverloadWidget ();
		overloadWidget.x = playerPriceWidget.x;
		overloadWidget.y = playerPriceWidget.y + playerPriceWidget.height;
		addChild(overloadWidget);
		
        opponentPriceWidget = new PriceWidget();
        opponentPriceWidget.x = this.width - opponentPriceWidget.width;
        opponentPriceWidget.y = 40;
        addChild (opponentPriceWidget);

        opponentRow = new UnitRow();
        opponentRow.y = 140;
        opponentRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH)) / 2;
        addChild(opponentRow);

        playerRow = new UnitRow ();
        playerRow.y = 260;
        playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH)) / 2;
        addChild(playerRow);
		
		clientCardsWidget = new DeckWidget();
		clientCardsWidget.x = (this.width - clientCardsWidget.width);
		clientCardsWidget.y = stepButton.y + 80;
		addChild(clientCardsWidget)
		
		opponentCardsWidget = new DeckWidget();
		opponentCardsWidget.x = clientCardsWidget.x;
		opponentCardsWidget.y = stepButton.y - 60;
		addChild(opponentCardsWidget)
		
    }
	
	public function clear () :void {
		while (this.numChildren) this.removeChildAt(0);
		removeAllTokens();
		clientCardsWidget.clear();
		opponentCardsWidget.clear();
		playerPriceWidget.clear();
		opponentPriceWidget.clear();
		resize(this.stageWidth, this.stageHeight);
	}
	
	public function calculateCards(clientCount:int, opponentCount:int) :void {
		clientCardsWidget.setCount(clientCount);
		opponentCardsWidget.setCount(opponentCount);
	}

    public function setBackground (background:IBackground) :void {

    }

    public function addPlayerHero (hero:IHero) :void {
        this.playerHero = hero;
        addChild(playerHero as DisplayObject);
    }

    public function addOpponentHero (hero:IHero) :void {
        this.opponentHero = hero;
        addChild(opponentHero as DisplayObject);
    }
	
	public function getPlayerHero () :IHero {
		return playerHero;
	}
	public function getOpponentHero() :IHero {
		return opponentHero;
	}

    public function enableStepButton () :void {
        stepButton.enable();
    }

    public function disableStepButton () :void {
        stepButton.disable();
    }

    public function setPlayerPrice (value:int,  endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false, overload:int = 0) :void {
        playerPriceWidget.setPrice(value, overload);
		if (sygnalFlag) {
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
		}
    }
	
	public function setOverload (price:int, overload:int) :void {
		overloadWidget.drawOwerload(price, overload);
	}
	
	public function clearOverload () :void {
		overloadWidget.clear();
	}
	
	public function clearPlayerPrice() :void {
		 playerPriceWidget.setPrice(0);
	}

    public function setOpponentPrice (value:int,  endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
        opponentPriceWidget.setPrice(value);
		if (sygnalFlag) {
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));			
		}
    }
	
	public function markAttackAvailable (list:Array, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
		for (var i:int = 0; i < list.length; i ++) {
			var token:IToken = playerRow.getChildAt (list[i]) as IToken;
			token.canAttack = true;
		}
		if (sygnalFlag) {
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));			
		}
	}
	public function glowTokens (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
		for (var i:int = 0; i < playerRow.numChildren; i ++) {
			var token:IToken = playerRow.getChildAt (i) as IToken;
			if (token.canAttack) {
				token.glow();
			}
		}
		if (sygnalFlag) {
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));			
		}
	}
	
	public function blockTokens (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
		for (var i:int = 0; i < playerRow.numChildren; i ++) {
			var token:IToken = playerRow.getChildAt (i) as IToken;
			token.canAttack = false;
			token.stopGlow();
			
		}
		if (sygnalFlag) {
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));			
		}
	}

    public function findPosition () :void {

        if (!playerRow.numChildren) {
            return;
        }

        playerRow.addChild (tokenPreview);
        playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH) * playerRow.numChildren) / 2;

        tokenPreview.x = (playerRow.numChildren - 1) * ( UnitRow.PADDING + Token.WIDTH);

        this.addEventListener (Event.ENTER_FRAME, onEnterFrame);

    }

    public function stopFindPosition () :void {

        if (!playerRow.numChildren) {
            playerRow.x = (this.width - (UnitRow.PADDING + Token.WIDTH) * playerRow.numChildren) / 2;
            return;
        }

        if (playerRow.contains(tokenPreview)) playerRow.removeChild (tokenPreview);

        centerizeRow (playerRow);
        sortUnitRow (playerRow);

        this.removeEventListener (Event.ENTER_FRAME, onEnterFrame);

    }

    public function getTokenPreviewIndex () :int {
        return tokenPreviewIndex;
    }

    private function get tokenPreview () :Sprite {
        return Token.getTokenPreviewInstance() as Sprite
    }



    private function onEnterFrame (event:Event) :void {
        var mouseLocalX:int = mouseX - playerRow.x;
        var index:int = findNearNumberIndex (getRowAvailablePositions(playerRow.numChildren), mouseLocalX);
        if (playerRow.contains(tokenPreview)) playerRow.removeChild (tokenPreview);
        playerRow.addChildAt (tokenPreview, index);
        tokenPreviewIndex = index;
        sortUnitRow (playerRow);
    }



    public function getRowAvailablePositions (index:int) :Array {
        var arr:Array = [];
        for (var i:int = 0; i < index; i ++) {
            arr.push (( UnitRow.PADDING + Token.WIDTH) * i);
        }
        return arr;
    }

    // функция возвращает индекс близжайшего числа к заданному
    // Вернет -1 если неверны входящие параметры или массив если пуст
    private function findNearNumberIndex( arr:Array, targetNumber:Number ):int
    {
        // проверяем входящие аргументы
        if( !arr || isNaN( targetNumber ) )
            return -1;

        // currDelta - текущая разница
        var currDelta:Number;

        // nearDelta - наименьшая разница
        var nearDelta:Number;

        // nearIndex - индекс наименьшей разницы. Задаем изначально равным -1.
        // если массив с нулевой длиной - возвратится эта самая -1
        var nearIndex:Number = -1;

        // счетчик
        var i:Number = arr.length;

        // начинаем крутить цикл с конца массива.
        // с конца - чтобы не заводить доп. переменную
        while( i-- )
        {
            // берем по модулю раницу между заданным числом и текущим по индексу массива
            currDelta = Math.abs( targetNumber - arr[i] );

            // если nearIndex меньше нуля
            // (т.е мы в первый раз должны занести currDelta, чтобы было с чем сравнивать последующие итерации)
            // или currDelta меньше nearDelta
            if( nearIndex < 0 || currDelta < nearDelta )
            {
                // задаем индекс (наименьшей разницы) как текущий индекс
                nearIndex = i;
                // задаем наименьшую разницу как текущую
                nearDelta = currDelta;
            }
        }

        // возвращаем индекс наименьшей разницы
        return nearIndex;
    }

    // сортировка стола
    public function sortUnitRow (unitRow:UnitRow, index:int = 0, animation:Boolean = true) :Point {

        var position:Point;

        var visibleTokens:Array = getVisibleTokens (unitRow);
        var availablePositions:Array = getRowAvailablePositions(visibleTokens.length);

        for (var i:int = 0; i < visibleTokens.length; i ++) {
            var unit:DisplayObject = visibleTokens[i];
            if (animation) {
                TweenLite.to (unit, 0.4, { x: availablePositions[i] } );
            } else {
                unit.x = availablePositions[i];
            }

            if (i == index) {
                position = new Point (availablePositions[i], unit.y);
            }
        }
        return position;
    }
    public function centerizeRow (unitRow:UnitRow, callback:Function = null) :Point {
        var visibleTokens:Array = getVisibleTokens (unitRow);
        var xPos:int = (this.width - ((UnitRow.PADDING * (visibleTokens.length - 1)) + (Token.WIDTH * visibleTokens.length))) / 2;
        TweenLite.to (unitRow, 0.4, { x: xPos , onComplete:callback } );

        return new Point (xPos, unitRow.y);
    }
	
	public function calculateX (attachment:Boolean, index:int) :int {
		var unitRow:UnitRow;
		if (attachment) {
			unitRow = playerRow; 
		} else {
			unitRow = opponentRow;
		}
		
		var result:int = (UnitRow.PADDING + Token.WIDTH) * index;
		result += (this.width - ((UnitRow.PADDING * (unitRow.numChildren - 1)) + (Token.WIDTH * unitRow.numChildren))) / 2;
		return result;
	}

    public function getVisibleTokens (row:UnitRow) :Array {
        var arr:Array = [];
        var token:Token;
        for (var i:int = 0; i < row.numChildren; i ++) {
            token = row.getChildAt(i) as Token;
            if (token.visible) {
                arr.push (token);
            }
        }
        return arr;
    }
	
	public function getUnitsNumChildren (playerFlag:Boolean = true) :int {
		if (playerFlag) {
			return playerRow.numChildren;
		} else {
			return opponentRow.numChildren;
		}
	}
	
	public function placeUnitRowPosition () :void {
		playerRow.y = stageHeight / 2 + 40;
		opponentRow.y = stageHeight / 2 - (40 + Token.HEIGHT);
	}
	
	public function playPlayerCardUnit (cardData:CardData, position:int, card:Card,
											endAnimationFlag:Boolean = false, sygnalFlag:Boolean = true
										) :void {
		
		
		configureSygnal (endAnimationFlag, sygnalFlag);
		
        var playingCard:Card = new Card (cardData);
        var token:Token = new Token (playingCard);

        var mirrow:Sprite = card.getMirror ();
		scene.placeCard (mirrow);

        actualToken = token;
        actualToken.alpha = 0;
        
        var tokenPosition:Point;

        if (playerRow.numChildren) {
            playerRow.addChildAt (token, position);
            tokenPosition = sortUnitRow (playerRow, position);
		} else {
            playerRow.addChild(token);
            tokenPosition = new Point (0, 0);
        }
		
        var rowPosition:Point = centerizeRow (playerRow);

        var mirrowPosition:Point = new Point (tokenPosition.x + rowPosition.x, tokenPosition.y + rowPosition.y);
        var endY:int = mirrowPosition.y;

        mirrowPosition.x -= (Card.MIRROR_WIDTH - Token.WIDTH) / 2;
        mirrowPosition.y -= (Card.MIRROR_HEIGHT - Token.HEIGHT) / 2;

        var timeline:TimelineLite = new TimelineLite ({onComplete:onPlaceComplete});
        timeline.to (mirrow, 0.5, { x:mirrowPosition.x, y:mirrowPosition.y, ease:Expo.easeOut, onComplete:onPlaceContinue } );
        timeline.to (mirrow, 0.5, { y:endY, alpha:0, ease:Expo.easeOut}); 
	}
	
	 private function onPlaceContinue () :void {
        actualToken.alpha = 1.0;
    }

    private function onPlaceComplete () :void {
		scene.endPlaceCard();
		
		if (sygnal) {
			sygnal = false;
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
		}
        
    }
	
	public function addToken (attachment:Boolean, cardData:CardData, position:int, endAnimationFlag:Boolean = true , sygnalFlag:Boolean = true) :void {
		
		configureSygnal (endAnimationFlag, sygnalFlag);	
		
		var playingCard:Card = new Card (cardData);
        actualToken = new Token (playingCard, !attachment);
		actualToken.alpha = 0;
		
		if (attachment) {
            playerRow.addChildAt (actualToken, position);
			sortUnitRow (playerRow, position);
			centerizeRow(playerRow, addTokenComplete);
		} else {
			opponentRow.addChildAt (actualToken, position);
			sortUnitRow (opponentRow, position);
			centerizeRow(opponentRow, addTokenComplete);
		}
	}
	
	public function getToken(attachment:Boolean, position:int) :IToken {
		if (attachment) {
			return (playerRow as DisplayObjectContainer).getChildAt(position) as IToken;
		} else {
			return (opponentRow as DisplayObjectContainer).getChildAt(position) as IToken;
		}
	}
	
	private function addTokenComplete () :void {
		for (var i:int = 0; i < playerRow.numChildren; i ++) {
			var _do:DisplayObject = playerRow.getChildAt(i);
			_do.alpha = 1;
		}
		for (i = 0; i < opponentRow.numChildren; i ++) {
				_do = opponentRow.getChildAt(i);
			_do.alpha = 1;
		}
		if (sygnal) {
			sygnal = false;
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
		}
	}
	
	public function getTokenIndex (token:DisplayObject, opponentFlag:Boolean = false) :int {
		if (opponentFlag) {
			return opponentRow.getChildIndex (token);
		} else {
			return playerRow.getChildIndex (token);
		}
	}

	
	public function playOpponentCardUnit (cardData:CardData, position:int, card:Card, mirrorPosition:Point,
											endAnimationFlag:Boolean = false, sygnalFlag:Boolean = true
										) :void {
			
		configureSygnal (endAnimationFlag, sygnalFlag);	
	
		var playingCard:Card = new Card (cardData);
        var token:Token = new Token (playingCard, true);

        var mirror:Sprite = card.getShirt ();
		scene.placeCard (mirror);
		
        
        mirror.x = mirrorPosition.x;
        mirror.y = mirrorPosition.y;

        mirror.scaleX = mirror.scaleY = 0.72;

        actualToken = token;
        actualToken.alpha = 0;

        var tokenPosition:Point;

		if (opponentRow.numChildren) {
            opponentRow.addChildAt (token, position);
            tokenPosition = sortUnitRow (opponentRow, position);
        } else {
            opponentRow.addChild(token);
            tokenPosition = new Point (0, 0);
        }
		
        var rowPosition:Point = centerizeRow (opponentRow);

        mirrorPosition = new Point (tokenPosition.x + rowPosition.x, tokenPosition.y + rowPosition.y);
   		mirrorPosition.y -= (Card.MIRROR_WIDTH - Token.HEIGHT);

		var endY:int = mirrorPosition.y;

        mirrorPosition.x -= (Card.MIRROR_WIDTH - Token.WIDTH) / 2;
        mirrorPosition.y -= (Card.MIRROR_HEIGHT - Token.HEIGHT) / 2;

        var timeline:TimelineLite = new TimelineLite ( { onComplete:onPlaceComplete } );
        timeline.to (mirror, 0.5, { x:mirrorPosition.x, y:mirrorPosition.y, scaleX:1.0, scaleY:1.0, ease:Expo.easeOut, onComplete:onPlaceContinue } );
        timeline.to (mirror, 0.5, { y:endY, alpha:0, ease:Expo.easeOut});
	}
	
	public 	function classicAttack (initiatorIndex:int, 
									targetIndex:int, 
									playerFlag:Boolean = true, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
										
		
		configureSygnal (endAnimationFlag, sygnalFlag);
										
		var attackUnit:DisplayObject = getAttackUnit (initiatorIndex, playerFlag);
		var targetUnit:DisplayObject = getTargetUnit (targetIndex, playerFlag);
		
		(attackUnit as IAttackAvailable).stopGlow ();
		
		var attack_pt:Point = new Point(attackUnit.x, attackUnit.y); 
		attack_pt = attackUnit.parent.localToGlobal(attack_pt);
			
		var target_pt:Point = new Point (targetUnit.x, targetUnit.y);
		target_pt = targetUnit.parent.localToGlobal (target_pt)
		
		if (playerFlag) {
			addChild (playerRow);
			target_pt.y += targetUnit.height/2 - 10;
		} else {
			addChild (opponentRow);
			target_pt.y -= targetUnit.height/2 - 10;
		}
		
		var deltaX:int = target_pt.x - attack_pt.x + ((targetUnit.width - attackUnit.width) / 2);
		var deltaY:int = target_pt.y - attack_pt.y;
			
		var start_pt:Point = (attackUnit as IAttackAvailable).getPosition ();
		var end_pt:Point = new Point (start_pt.x + deltaX, start_pt.y + deltaY);
		
		TweenLite.to (attackUnit, .2, { x:end_pt.x, y:end_pt.y , ease:Expo.easeInOut, onComplete:onAttack } );
	}
	
	private function onAttack () :void {
		
		if (sygnal) {
			sygnal = false;
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
			
		}
		
	}
	
	public function getAttackUnit (index:int, playerFlag:Boolean = true) :DisplayObject {
		var attackUnit:DisplayObject;
		if (index >= 0) {
			attackUnit = playerFlag ? playerRow.getChildAt (index) : opponentRow.getChildAt (index);
		} else {
			attackUnit = playerFlag ? playerHero as DisplayObject : opponentHero as DisplayObject;
		}
		return attackUnit;
	}
	
	public function getTargetUnit (index:int, playerFlag:Boolean = true) :DisplayObject {
		var targetUnit:DisplayObject;
		if (index >= 0) {
			targetUnit = playerFlag ? opponentRow.getChildAt(index) : playerRow.getChildAt(index);
		} else {
			targetUnit = playerFlag ? opponentHero as DisplayObject : playerHero as DisplayObject;
		}
		return targetUnit;
	}
	
	private function configureSygnal (endAnimationFlag:Boolean, sygnalFlag:Boolean) :void {
		sygnal = false;
		if (endAnimationFlag) {
			if (sygnalFlag) {
				sygnal = true;
			}
		} else {
			if (sygnalFlag) {
				sygnal = false;
				dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
			}
		}
	}
	
	public function backUnitToPosition (unit:DisplayObject, position:Point, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
		configureSygnal (endAnimationFlag, sygnalFlag);
		TweenLite.to (unit, .8, { x:position.x, y:position.y , ease:Expo.easeOut, onComplete:onBackComplete  } );
	}
	
	private function onBackComplete () :void {
		if (sygnal) {
			sygnal = false;
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
		}
	}
	public function remove(token:DisplayObject) :void {
		if (playerRow.contains(token)) {
			playerRow.removeChild(token);
		} 
		if (opponentRow.contains(token)) {
			opponentRow.removeChild(token);
		}
		if ((token as IToken).getMirror().parent) {
			(token as IToken).getMirror().parent.removeChild((token as IToken).getMirror());
		}
	}
	
	public function removeAllTokens() :void {
		while (playerRow.numChildren) {
			playerRow.removeChildAt(0);
		}
		while (opponentRow.numChildren) {
			opponentRow.removeChildAt(0);
		}
	}
	
	
	
	public function sortAndCenterize() :void {
		sortUnitRow (playerRow);
		centerizeRow (playerRow);
		sortUnitRow (opponentRow);
		centerizeRow (opponentRow);
	}
	
	public function removeToken (index:int, playerFlag:Boolean, endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
		configureSygnal (endAnimationFlag, sygnalFlag);
		if (playerFlag) {
			var token:IToken = playerRow.getChildAt(index) as IToken;
			if (token.getMirror().parent) {
				token.getMirror().parent.removeChild(token.getMirror());
			}
			playerRow.removeChildAt(index);
			sortUnitRow (playerRow);
			centerizeRow (playerRow, onEndRemove);
		} else {
			var token:IToken = opponentRow.getChildAt(index) as IToken;
			if (token.getMirror().parent) {
				token.getMirror().parent.removeChild(token.getMirror());
			}
			opponentRow.removeChildAt(index);
			sortUnitRow(opponentRow);
			centerizeRow(opponentRow, onEndRemove);
		}
	}
	
	public function changeToken (token:IToken, cardData:CardData) :IToken {
		var tokenDO:DisplayObject = token as DisplayObject;
		var position:Point = new Point (tokenDO.x, tokenDO.y)
		var index:int;
		var newUnitCard:Card = new Card (cardData);
		
		if (playerRow.contains(tokenDO)) {
			index = playerRow.getChildIndex(tokenDO);
			actualToken = new Token (newUnitCard);
			playerRow.removeChild (tokenDO);
			playerRow.addChildAt(actualToken, index);
			actualToken.x = position.x;
			actualToken.y = position.y;
		}
		
		if (opponentRow.contains(tokenDO)) {
			index = opponentRow.getChildIndex(tokenDO);
			actualToken = new Token (newUnitCard, true);
			opponentRow.removeChild (tokenDO);
			opponentRow.addChildAt(actualToken, index);
			actualToken.x = position.x;
			actualToken.y = position.y;
		}
		
		return actualToken;
	}
	
	private function onEndRemove () :void {
		if (sygnal) {
			sygnal = false;
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
		}
		
	}
	
	public function getPlayerToken (index:int) :IToken {
		return playerRow.getChildAt(index) as IToken;
	}
	
	public function getOpponentToken (index:int) :IToken {
		return opponentRow.getChildAt(index) as IToken;
	}
	
	public function blur () :void {
		this.filters = [new BlurFilter(7,7,2)]
	}
	public function stopBlur(): void {
		this.filters = []
	}
	
	public function placePreviewToOpponentRow(token:DisplayObject) :Point {
		var position:Point = new Point();
		Token.getTokenPreviewInstance().alpha = 0.01;
		actualToken = token as Token;
		if (playerRow.contains(token)) {
			
			actualRow = opponentRow;
			opponentRow.addChild(Token.getTokenPreviewInstance());
			sortUnitRow (opponentRow);
			position = centerizeRow(opponentRow, onPlaceRewiewComplete);
			position.x = position.x + this.x + ((UnitRow.PADDING + Token.WIDTH) * (opponentRow.numChildren - 1));
			position.y += this.y;
			
		} else {
			actualRow = playerRow;			
			playerRow.addChild (Token.getTokenPreviewInstance());
			sortUnitRow (playerRow);
			position = centerizeRow(playerRow, onPlaceRewiewComplete);
			position.x = position.x + this.x + ((UnitRow.PADDING + Token.WIDTH) * (playerRow.numChildren - 1));
			position.y += this.y;
		}
		return position;
	}
	
	private function onPlaceRewiewComplete () :void {
		actualRow.removeChild(Token.getTokenPreviewInstance());
		Token.getTokenPreviewInstance().alpha = 1;

	}
	
	public function sortAndCenter(row:UnitRow) :void {
		sortUnitRow(row);
		centerizeRow(row);
	}
	
	public function placeTokenToActualRow (token:DisplayObject) :void {
		actualRow.addChild(token);
		token.x = (UnitRow.PADDING + Token.WIDTH) * (actualToken.numChildren - 1);
		token.y = 0;
		sortUnitRow(actualRow, 0, false);
		centerizeRow(actualRow);
		if ((token as IToken).isEnemy) {
			(token as IToken).isEnemy = false;
		} else {
			(token as IToken).isEnemy = true;
		}
	}

}
}
