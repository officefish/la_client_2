package com.sla.mvc.view.animation 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class TargetAnimation extends Animation 
	{
		
		protected var targetPosition:Point;
		
		public function TargetAnimation(targetPosition:Point, onComplete:Function) 
		{
			this.targetPosition = targetPosition;
			super(onComplete);
		}
		
	}

}