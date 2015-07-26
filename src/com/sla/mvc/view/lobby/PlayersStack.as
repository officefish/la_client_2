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
	public class PlayersStack extends Stack 
	{
		
		
		public function PlayersStack(title:String, width:int, height:int) 
		{
			super(title, width, height);
		}
		
		override protected function initList():void 
		{
			list = new List(); 
			list.isSelectable = true;
			list.styleNameList.add('lobbyPlayersList');
			list.width = width - 4;
			list.x = 2;
			list.height = height - 42;
			list.y = 37;
			
			addChild(list);
			
			list.addEventListener( Event.CHANGE, list_changeHandler ); 
		}
		
		public function initDataProvider(data:Array) :void {
			var collection:ListCollection = new ListCollection(data);
			list.selectedIndex = -1;
			list.dataProvider = collection;
		}
		
	
		
		public function blockUser(id:int) :void {
			//MonsterDebugger.log('blockUser');
			var length:int = list.dataProvider.length;
			var index:int = - 1;
			var item:Object;
			for (var i:int = 0; i < length; i ++) {
				item = list.dataProvider.getItemAt(i);
				if (item.id == id) {
					index = i;
					break;
				}
			}
			//MonsterDebugger.log('index: ' + index);
			if (index > - 1) {
				item = list.dataProvider.getItemAt(index);
				item.player = true;
				list.dataProvider.updateItemAt(index);
			}
			
		}
		
		private function list_changeHandler( event:Event ):void
		{
			var list:List = List( event.currentTarget );
			if (list.selectedIndex > -1) {
				var id:int = list.selectedItem.id;
				dispatchEvent(new StarlingLobbyEvent(StarlingLobbyEvent.INVITE, false, { id:id} ));
			}
		}
		
	}

}