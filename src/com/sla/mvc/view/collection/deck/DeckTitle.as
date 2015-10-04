package com.sla.mvc.view.collection.deck 
{
	import feathers.controls.Label;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckTitle extends Sprite 
	{
		
		private var _label:Label;
		
		public function DeckTitle(label:String = 'Мои колоды') 
		{
			var quad:Quad = new Quad(180, 50, 0x222222);
			addChild(quad);
			
			_label = new Label();
			_label.width = 180;
			_label.styleNameList.add('decklistTitleLabel');
			_label.y = 15;
			_label.validate();
			_label.text = label;
			addChild(_label)
		}
		
		protected function get label () :Label {
			return _label;
		}
		
	}

}