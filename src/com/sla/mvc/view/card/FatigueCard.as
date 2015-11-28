package com.sla.mvc.view.card 
{
	import feathers.controls.Label;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FatigueCard extends Sprite 
	{
		
		private var container:Sprite;
		private var titleLabel:Label;
		private var damageLabel:Label;
		
		public function FatigueCard(damage:String) 
		{
			container = new Sprite();
			addChild(container);
			
			container.x -= Card.MIRROR_WIDTH / 2;
			container.y -= Card.MIRROR_HEIGHT / 2;
			
			var quad:Quad = new Quad(Card.MIRROR_WIDTH, Card.MIRROR_HEIGHT, 0x222222);
			container.addChild(quad);
			
			titleLabel = new Label();
			titleLabel.text = 'Fatigue';
			titleLabel.width = Card.MIRROR_WIDTH;
			titleLabel.y = Card.MIRROR_HEIGHT * 0.45;
			titleLabel.styleNameList.add('craftCollectionMirrorCardTitleLabel');
			container.addChild(titleLabel);
			
			damageLabel = new Label();
			damageLabel.text = damage;
			damageLabel.width = Card.MIRROR_WIDTH;
			damageLabel.y = Card.MIRROR_HEIGHT * 0.65;
			damageLabel.styleNameList.add('craftCollectionMirrorCardTitleLabel');
			container.addChild(damageLabel);
			
		}
		
	}

}