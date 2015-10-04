package com.sla.mvc.view.card 
{
	import com.sla.event.starling.StarlingCardEvent;
	import com.sla.mvc.model.data.CardData;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreflopCard extends Card 
	{
		private var _select:Boolean;
		private var _index:uint;
		private var _blockFlag:Boolean = false;
		
		public function PreflopCard(cardData:CardData, index:uint) 
		{
			super (cardData);
			removeChildren();
			addChild(getMirror());
			this._index = index;
			this.useHandCursor = true;
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function get index () :uint {
			return _index;
		}
		
		override public function glow () :void {
			super.glow();
			_select = true;
			glowMirror();
		}

		override public function stopGlow () :void {
			super.stopGlow();
			_select = false;
			stopGlowMirror();
		}
		
		public function get select () :Boolean {
			return _select;
		}
		
		private function onTouch (event:TouchEvent) :void {
			if (event.getTouch(this, TouchPhase.BEGAN))
			{
				if (isBlocked) {
					return;
				}
				
				select ? stopGlow() : glow();
				dispatchEvent(new StarlingCardEvent (StarlingCardEvent.PREFLOP_CLICK, false, {'index':index, 'select':select} ))			
			}
		}
		
		public function get isBlocked () :Boolean {
			return block;
		}
		
		override public function get block():Boolean 
		{
			return super.block;
		}
		
		override public function set block(value:Boolean):void 
		{
			super.block = value;
			if (value) {
				this.useHandCursor = false;
			} else {
				this.useHandCursor = true;
			}
		}
		
		
		
	}

}