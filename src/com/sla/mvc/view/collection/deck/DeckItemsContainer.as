package com.sla.mvc.view.collection.deck 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.starling.StarlingDeckListEvent;
	import com.sla.event.starling.StarlingLobbyEvent;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import starling.events.Event;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckItemsContainer extends Sprite 
	{
		
		private var list:List;
		private var _slotsCount:int;
		
		public function get slotsCount ():int {
			return _slotsCount;
		}
		
		public function set slotsCount (value:int) :void {
			_slotsCount = value;
		}
		
		public function DeckItemsContainer() 
		{
			super();
			
			var quad:Quad = new Quad(180,500,0x4444444);
			addChild(quad);
			list = new List(); 
			list.isSelectable = true;
			list.styleNameList.add('deckListItems');
			list.y = 3;
			list.width = 180;
			list.height = 492;
			addChild(list);
			
			list.addEventListener( Event.CHANGE, list_changeHandler ); 
			
		}
		
		private function list_changeHandler( event:Event ):void
		{
			var list:List = List( event.currentTarget );
			if (list.selectedIndex > -1) {
				var id:int = list.selectedItem.id;
				dispatchEvent(new StarlingDeckListEvent(StarlingDeckListEvent.REMOVE_SLOT, false, { slotId:id } ));
			}
		}
		
		public function initDataProvider(data:Array) :void {
			var collection:ListCollection = new ListCollection(data);
			list.selectedIndex = -1; 
			list.dataProvider = collection;
		}
		
		public function addSlot (data:Object) :void {
			var length:int = list.dataProvider.length;
			var index:int = - 1;
			var item:Object;
			for (var i:int = 0; i < length; i ++) {
				item = list.dataProvider.getItemAt(i);
				if (item.id == data.id) {
					index = i;
					break;
				}
			}
			if (index > - 1) {
				item = list.dataProvider.getItemAt(index);
				item.count ++;
				list.dataProvider.updateItemAt(index);
			} else {
				data.count = 1;
				list.selectedIndex = -1;
				list.dataProvider.unshift(data);
				sortList();
			}
			
		}
		
		private function sortList () :void {
			var slots:Array = [];
			var i:int;
			var item:Object;
			var length:int = list.dataProvider.length;
			for (i = 0; i < length; i ++) {
				item = list.dataProvider.getItemAt(i);
				slots.push(item);
			}
			slots.sort (sortByPrice);
			var collection:ListCollection = new ListCollection(slots);
			list.selectedIndex = -1; 
			list.dataProvider = collection;
		}
		
		private function sortByPrice (a:Object, b:Object) :int {
		   var x1:int = a.price;
		   var x2:int = b.price;
		   if (x1 < x2)
		   {
				return -1;
		   }
		   else if (x1 > x2)
		   {
				return 1;
		   }
		   else
		   {
				return 0;
		   }
		}
		
	}

}