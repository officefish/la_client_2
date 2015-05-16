package com.la.mvc.controller.collection 
{
	import com.la.event.ApiServiceEvent;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import com.la.mvc.view.collection.ICollection;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroesInitCommand extends Command 
	{
		
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject (name='collection')]
		public var collection:ICollection; 
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel;
		
		[Inject (name='rootModel')]
		public var rootModel:RootModel; 
		
		[Inject (namespace = 'achieves')]
		public var achieves:AchieveBrowser; 
				
		override public function execute():void 
		{
			if (rootModel.currentState == GameState.HEROES) {
				achieves.initHeroes(event.getData().heroes)
			} else {
				collection.initHeroes (event.getData().heroes);
			}
			
		}
		
	}

}