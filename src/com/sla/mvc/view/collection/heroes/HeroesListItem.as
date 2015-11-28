package com.sla.mvc.view.collection.heroes 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.la.mvc.view.collection.NewDeckButton;
	import com.sla.event.starling.HeroListItemEvent;
	import com.sla.mvc.model.data.HeroData;
	import com.sla.theme.Assets;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.FragmentFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroesListItem extends Sprite 
	{
		
		private var data:HeroData;
		private var disableQuand:Quad;
		private var _selected:Boolean = false;
		
		private var labelQuad:Quad;
		private var labelLineQuad:Quad;
		private var label:TextField;
		
		
		
		public function HeroesListItem(data:HeroData) 
		{
			//MonsterDebugger.log (data);	
			this.data = data;
			
			var texture:Texture = Assets.getHeroAssetById(data.uid); 
			var asset:Image = new Image(texture); 
			addChild(asset);
			
			disableQuand = new Quad(120, 120);
			disableQuand.color = 0x222222;
			disableQuand.alpha = 0.5;
			addChild(disableQuand);
			
			
			labelQuad = new Quad(100, 50);
			labelQuad.x = 10;
			labelQuad.y = 60;
			labelQuad.alpha = 0.5;
			labelQuad.color = 0;
			addChild(labelQuad);
			
			labelLineQuad = new Quad(1, 50);
			labelLineQuad.x = 10;
			labelLineQuad.y = 60;
			labelLineQuad.color = 0xFFFFFF;
			addChild(labelLineQuad);
			
			label = new TextField(100, 20, "", "SupriaSans", 11, 0xFFFFFF);
			label.hAlign="left";
			label.x = 20;
			label.y = labelQuad.y + 5;
			label.text = data.title;
			addChild(label);
			
			this.useHandCursor = true;
			
			this.addEventListener(TouchEvent.TOUCH, onTouch); 

		}
		
		private function onTouch (event:TouchEvent) :void {
			if (_selected) return;
			
			if (event.getTouch(this, TouchPhase.HOVER)) { 
				disableQuand.visible = false;
			} else {
				disableQuand.visible = true;
			}
			if (event.getTouch(this, TouchPhase.BEGAN))
			{
				disableQuand.visible = false;
				dispatchEvent(new HeroListItemEvent(HeroListItemEvent.SELECT, true));
			}
		}
		
		
		public function set selected (value:Boolean) :void {
			_selected = value;
			if (value) {
				this.filter = blurFilter; 
				this.removeEventListener(TouchEvent.TOUCH, onTouch);
				disableQuand.visible = false;
			} else {
				this.filter = null;
				this.addEventListener(TouchEvent.TOUCH, onTouch);
				disableQuand.visible = true;
			}
			
		}
		
		private static var _blurFilter:BlurFilter;
		private static function get blurFilter () :FragmentFilter {
			if (_blurFilter == null) {
				_blurFilter =  BlurFilter.createGlow(0xFFCC00,5,5,0.1);
				_blurFilter.blurX = 0;
				_blurFilter.blurY = 0; 
			}
			return _blurFilter;
		}
		
		public function getData () :HeroData {
			return data;
		}
	}

}