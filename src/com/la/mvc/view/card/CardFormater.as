/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.card {
<<<<<<< HEAD
import com.la.mvc.model.CardData;
=======
import com.ps.cards.CardData;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class CardFormater {

<<<<<<< HEAD
    private static var _labelFormat:TextFormat;
    private static var _saleFormat:TextFormat;
	private static var _titleFormat:TextFormat;
	private static var _miniTitleFormat:TextFormat;
	private static var _descriptionFormat:TextFormat;
	private static var _typeFormat:TextFormat;
	private static var _mirrorTypeFormat:TextFormat;
	private static var _previewTypeFormat:TextFormat;
=======
    private static var _priceFormat:TextFormat;
    private static var _saleFormat:TextFormat;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    private static var _expensiveFormat:TextFormat;
    private static var _mirrorPriceFormat:TextFormat;
    private static var _mirrorExpensiveFormat:TextFormat;
    private static var _mirrorSaleFormat:TextFormat;
    private static var _mirrorAttackFormat:TextFormat;
    private static var _mirrorTitleFormat:TextFormat;
    private static var _mirrorDescriptionFormat:TextFormat;
    private static var _mirrorSmallDescriptionFormat:TextFormat;
<<<<<<< HEAD
	private static var _collectionLabelFormat:TextFormat;
	private static var _countFormat:TextFormat;
	private static var _previewLabelFormat:TextFormat;
	private static var _previewTitleFormat:TextFormat;
	private static var _previewDescriptionFormat:TextFormat;

	

    public static function drawBody (target:Sprite, type:int, width:int, height:int, square:int = 21) :void {
=======

    public static function drawBody (target:Sprite, width:int, height:int) :void {
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        target.graphics.beginFill (0xcccccc, 1);
        target.graphics.drawRect (0, 0, width, height);
        target.graphics.endFill();

        target.graphics.lineStyle (1, 0, 1);
        target.graphics.lineTo (width, 0);
        target.graphics.lineTo (width, height);
        target.graphics.lineTo(0, height);
        target.graphics.lineTo (0, 0);

        target.graphics.beginFill (0xffFFFF, 1);
<<<<<<< HEAD
        target.graphics.drawRect (0, 0, square, square);
        target.graphics.endFill ();
		
        if (type == CardData.UNIT) {
			target.graphics.beginFill (0xffFFFF, 1);
			target.graphics.drawRect (0, height - square, square, square);
			target.graphics.endFill ();
		}
        if (type == CardData.UNIT) {
			target.graphics.beginFill (0xffFFFF, 1);
			target.graphics.drawRect (width - square, height - square, square, square);
			target.graphics.endFill ();
		}
    }

    public static function drawMirror (mirror:Sprite, width:int, height:int, type:int, square:int = 30) :void {
        mirror.graphics.beginFill (0xcccccc, 1);
        mirror.graphics.drawRect (0, 0, width, height);
        mirror.graphics.endFill();

        mirror.graphics.lineStyle (1, 0, 1);
        mirror.graphics.lineTo (width, 0);
        mirror.graphics.lineTo (width, height);
        mirror.graphics.lineTo(0, height);
=======
        target.graphics.drawRect (0, 0, 21, 21);
        target.graphics.endFill ();
    }

    public static function drawMirror (mirror:Sprite, width:int, height:int, type:int) :void {
        mirror.graphics.beginFill (0xcccccc, 1);
        mirror.graphics.drawRect (0, 0, 154, 224);
        mirror.graphics.endFill();

        mirror.graphics.lineStyle (1, 0, 1);
        mirror.graphics.lineTo (154, 0);
        mirror.graphics.lineTo (154, 224);
        mirror.graphics.lineTo(0, 224);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        mirror.graphics.lineTo (0, 0);
        mirror.graphics.lineStyle(0);

        if (type == CardData.UNIT) {
            mirror.graphics.beginFill (0xFFFFFF, 1);
<<<<<<< HEAD
            mirror.graphics.drawRect (0, height-square, square, square);
=======
            mirror.graphics.drawRect (0, 194, 30, 30);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
            mirror.graphics.endFill ();
        }

        if (type == CardData.UNIT) {
            mirror.graphics.beginFill (0xFFFFFF, 1);
<<<<<<< HEAD
            mirror.graphics.drawRect (width-square, height-square, square, square);
=======
            mirror.graphics.drawRect (124, 194, 30, 30);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
            mirror.graphics.endFill ();
        }

        mirror.graphics.beginFill (0xffffff, 1);
<<<<<<< HEAD
        mirror.graphics.drawRect (0, 0, square, square);
=======
        mirror.graphics.drawRect (0, 0, 30, 30);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        mirror.graphics.endFill ();
    }

    public static function drawShirt (target:Sprite, width:int, height:int) :void {
        target.graphics.beginFill (0xFFFFFF, 1);
        target.graphics.drawRect (0, 0, width, height);
        target.graphics.endFill();
        target.graphics.lineStyle (1, 0, 1);
        target.graphics.lineTo (width, 0);
        target.graphics.lineTo (width, height);
        target.graphics.lineTo(0, height);
        target.graphics.lineTo (0, 0);
    }

    public static function drawSmallShirt (target:Sprite) :void {
        target.graphics.beginFill (0xFFFFFF, 1);
        target.graphics.drawRect (0, 0, 100, 150);
        target.graphics.endFill();
        target.graphics.lineStyle (1, 0, 1);
        target.graphics.lineTo (100, 0);
        target.graphics.lineTo (100, 150);
        target.graphics.lineTo(0, 150);
        target.graphics.lineTo (0, 0);
    }

<<<<<<< HEAD
    public static function getLabel (price:int) :TextField {

        var label:TextField = new TextField();
        label.defaultTextFormat = labelFormat;
        label.text = "" + price;
        label.wordWrap = false;
        label.width = label.height = 22; 
=======
    public static function getPriceLabel (price:int) :TextField {

        var label:TextField = new TextField();
        label.defaultTextFormat = priceFormat;
        label.text = "" + price;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.wordWrap = false;
        label.x = 4;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        label.mouseEnabled = false;

        return label;
    }
<<<<<<< HEAD
	
	 public static function getPreviewMirrorLabel (value:int) :TextField {

        var label:TextField = new TextField();
        label.defaultTextFormat = previewLabelFormat;
        label.text = "" + value;
        label.width = label.height = 40;
        label.mouseEnabled = false;

        return label;
    }
	
	public static function getCollectionLabel (value:int) :TextField {
        var label:TextField = new TextField ();
        label.defaultTextFormat = collectionLabelFormat;
        label.text = "" + value;
        label.wordWrap = false;
        label.width = 25;
		label.height = 25;
        label.mouseEnabled = false;
        return label;
    }
	
	 public static function getMirrorLabel (price:int) :TextField {
        var label:TextField = new TextField ();
        label.height = 30;
        label.defaultTextFormat = mirrorFormat;
        label.text = "" + price;
		label.width = 30;
=======

    public static function getMirrorPriceLabel (price:int) :TextField {
        var label:TextField = new TextField ();
        label.defaultTextFormat = mirrorPriceFormat;
        label.text = "" + price;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.wordWrap = false;
        label.x = 7;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        label.mouseEnabled = false;
        return label;
    }

    public static function getMirrorAttackLabel (attack:int) :TextField {
        var label:TextField = new TextField ();
        label.height = 25;
        label.defaultTextFormat = mirrorAttackFormat;
        label.text = "" + attack;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.mouseEnabled = false;
        return label;
    }

    public static function getMirrorHealthLabel (health:int) :TextField {
        var label:TextField = new TextField ();
        label.height = 25;
        label.defaultTextFormat = mirrorHealthFormat;
        label.text = "" + health;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.mouseEnabled = false;
        return label;
    }

    public static function getMirrorTitleLabel (width:int, title:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
        label.defaultTextFormat = mirrorTitleFormat;
        label.text = title;
        label.mouseEnabled = false;
        return label;
    }
<<<<<<< HEAD
	
	public static function getTypeLabel (width:int) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
		label.height = 19;
        label.defaultTextFormat = typeFormat;
        label.mouseEnabled = false;
        return label;
    }
	
	public static function getMirrorTypeLabel (width:int) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
		label.height = 19;
        label.defaultTextFormat = mirrorTypeFormat;
        label.mouseEnabled = false;
        return label;
    }
	
	public static function getPreviewTypeLabel (width:int) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
		label.height = 25;
        label.defaultTextFormat = previewTypeFormat;
        label.mouseEnabled = false;
        return label;
    }
	
	public static function getTitleLabel (width:int, title:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
        label.defaultTextFormat = titleFormat;
        label.text = title;
        label.mouseEnabled = false;
        return label;
    }
	
	public static function getMiniTitleLabel (width:int, title:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
        label.defaultTextFormat = miniTitleFormat;
        label.text = title;
        label.mouseEnabled = false;
        return label;
    }
	
	public static function getPreviewTitleLabel (width:int, title:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
        label.defaultTextFormat = previewTitleFormat;
        label.text = title;
        label.mouseEnabled = false;
        return label;
    }
	
	public static function getPreviewDescriptionLabel (width:int, title:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width - 20;
		label.x = 10;
		label.wordWrap = true;
        label.defaultTextFormat = previewDescriptionFormat;
        label.text = title;
        label.mouseEnabled = false;
        return label;
    }
	
	 public static function getDescriptionLabel (width:int, description:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width - 10;
		label.x = 5;
		label.wordWrap = true;
        label.defaultTextFormat = descriptionFormat;
        label.text = description;
        label.mouseEnabled = false;
        return label;
    }
	
	public static function getCountLabel (width:int) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
		label.height = 20;
        label.defaultTextFormat = countFormat;
        label.mouseEnabled = false;
        return label;
    }
	
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public static function getMirrorDescriptionLabel (width:int, height:int, description:String) :TextField {
        var label:TextField = new TextField ();
        label.antiAliasType = AntiAliasType.ADVANCED;
        label.width = width;
        label.height = height;
        label.wordWrap = true;
        label.mouseEnabled = false;
        if (description.length > 20) {
            label.defaultTextFormat = mirrorSmallDescriptionFormat;
        } else {
            label.defaultTextFormat =mirrorDescriptionFormat;
        }
        label.text = description;
        return label;
    }
<<<<<<< HEAD
	
	public static function get collectionLabelFormat () :TextFormat {
        if (!_collectionLabelFormat) {
            _collectionLabelFormat = new TextFormat();
            _collectionLabelFormat.size = 15;
            _collectionLabelFormat.bold = true;
            _collectionLabelFormat.color = 0x000000;
			_collectionLabelFormat.align = TextFormatAlign.CENTER;
        }
        return _collectionLabelFormat;
    }
	
	public static function get previewLabelFormat () :TextFormat {
        if (!_previewLabelFormat) {
            _previewLabelFormat = new TextFormat();
            _previewLabelFormat.size = 30;
            _previewLabelFormat.bold = true;
            _previewLabelFormat.color = 0x000000;
			_previewLabelFormat.align = TextFormatAlign.CENTER;
        }
        return _previewLabelFormat;
    }

    public static function get labelFormat () :TextFormat {
        if (!_labelFormat) {
            _labelFormat = new TextFormat();
            _labelFormat.size = 15;
            _labelFormat.bold = true;
			_labelFormat.align = TextFormatAlign.CENTER;
            _labelFormat.color = 0x000000;
        }
        return _labelFormat;
=======

    public static function get priceFormat () :TextFormat {
        if (!_priceFormat) {
            _priceFormat = new TextFormat();
            _priceFormat.size = 15;
            _priceFormat.bold = true;
            _priceFormat.color = 0x000000;
        }
        return _priceFormat;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }

    public static function get saleFormat () :TextFormat {
        if (!_saleFormat) {
            _saleFormat = new TextFormat();
            _saleFormat.size = 15;
            _saleFormat.bold = true;
            _saleFormat.color = 0x00FF00;;
        }
        return _saleFormat;
    }

    public static function get expensiveFormat () :TextFormat {
        if (!_expensiveFormat) {
            _expensiveFormat = new TextFormat();
            _expensiveFormat.size = 15;
            _expensiveFormat.bold = true;
            _expensiveFormat.color = 0xFF0000;
        }
        return _expensiveFormat;
    }

<<<<<<< HEAD
    public static function get mirrorFormat () :TextFormat {
=======
    public static function get mirrorPriceFormat () :TextFormat {
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        if (!_mirrorPriceFormat) {
            _mirrorPriceFormat = new TextFormat();
            _mirrorPriceFormat.size = 22;
            _mirrorPriceFormat.bold = true;
            _mirrorPriceFormat.color = 0x000000;
<<<<<<< HEAD
			_mirrorPriceFormat.align = TextFormatAlign.CENTER;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        }
        return _mirrorPriceFormat;
    }

    public static function get mirrorSaleFormat () :TextFormat {
        if (!_mirrorSaleFormat) {
            _mirrorSaleFormat = new TextFormat();
            _mirrorSaleFormat.size = 22;
            _mirrorSaleFormat.bold = true;
            _mirrorSaleFormat.color = 0x00FF00;
        }
        return _mirrorSaleFormat;
    }

    public static function get mirrorExpensiveFormat () :TextFormat {
        if (!_mirrorExpensiveFormat) {
            _mirrorExpensiveFormat = new TextFormat();
            _mirrorExpensiveFormat.size = 22;
            _mirrorExpensiveFormat.bold = true;
            _mirrorExpensiveFormat.color = 0x00FF00;
        }
        return _mirrorExpensiveFormat;
    }

    public static function get mirrorAttackFormat () :TextFormat {
        if (!_mirrorAttackFormat) {
            _mirrorAttackFormat = new TextFormat();
            _mirrorAttackFormat.size = 22;
            _mirrorAttackFormat.bold = true;
            _mirrorAttackFormat.color = 0x000000;
        }
        return _mirrorAttackFormat;
    }

    public static function get mirrorHealthFormat () :TextFormat {
        return mirrorAttackFormat;
    }

    public static function get mirrorTitleFormat () :TextFormat {
        if (!_mirrorTitleFormat) {
            _mirrorTitleFormat = new TextFormat();
            _mirrorTitleFormat.align = TextFormatAlign.CENTER;
            _mirrorTitleFormat.size = 14;
            _mirrorTitleFormat.bold = true;
            _mirrorTitleFormat.color = 0x000000;
        }
        return _mirrorTitleFormat;
    }
<<<<<<< HEAD
	
	public static function get titleFormat () :TextFormat {
        if (!_titleFormat) {
            _titleFormat = new TextFormat();
            _titleFormat.align = TextFormatAlign.CENTER;
            _titleFormat.size = 12;
            _titleFormat.bold = true;
            _titleFormat.color = 0x000000;
        }
        return _titleFormat;
    }
	
	public static function get miniTitleFormat () :TextFormat {
        if (!_miniTitleFormat) {
           _miniTitleFormat = new TextFormat();
           _miniTitleFormat.align = TextFormatAlign.CENTER;
           _miniTitleFormat.size = 10;
           _miniTitleFormat.bold = true;
           _miniTitleFormat.color = 0x000000;
        }
        return _miniTitleFormat;
    }
	
	public static function get previewTitleFormat () :TextFormat {
        if (!_previewTitleFormat) {
            _previewTitleFormat = new TextFormat();
            _previewTitleFormat.align = TextFormatAlign.CENTER;
            _previewTitleFormat.size = 24;
            _previewTitleFormat.bold = true;
            _previewTitleFormat.color = 0x000000;
        }
        return _previewTitleFormat;
    }
	
	 public static function get previewDescriptionFormat () :TextFormat {
        if (!_previewDescriptionFormat) {
            _previewDescriptionFormat = new TextFormat();
            _previewDescriptionFormat.align = TextFormatAlign.CENTER;
            _previewDescriptionFormat.size = 15;
            _previewDescriptionFormat.bold = true;
            _previewDescriptionFormat.color = 0x000000;
        }
        return _previewDescriptionFormat;
    }

=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public static function get mirrorDescriptionFormat () :TextFormat {
        if (!_mirrorDescriptionFormat) {
            _mirrorDescriptionFormat = new TextFormat();
<<<<<<< HEAD
            _mirrorDescriptionFormat.align = TextFormatAlign.CENTER;
=======
            _mirrorDescriptionFormat..align = TextFormatAlign.CENTER;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
            _mirrorDescriptionFormat.size = 13;
            _mirrorDescriptionFormat.bold = true;
            _mirrorDescriptionFormat.color = 0x000000;
        }
        return _mirrorDescriptionFormat;
    }
<<<<<<< HEAD
	
	 public static function get descriptionFormat () :TextFormat {
        if (!_descriptionFormat) {
            _descriptionFormat = new TextFormat();
            _descriptionFormat.align = TextFormatAlign.CENTER;
            _descriptionFormat.size = 11;
            _descriptionFormat.color = 0x000000;
        }
        return _descriptionFormat;
    }
	
	 public static function get typeFormat () :TextFormat {
        if (!_typeFormat) {
            _typeFormat = new TextFormat();
            _typeFormat.align = TextFormatAlign.CENTER;
            _typeFormat.size = 11;
			_typeFormat.bold = true;
            _typeFormat.color = 0x000000;
        }
        return _typeFormat;
    }
	
	 public static function get mirrorTypeFormat () :TextFormat {
        if (!_mirrorTypeFormat) {
            _mirrorTypeFormat = new TextFormat();
            _mirrorTypeFormat.align = TextFormatAlign.CENTER;
            _mirrorTypeFormat.size = 12;
			_mirrorTypeFormat.bold = true;
            _mirrorTypeFormat.color = 0x000000;
        }
        return _mirrorTypeFormat;
    }
	
	 public static function get previewTypeFormat () :TextFormat {
        if (!_previewTypeFormat) {
            _previewTypeFormat = new TextFormat();
            _previewTypeFormat.align = TextFormatAlign.CENTER;
            _previewTypeFormat.size = 16;
			_previewTypeFormat.bold = true;
            _previewTypeFormat.color = 0x000000;
        }
        return _previewTypeFormat;
    }
	
	
	 public static function get countFormat () :TextFormat {
        if (!_countFormat) {
            _countFormat = new TextFormat();
            _countFormat.align = TextFormatAlign.CENTER;
            _countFormat.size = 16;
			_countFormat.bold = true;
            _countFormat.color = 0xEEEEEE;
        }
        return _countFormat;
    }


=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public static function get mirrorSmallDescriptionFormat () :TextFormat {
        if (!_mirrorSmallDescriptionFormat) {
            _mirrorSmallDescriptionFormat = new TextFormat();
            _mirrorSmallDescriptionFormat.align = TextFormatAlign.CENTER;
            _mirrorSmallDescriptionFormat.size = 11;
            _mirrorSmallDescriptionFormat.bold = true;
            _mirrorSmallDescriptionFormat.color = 0x000000;
        }
        return _mirrorSmallDescriptionFormat;
    }



}
}
