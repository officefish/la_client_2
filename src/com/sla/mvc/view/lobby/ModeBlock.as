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
			
			var title2:Label = new Label();
			title2.text = 'title';
			
			var description:TextField = new TextField(180, 180, blockDescription);
			//description.border = true;
			
			var button:Button = new Button();
			button.label = blockTitle.toUpperCase();
			button.styleNameList.add('smallButton');
			button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			
			layoutGroup.addChild(title);
			//layoutGroup.addChild(title2);
			layoutGroup.addChild(description);
			
			button.x = 40;
			button.y = 230;
			addChild(button);
			
			
			
			//this.layoutData			
		}
		
		private function button_triggeredHandler (event:Event) :void {
			dispatchEvent (new ModePopupEvent(ModePopupEvent.SELECT, false, {index:index}));
		}
		
	}

}