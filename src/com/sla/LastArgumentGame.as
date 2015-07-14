package com.sla 
{
	import com.sla.mvc.LastArgumentContext;
	import starling.display.Sprite;
	import org.robotlegs.mvcs.StarlingContext;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LastArgumentGame extends Sprite 
	{
		
		private var context:StarlingContext;
		
		public function LastArgumentGame() 
		{
			super();
			
			// configure context
			context = new LastArgumentContext(this);
			
		}
		
	}

}