package com.la.mvc.controller.intro 
{
	import com.la.event.HeroesEvent;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectHeroesCommand extends Command 
	{
		[Inject (name='rootModel')]
		public var rootModel:RootModel; 
		
		[Inject (name = 'achieves')]
		public var achieves:AchieveBrowser;
		
		override public function execute():void 
		{

			rootModel.currentState = GameState.HEROES; 
			achieves.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			achieves.clear();
			contextView.addChild(achieves);
			
			dispatch(new HeroesEvent(HeroesEvent.CHOOSE_HERO_FOR_CRAFT));
			
		}		
	}

}