package com.sla.mvc.view.card 
{
	import com.sla.mvc.model.data.CardData;
	import feathers.controls.Label;
	import feathers.controls.TextArea;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.display.Quad;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardFormater 
	{
		
		private static const BACKGROUND_COLOR:uint = 0xcccccc;
		private static const BORDER_TICKNESS:uint = 2;
		private static const BORDER_COLOR:uint = 0xFFFFFF;
		
		public function CardFormater() 
		{
			
		}
		
		public static function drawBody (targetWidth:int, targetHeight:int, type:int, square:uint = 21) :QuadBatch {
			
			var body:QuadBatch = new QuadBatch();
			
			var background:Quad = new Quad(targetWidth, targetHeight, BACKGROUND_COLOR);
			body.addQuad(background);
			
			// create borders
			var left : Quad = new Quad(BORDER_TICKNESS, targetHeight, BORDER_COLOR);
			left.alpha = 0;
			var right : Quad = new Quad(BORDER_TICKNESS, targetHeight, BORDER_COLOR);
			right.alpha = 0;
 
			var top : Quad = new Quad(targetWidth, BORDER_TICKNESS, BORDER_COLOR);
			top.alpha = 0;
			var down : Quad = new Quad(targetWidth, BORDER_TICKNESS, BORDER_COLOR);
			down.alpha = 0;
 
			// placing elements (top and left already placed)
			right.x = targetWidth - BORDER_TICKNESS;
			down.y = targetHeight - BORDER_TICKNESS;
			
			// build box
			body.addQuad(left);
			body.addQuad(top);
			body.addQuad(right);
			body.addQuad(down);	
			
			var priceQuad:Quad = new Quad(square, square, 0xFFFFFF);
			body.addQuad(priceQuad);
						
			if (type == CardData.UNIT) {
				var attackQuad:Quad = new Quad(square, square, 0xFFFFFF);
				attackQuad.y = targetHeight - attackQuad.height;
				body.addQuad(attackQuad);
				
				var healthQuad:Quad = new Quad(square, square, 0xFFFFFF);
				healthQuad.y = targetHeight - healthQuad.height;
				healthQuad.x = targetWidth - healthQuad.width;
				body.addQuad(healthQuad);
			}
 
			return body;
		}
		
		public static function drawValueLabel (value:String) :Label {
			var label:Label = new Label();
			label.styleNameList.add('cardValueLabel');
			label.text = value;
			return label;
		}
		
		public static function drawCollectionValueLabel (value:String) :Label {
			var label:Label = new Label();
			label.styleNameList.add('collectionCardValueLabel');
			label.text = value;
			return label;
		}
		
		public static function drawCollectionMirrorValueLabel (value:String) :Label {
			var label:Label = new Label();
			label.styleNameList.add('collectionMirrorCardValueLabel');
			label.text = value;
			return label;
		}
		
		public static function drawTitleLabel (value:String) :Label {
			var label:Label = new Label();
			label.styleNameList.add('cardTitleLabel');
			label.text = value;
			return label;
		}
		
		public static function drawCollectionCountLabel (width:int) :Label {
			var label:Label = new Label();
			label.width = width;
			label.styleNameList.add('collectionCardCountLabel')
			return label;
		}
		
		public static function drawCollectionTitleLabel (value:String) :Label {
			var label:Label = new Label();
			label.styleNameList.add('collectionCardTitleLabel');
			label.text = value;
			return label;
		}
		
		public static function drawCollectionMirrorTitleLabel (value:String) :Label {
			var label:Label = new Label();
			label.styleNameList.add('collectionMirrorCardTitleLabel');
			label.text = value;
			return label;
		}
		
		
		public static function drawDescriptionArea (value:String) :TextArea {
			var area:TextArea = new TextArea();
			area.isEditable = false;
			area.isEnabled = false;
			area.selectRange(0);
			area.styleNameList.add('cardDescriptionArea');
			area.text = value;
			return area;
		}
		
		public static function drawCollectionDescriptionArea (value:String) :TextArea {
			var area:TextArea = new TextArea();
			area.isEditable = false;
			area.isEnabled = false;
			area.selectRange(0);
			area.styleNameList.add('collectionCardDescriptionArea');
			area.text = value;
			return area;
		}
		
		public static function drawCollectionMirrorDescriptionArea (value:String) :TextArea {
			var area:TextArea = new TextArea();
			area.isEditable = false;
			area.isEnabled = false;
			area.selectRange(0);
			area.styleNameList.add('collectionMirrorCardDescriptionArea');
			area.text = value;
			return area;
		}
		
		public static function drawTypeLabel () :Label {
			var label:Label = new Label();
			label.styleNameList.add('cardTypeLabel');
			return label;
		}
		
		public static function drawCollectionTypeLabel () :Label {
			var label:Label = new Label();
			label.styleNameList.add('collectionCardTypeLabel');
			return label;
		}
		
		public static function drawCollectionMirrorTypeLabel () :Label {
			var label:Label = new Label();
			label.styleNameList.add('collectionMirrorCardTypeLabel');
			return label;
		}
		
		
		public static function drawMirrorValueLabel (value:String) :Label {
			var label:Label = new Label();
			label.styleNameList.add('mirrorCardValueLabel');
			label.text = value;
			return label;
		}
		
		public static function drawMirrorTitleLabel (value:String) :Label {
			var label:Label = new Label();
			label.styleNameList.add('mirrorCardTitleLabel');
			label.text = value;
			return label;
		}
		
		public static function drawMirrorDescriptionArea (value:String) :TextArea {
			var area:TextArea = new TextArea();
			area.isEditable = false;
			area.isEnabled = false;
			area.selectRange(0);
			area.styleNameList.add('mirrorCardDescriptionArea');
			area.text = value;
			return area;
		}
		
		public static function drawMirrorTypeLabel () :Label {
			var label:Label = new Label();
			label.styleNameList.add('mirrorCardTypeLabel');
			return label;
		}
		
		
		
		
	}

}