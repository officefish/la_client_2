package com.sla.mvc.view.lobby 
{
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Stack extends Sprite 
	{
		protected var list:List;
		
		public function Stack(title:String, width:int, height:int) 
		{
			super();
			var quad:Quad = new Quad(width, height);
			quad.color = 0;
			quad.alpha = 0.6;
			addChild(quad);
			
			var header:Header = new Header();
			header.width = width - 4;
			header.x = 2;
			header.y = 2;
			header.styleNameList.add('lobbyHeader');
			header.title = title;
			header.validate();
			addChild(header);
			
			initList();
			
		}
		
		protected function initList () :void {
			
		}
		
		public function addUser(user:Object) :void {
			list.selectedIndex = -1;
			list.dataProvider.unshift(user);
		}
		
		public function removeUser(userId:int) :void {
			list.selectedIndex = -1;
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
		
		public function clear () :void {
			list.selectedIndex = -1;
			list.dataProvider.removeAll();
		}
		
		
		
	}

}