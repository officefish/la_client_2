package com.sla.mvc.controller.ability 
{
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupAbilityCommand extends StarlingCommand 
	{
		[Inject]
		public var browser:AbilityBrowser;
		
		override public function execute():void 
		{
			browser.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(browser);
			
			dispatch(new AbilityEvent(AbilityEvent.CHOOSE_HERO_FOR_CRAFT));

		}
		
	}

}