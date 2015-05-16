package com.la.mvc.controller.match.select 
{
	import com.la.event.SceneEvent;
	import com.la.mvc.service.MatchService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ResponseEffectSelectedCommand extends Command 
	{
		[Inject]
		public var service:MatchService; 
		
		[Inject]
		public var event:SceneEvent;
		
		override public function execute():void 
		{
			service.sendMessage ('effect_selected', {index:event.data.index});	
		}
		
	}

}