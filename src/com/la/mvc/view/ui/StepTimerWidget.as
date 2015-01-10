package com.la.mvc.view.ui 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StepTimerWidget extends Sprite 
	{
		
		private var stageWidth:int;
		private var stageHeight:int;
		private var timer:Timer;
		
		private var totalTime:int;
		private var currentTime:int;
		
		private var timerWidth:int;
		
		public function StepTimerWidget() 
		{
						
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			timerWidth = stageWidth - 100;
		}
		
		public function initTimer (time:int) :void {
			if (timer) {
				timer.removeEventListener (TimerEvent.TIMER, onTimer);
				timer.removeEventListener (TimerEvent.TIMER_COMPLETE, onCompleteTimer);
			}
			totalTime = time * 100;
			currentTime = 0;
			timer = new Timer (10, totalTime);
			timer.addEventListener (TimerEvent.TIMER, onTimer);
			timer.addEventListener (TimerEvent.TIMER_COMPLETE, onCompleteTimer);
		}
		
		public function run () :void {
			timer.start ();
		}
		
		public function stop () :void {
			if (timer) timer.stop();
		}
		
		public function destroy() :void {
			if (timer) {
				timer.removeEventListener (TimerEvent.TIMER, onTimer);
				timer.removeEventListener (TimerEvent.TIMER_COMPLETE, onCompleteTimer);
			}
			timer = null;
		}
		
		private function onTimer (event:TimerEvent) :void {
			currentTime ++;
			var timerLength:Number = currentTime / totalTime;
			var index:int = timerLength * timerWidth;
			graphics.clear();
			graphics.lineStyle(1, 0x770000, 1);
			graphics.moveTo (0, 0);
			graphics.lineTo (index, 0);
			graphics.lineStyle (1, 0xEEEEEE, 1);
			graphics.moveTo (index, 0);
			graphics.lineTo (timerWidth, 0);
		}
		
		private function onCompleteTimer (event:TimerEvent) :void {
			
		}
		
	}

}