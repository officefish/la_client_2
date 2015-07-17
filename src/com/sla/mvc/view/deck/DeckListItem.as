package com.sla.mvc.view.deck 
{
	import starling.display.Quad;
	import com.sla.mvc.model.data.DeckData;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckListItem extends Sprite 
	{
		
		public function DeckListItem(data:DeckData) 
		{
			var quad:Quad = new Quad(120, 120);
			quad.color = 0x00FF00;
			addChild(quad);
		}
		
	}

}