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
			addChild(header);
			
			initList();
			
		}
		
		protected function initList () :void {
			
		}
		
	}

}