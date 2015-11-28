package com.sla.mvc.view.field 
{
	import feathers.controls.Label;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EndMatchPopup extends Sprite 
	{
		
		private var container:Sprite;
		private var label:Label;
		
		public function EndMatchPopup() 
		{
			this.useHandCursor = true;
			
			container = new Sprite();
			container.x -= 150;
			container.y -= 100;
			addChild(container);
			
			var quad:Quad = new Quad(300, 200, 0x222222);
			container.addChild(quad);
			
			label = new Label();
			label.width = 300;
			label.y = 80;
			label.styleNameList.add('craftCollectionMirrorCardTitleLabel');
			container.addChild(label);
			
		}
		
		public function set winMode (value:Boolean) :void {
			if (value) {
				label.text = 'Congratulations! You win!'
			} else {
				label.text = 'Sorry. You lost!'
			}
		}
		
	}

}