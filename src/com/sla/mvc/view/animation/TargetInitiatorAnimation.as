package com.sla.mvc.view.animation 
{
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class TargetInitiatorAnimation extends Animation implements ITargetInitiatorAnimation
	{
		protected var initiatorPosition:Point;
		protected var targetPosition:Point;
		
						
		public function configure (container:DisplayObjectContainer, initiatorPosition:Point, targetPosition:Point, onComplete:Function) :void {
			this.scene = container;
			this.targetPosition = targetPosition;
			this.initiatorPosition = initiatorPosition;
			this.onComplete = onComplete;
		}
		
		public function init () :void {
			
		}
		
	}

}