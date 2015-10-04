package com.la.mvc.controller.match.select 
{
	import com.la.event.SceneEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.Hero;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.IHero;
	import com.la.mvc.view.field.IToken;
	import com.la.mvc.view.scene.IScene;
	import com.la.mvc.view.token.Token;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectUnitsForEptitudeCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='field')]
		public var field:IField;
				
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name = 'matchModel')]
		public var matchModel:MatchModel; 
				
		private var listeners:Array;
		private var serviceData:Dictionary;
		
		
		
		override public function execute():void 
		{
			var associate:Array = event.data.mask.associate;
			var opponent:Array = event.data.mask.opponent;
			var playerHeroFlag:Boolean = event.data.mask.player_hero;
			var opponentHeroFlag:Boolean = event.data.mask.opponent_hero;
			
			scene.darken();
			field.blur();
			
			var index:int;
			var token:IToken; 
			var tokenCopy:IToken;
			var position:Point;
			var hero:IHero;
			var heroCopy:IHero;
			var tokenDO:DisplayObject;
			var tokenCopyDO:DisplayObject;
			var heroDO:DisplayObject;
			var heroCopyDO:DisplayObject;
			
			listeners = [];
			
			serviceData = new Dictionary ();
			
			for (var i:int = 0; i < associate.length; i++) {
				index = associate[i];
				token = field.getPlayerToken (index);
				tokenCopy = token.clone();
				tokenDO = token as DisplayObject;
				(tokenCopy as Sprite).buttonMode = true;
				position = new Point(tokenDO.x, tokenDO.y);
				position = tokenDO.parent.localToGlobal (position);
				tokenCopyDO = tokenCopy as DisplayObject;
				tokenCopyDO.x = position.x;
				tokenCopyDO.y = position.y;
				scene.placeCopy (tokenCopyDO);
				listeners.push (tokenCopy);
				serviceData[tokenCopy] = {'index':index, 'player':true}
			}
			for (i = 0; i < opponent.length; i++) {
				index = opponent[i];
				token = field.getOpponentToken (index);
				tokenCopy = token.clone();
				tokenDO = token as DisplayObject;
				(tokenCopy as Sprite).buttonMode = true;
				position = new Point(tokenDO.x, tokenDO.y);
				position = tokenDO.parent.localToGlobal (position);
				tokenCopyDO = tokenCopy as DisplayObject;
				tokenCopyDO.x = position.x;
				tokenCopyDO.y = position.y;
				scene.placeCopy (tokenCopyDO);
				listeners.push (tokenCopy);
				serviceData[tokenCopy] = {'index':index, 'player':false}

			}
			if (playerHeroFlag) {
				hero = field.getPlayerHero();
				heroDO = hero as DisplayObject;
				position = new Point(heroDO.x, heroDO.y);
				position = heroDO.parent.localToGlobal (position);
				heroCopy = hero.clone();
				heroCopyDO = heroCopy as DisplayObject;
				(heroCopyDO as Sprite).buttonMode = true;
				heroCopyDO.x = position.x;
				heroCopyDO.y = position.y;
				scene.placeCopy(heroCopyDO);
				listeners.push (heroCopy);
				serviceData[heroCopy] = {'index':-1, 'player':true}
			}
			
			if (opponentHeroFlag) {
				hero = field.getOpponentHero();
				heroDO = hero as DisplayObject;
				position = new Point(heroDO.x, heroDO.y);
				position = heroDO.parent.localToGlobal (position);
				heroCopy = hero.clone();
				heroCopyDO = heroCopy as DisplayObject;
				(heroCopyDO as Sprite).buttonMode = true;
				heroCopyDO.x = position.x;
				heroCopyDO.y = position.y;
				scene.placeCopy(heroCopyDO);
				listeners.push (heroCopy);
				serviceData[heroCopy] = {'index':-1, 'player':false}

			}
			
			contextView.stage.addEventListener (MouseEvent.CLICK, onStageClick);
			matchModel.selectListener = onStageClick;
		}		
		
		public function onStageClick (event:MouseEvent) :void {
			
			contextView.stage.removeEventListener (MouseEvent.CLICK, onStageClick);
			var target:DisplayObject = event.target as DisplayObject;
			var data:Object = serviceData[target];
			
			scene.endCopy();
			scene.lighten(false);
			field.stopBlur();
			
			if (data) {
				dispatch (new SceneEvent(SceneEvent.SELECT_FOR_EPTITUDE_INIT, { serviceData:data } ));
			} else {
				 dispatch (new SceneEvent(SceneEvent.CANCEL_SELECT_FOR_EPTITUDE_UNIT, {}));
			}
		}
	}

}