package com.sla.mvc.view.field.minion 
{
	import com.greensock.TimelineLite;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MinionWidget extends Sprite 
	{
		
		public static const NO_WIDGET:int = 0;
		public static const DIE_WIDGET:int = 1;
		public static const WOUND_WIDGET:int = 2;
		public static const SPELL_WIDGET:int = 3;
		public static const ATTACK_WIDGET:int = 4;
		
		private var color:int;
		
		public static const ACTIVATE_COMPLETE:String = 'activateComplete';
		
		public function MinionWidget(type:int) 
		{
			this.touchable = false;
			color = getColor(type);
			var quad:Quad = new Quad(8, 8, color);
			quad.x -= 4;
			quad.y -= 4;
			addChild(quad);
		}
		
		public function activate () :void {
			//create the timeline and add an onComplete callback that will call myFunction() when the timeline completes
			var myTimeline:TimelineLite = new TimelineLite({onComplete:activateComplete}); 

			//add a tween
			myTimeline.to(this, 0.1, { alpha:0 } );
			myTimeline.to(this, 0.1, { alpha:1 } );
			myTimeline.to(this, 0.1, { alpha:0 } );
			myTimeline.to(this, 0.1, { alpha:1 } );
			myTimeline.to(this, 0.1, { alpha:0 } );
			myTimeline.to(this, 0.1, { alpha:1 } );
			myTimeline.to(this, 0.1, { alpha:0 } );
			myTimeline.to(this, 0.1, { alpha:1 } );
			myTimeline.to(this, 0.1, { alpha:0 } );
			myTimeline.to(this, 0.1, { alpha:1 } );
		} 
		
		private function activateComplete () :void {
			dispatchEvent (new Event(ACTIVATE_COMPLETE)); 
		}
		
		private function getColor (type:int) :uint {
			var _color:uint;
			switch(type) {
				case 0: 
					{
						_color = 0xFFFFFF;
						break;
					}
				case 1: 
					{
						_color = 0x222222;
						break;
					}
				case 2: 
					{
						_color = 0x9F000F;
						break;
					}
				case 3: 
					{
						_color = 0x4EE2EC;
						break;
					}
				case 4: 
					{
						_color = 0x461B7E;
						break;
					}
			}
			return _color;
		}
		
	}

}