package com.sla.mvc.view.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.starling.StarlingLobbyEvent;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import starling.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InvitesStack extends Stack 
	{
		
		private var rendererStyleName:String;
		private var eventType:String;
		
		public function InvitesStack(title:String, width:int, height:int, rendererStyleName:String, eventType:String) 
		{
			this.eventType = eventType;
			this.rendererStyleName = rendererStyleName;
			super(title, width, height);
		}
		
		override protected function initList():void 
		{
			list = new List(); 
			list.isSelectable = true;
			list.styleNameList.add(rendererStyleName);
			list.width = width - 4;
			list.x = 2;
			list.height = height - 42;
			list.y = 37;
			addChild(list); 
			
			var collection:ListCollection = new ListCollection();
			list.dataProvider = collection; 
			
			list.addEventListener( Event.CHANGE, list_changeHandler );  
		}
		
		private function list_changeHandler( event:Event ):void
		{
			var list:List = List( event.currentTarget );
			if (list.selectedIndex > -1) {
				var id:int = list.selectedItem.id;
				var mode:int = list.selectedItem.mode;
				dispatchEvent(new StarlingLobbyEvent(eventType, false, { id:id, mode:mode } ));
			}
		}
		
	}

}