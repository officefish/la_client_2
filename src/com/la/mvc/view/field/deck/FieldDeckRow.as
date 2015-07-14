package com.la.mvc.view.field.deck 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldDeckRow extends Sprite 
	{
		
		private var _itemsNumChildren:int;
		private var shift:int = 25;
		private var _position:int;
		
		public function FieldDeckRow() 
		{
						
		}
		
		public function set position (value:int) :void {
			_position = value;
		}
		
		public function get position () :int {
			return _position;
		}
		
		public function addItem (item:Sprite) :void {
			_itemsNumChildren ++;
			addChild(item);
			item.x = (_itemsNumChildren * shift);
		}
		
		public function get itemsNumChildren () :int {
			return _itemsNumChildren;
		}
		
		
		
		public function clear () :void {
			while (this.numChildren) this.removeChildAt(0);
			_itemsNumChildren = 0;
		}
		
	}

}