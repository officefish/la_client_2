package com.sla.mvc.view.lobby 
{
	import com.sla.event.starling.ModePopupEvent;
	import feathers.controls.Button;
	import feathers.controls.Icon;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.TextArea;
	import feathers.layout.VerticalLayout;
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ModeBlock extends Sprite
	{
		
		private var bg:Icon;
		private var layoutGroup:LayoutGroup;
		private var index:int;
		
		public function ModeBlock(index:int, blockTitle:String, blockDescription:String) 
		{
			this.index = index;
			
			layoutGroup = new LayoutGroup();
			layoutGroup.styleNameList.add('modeBlock');
			addChild(layoutGroup);
			
			var title:Label = new Label();
			title.styleNameList.add('lobbyModePopupLabel');
			title.text = blockTitle;
			
			var description:TextField = new TextField(180, 180, blockDescription);
			
			var button:Button = new Button();
			button.label = blockTitle.toUpperCase();
			button.useHandCursor = true;
			button.styleNameList.add('mainButton');
			button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			
			layoutGroup.addChild(title);
			layoutGroup.addChild(description);
			
			button.x = 10;
			button.y = 200;
			addChild(button);
			
			
			
			//this.layoutData			
		}
		
		private function button_triggeredHandler (event:Event) :void {
			dispatchEvent (new ModePopupEvent(ModePopupEvent.SELECT, false, {index:index}));
		}
		
	}

}