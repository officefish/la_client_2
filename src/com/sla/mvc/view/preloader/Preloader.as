package com.sla.mvc.view.preloader 
{
	import feathers.controls.Label;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Preloader extends Sprite 
	{
		
		private var bg:Quad;
		private var msgQuad:Quad;
		private var label:Label;
		
		public function Preloader() 
		{
			msgQuad = new Quad(300, 150, 0xFFFFFF);	
			label = new Label();
			label.width = 300;
			label.height = 40;
			label.touchable = false;
			label.text = 'Loading. Wait a minute!';
			label.styleNameList.add('preloaderLabel');
		}
		
		public function resize (width:int, height:int) :void {
			removeChildren();
			bg = new Quad(width, height, 0x222222);
			bg.alpha = 0.8;
			addChild(bg);
			
			msgQuad.x = (width - msgQuad.width) / 2;
			msgQuad.y = (height - msgQuad.height) / 2;
			addChild(msgQuad);
			
			label.x = (width - label.width) / 2;
			label.y = (height - label.height) / 2;
			addChild(label);
		}
		
	}

}