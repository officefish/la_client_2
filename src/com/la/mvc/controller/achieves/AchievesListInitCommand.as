package com.la.mvc.controller.achieves 
{
	import com.la.event.ApiServiceEvent;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchievesListInitCommand extends Command 
	{
		[Inject (name = 'achieves')]
		public var achieves:AchieveBrowser; 
		
		[Inject]
		public var event:ApiServiceEvent;
		
		override public function execute():void 
		{
			achieves.initHero(event.getData()['heroVocation']);
			achieves.initAchieves(event.getData()['achieves']);
		}		
	}

}