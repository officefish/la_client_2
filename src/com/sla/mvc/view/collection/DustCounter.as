package com.sla.mvc.view.collection 
{
	import feathers.controls.Label;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DustCounter extends Sprite 
	{
		
		private var titleLabel:Label;
		private var dustLabel:Label;
		
		public function DustCounter() 
		{
			var quad:Quad = new Quad(140, 70, 0xEEEEEE);
			addChild(quad);	
			
			titleLabel = new Label();
			titleLabel.styleNameList.add('dustTitleLabel');
			titleLabel.width = 140;
			titleLabel.height = 25;
			titleLabel.y = 10;
			titleLabel.text = 'Dust :';
			addChild(titleLabel);
			
			dustLabel = new Label();
			dustLabel.styleNameList.add('dustCountLabel');
			dustLabel.width = 140;
			dustLabel.height = 25;
			dustLabel.y = 40;
			addChild(dustLabel);
			
			
		}
		
		public function setDust (value:int) :void {
			dustLabel.text = value.toString();
		}
		
	}

}