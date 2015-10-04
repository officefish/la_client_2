package com.sla.mvc.view.animation 
{
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Animation 
	{
		
		protected static var _scene:DisplayObjectContainer;
		protected var _onComplete:Function;
		public var scene:DisplayObjectContainer;
				
		public function Animation() 
		{
			
		}
		
		public function start () :void {
			
		}
		
		public function set onComplete (value:Function) :void {
			this._onComplete = value;
		}
		
		public function get onComplete () :Function {
			return _onComplete;
		}
		
		public static function set scene (value:DisplayObjectContainer) :void {
			_scene = value;
		}
		
		public static function get scene () :DisplayObjectContainer {
			return _scene;
		}
		
	}

}