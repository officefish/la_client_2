package com.sla.mvc.controller.decklist 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.DeckListEvent;
	import com.sla.mvc.view.alert.AlertView;
	import com.sla.mvc.view.decklist.DeckList;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.filters.BlurFilter;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AlertEditDeckCommand extends StarlingCommand 
	{
		[Inject]
		public var event:DeckListEvent;
		
		[Inject]
		public var alert:AlertView;
		
		[Inject]
		public var deckList:DeckList;
		
		override public function execute():void 
		{
			MonsterDebugger.log("AlertEditDeckCommand::execute()")
			super.execute();
			contextView.addChild(alert);
			alert.alertConfirm();
			
			var blur:BlurFilter = new BlurFilter();
			//blur.adjustBrightness(-0.25); 
			deckList.filter = blur;
		}		
	}

}