package com.la.mvc.view.achieves 
{
	import com.la.assets.Assets;
	import com.transform.Transform;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchievesBar extends Sprite 
	{
		
		private var asset:Bitmap;
		private var slots:Vector.<EmptyAchieveSlot>
		private var labelsInit:Boolean = false;
		
		private var controlLabel:TextField;
		private var regulalLabel:TextField;
		private var sprintLabel:TextField;
		
		private var positions:Array = 
		[
			new Point(480, 20),
			new Point(260, 20), 
			new Point(160, 20),
			new Point(60, 20), 
		]
		
		public function AchievesBar() 
		{
			graphics.beginFill(0x777777, 0.1);
			graphics.drawRect(0,0,620,120);
			graphics.endFill();
						
		}
		
		public function addSlot (slot:AchieveSlot, position:int) :void {
			var eSlot:EmptyAchieveSlot = getSlotById(position);
			(eSlot as DisplayObjectContainer).addChild(slot); 
		}
		
		private function getSlotById (id:int) :EmptyAchieveSlot {
			return slots[id];
		}
		
		public function initHero(vocation:int):void {
			while (this.numChildren) this.removeChildAt(0);
			
			slots = new Vector.<EmptyAchieveSlot>();
			
			asset = Assets.getHeroAssetById(vocation);
			asset = Transform.scale(asset, 90/asset.width);
			addChildAt(asset, 0); 
			
			asset.x = this.width - 260;
			asset.y = (this.height - asset.height) / 2;
			
			for (var i:int = 0; i < 4; i ++) {
				var slot:EmptyAchieveSlot = new EmptyAchieveSlot(i);
				addChild(slot);
				var position:Point = positions[i];
				slot.x = position.x;
				slot.y = position.y;
				slots.push(slot);
			}
			
			if (!labelsInit) {
				addLabels();
			} else {
				addChild(controlLabel);
				addChild(regulalLabel);
				addChild(sprintLabel);
			}
		}
		
		private function addLabels () :void {
			graphics.lineStyle(1, 0xCCCCC, 1);
			graphics.moveTo(60, 100);
			graphics.lineTo(230, 100);
			graphics.moveTo(260, 100);
			graphics.lineTo(330, 100);
			graphics.moveTo(480, 100);
			graphics.lineTo(550, 100);
			
			controlLabel = new TextField();
			controlLabel.antiAliasType = AntiAliasType.ADVANCED;
			controlLabel.width = 170;
			controlLabel.height = 30;
			controlLabel.mouseEnabled = false;
			controlLabel.x = 60;
			controlLabel.y = 100;
			controlLabel.defaultTextFormat = AchievesBar.labelFormat;
			controlLabel.text = 'control';
			addChild(controlLabel);
			
			regulalLabel = new TextField();
			regulalLabel.antiAliasType = AntiAliasType.ADVANCED;
			regulalLabel.width = 70;
			regulalLabel.height = 30;
			regulalLabel.mouseEnabled = false;
			regulalLabel.x = 260;
			regulalLabel.y = 100;
			regulalLabel.defaultTextFormat = AchievesBar.labelFormat;
			regulalLabel.text = 'regular';
			addChild(regulalLabel);
			
			sprintLabel = new TextField();
			sprintLabel.antiAliasType = AntiAliasType.ADVANCED;
			sprintLabel.width = 70;
			sprintLabel.height = 30;
			sprintLabel.mouseEnabled = false;
			sprintLabel.x = 480;
			sprintLabel.y = 100;
			sprintLabel.defaultTextFormat = AchievesBar.labelFormat;
			sprintLabel.text = 'sprint';
			addChild(sprintLabel);
			
			labelsInit = true;
		}
		
		private static var _labelFormat:TextFormat;
		private static function get labelFormat() :TextFormat {
			if (!_labelFormat) {
				_labelFormat = new TextFormat();
				_labelFormat.size = 12;
				_labelFormat.color = 0xCCCCC;
				_labelFormat.align = TextFormatAlign.CENTER;
			}
			return _labelFormat;
		}
		
		public function getSetupData() :Array {
			var data:Array = [] 
			var slot:EmptyAchieveSlot
			for (var i:int = 0; i < slots.length; i ++ ) {
				slot = slots[i] as EmptyAchieveSlot;
				if (slot.numChildren) {
					var slotData:Object = { }
					slotData.position = slot.getId();
					slotData.achieve = (slot.getChildAt(0) as AchieveSlot).achieveId;
					data.push(slotData)
				}
			}
			return data;
		}
		
	}

}