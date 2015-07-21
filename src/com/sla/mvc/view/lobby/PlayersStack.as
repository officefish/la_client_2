package com.sla.mvc.view.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
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
			list.dataProvider = collection;
		}
		
		public function addUser(user:Object) :void {
			list.dataProvider.unshift(user);
		}
		
		public function removeUser(userId:int) :void {
			var length:int = list.dataProvider.length;
			var index:int = - 1;
			var i:int = 0;
			var item:Object;
			for (i; i < length; i++) {
				item = list.dataProvider.getItemAt(i);
				if (item.id == userId) {
					index = i;
					break;
				}
			}
			if (i > -1) {
				list.dataProvider.removeItemAt(index);
			}
			
		}
		
		private function list_changeHandler( event:Event ):void
		{
			//var list:List = List( event.currentTarget );
			//MonsterDebugger.log( "selectedIndex:" + list.selectedIndex ); 
			//MonsterDebugger.log( "selectedItem:" + list.selectedItem); 
			//if (list.selectedIndex > -1) {
			//	var l:int = list.dataProvider.length;
			//	for (var i:int = 0; i < l; i ++) {
			//		var o:Object = list.dataProvider.getItemAt(i);
			//		MonsterDebugger.log(o.uid);
			//	}
				
				//MonsterDebugger.log(list.selectedItem == list.dataProvider.length);
				//list.dataProvider.removeItemAt(list.selectedIndex);
			//} else {
				
			//}
			
			//MonsterDebugger.log(list.selectedItem.index);
			//MonsterDebugger.log(list.selectedItem.player);
			
			/*
			var item:Object = {}
				item.nickname = "Item " + Math.round(Math.random()*30 + 50);
				item.vocation = 0;
				item.level = 1;
				item.player = false;//Boolean(Math.round(Math.random()));
			var b:Boolean = Boolean(Math.round(Math.random() / 1.2));
			if (b) {
				list.dataProvider.unshift(item);
			}
			*/
		}
		
	}

}