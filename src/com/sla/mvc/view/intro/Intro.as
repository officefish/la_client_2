package com.sla.mvc.view.intro 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Intro extends Sprite implements IIntro
	{
		
		private var stageWidth:int;
		private var stageHeight:int;
		private var initFlag:Boolean = false;
		
		private var q:Quad; 
		
		public function Intro() 
		{
			super();
			addEventListener (Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function get asStarlingSprite () :Sprite {
			return this as Sprite;
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
		}
		
		private function onAddedToStage (event:Event) :void {
			if (!initFlag) {
				init ();
			}
			q.x = stageWidth - q.width >> 1;
			q.y = stageHeight - q.height >> 1;
		}
		
		private function init () :void {
			q = new Quad(200, 200);
			q.color = Math.round(Math.random() * 0xFFFFFF);
			addChild ( q );
			initFlag = true;
		}
		
		
	}

}