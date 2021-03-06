package com.sla.mvc.controller.ability.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.model.HeroModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import com.sla.mvc.view.ability.AbilityCraftCard;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCraftAbilityCommand extends StarlingCommand 
	{
		[Inject]
		public var service:ApiService; 
		
		[Inject]
		public var model:HeroModel; 
		
		[Inject]
		public var rootModel:RootModel;  
				
		[Inject]
		public var collectionModel:CollectionModel;
		
		override public function execute():void 
		{
			var ability:AbilityCraftCard = collectionModel.drawingAbility;
			var abilityId:int = ability.getData().id;
			MonsterDebugger.log ('abilityId: ' + abilityId);
			service.craftAbility (rootModel.userId, model.heroId, abilityId);
		}
		
	}

}