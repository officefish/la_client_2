package com.la.mvc.controller.match.attack 
{
	import com.la.event.ActionEvent;
	import com.la.mvc.service.MatchService;
	import com.la.mvc.view.debug.Console;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ResponseClassicAttackCommand extends Command 
	{
		
		[Inject]
		public var event:ActionEvent;
		
		[Inject]
		public var service:MatchService;
	
		[Inject (name='appConsole')]
		public var console:Console;

		override public function execute():void {
			console.debug ('classic_attack')
			service.sendMessage('classic_attack', event.data);
		}
			
	
		
	}

}