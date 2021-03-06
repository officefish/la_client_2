/**
 * Created by root on 10/29/14.
 */
package com.transform {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;

public class Transform {
    public function Transform() {
    }

    public static function scale (asset:Bitmap, scale:Number) :Bitmap {
        scale = Math.abs(scale);
        var bitmapData:BitmapData = asset.bitmapData;
        var width:int = (bitmapData.width * scale) || 1;
        var height:int = (bitmapData.height * scale) || 1;
        var transparent:Boolean = bitmapData.transparent;
        var result:BitmapData = new BitmapData(width, height, transparent);
        var matrix:Matrix = new Matrix();
        matrix.scale(scale, scale);
        result.draw(bitmapData, matrix);
        return new Bitmap(result);
    }
	
	public static function toSize (asset:Bitmap, width:int, height:int) :Bitmap {
        var bitmapData:BitmapData = asset.bitmapData;
        var scaleX:Number = width / asset.width;
        var scaleY:Number = height / asset.height;
        var transparent:Boolean = bitmapData.transparent;
        var result:BitmapData = new BitmapData(width, height, transparent);
        var matrix:Matrix = new Matrix();
        matrix.scale(scaleX, scaleY);
        result.draw(bitmapData, matrix);
        return new Bitmap(result);
    }
	
	public static function crop (asset:Bitmap, square:Rectangle) :Bitmap {
		var bitmapData:BitmapData = asset.bitmapData;
        var width:int = square.width;
        var height:int = square.height;
		var transparent:Boolean = bitmapData.transparent;
        var result:BitmapData = new BitmapData(width, height, transparent);
        var matrix:Matrix = new Matrix();
		var dx:int = (asset.bitmapData.width - square.width) / 2;
		var dy:int = (asset.bitmapData.height - square.height) / 2;
		matrix.translate (-dx, -dy);
        result.draw(bitmapData, matrix);
        return new Bitmap(result);
	}
	
	public static function cropAndShift (asset:Bitmap, square:Rectangle, shiftX:int, shiftY:int) :Bitmap {
		var bitmapData:BitmapData = asset.bitmapData;
        var width:int = square.width;
        var height:int = square.height;
		var transparent:Boolean = bitmapData.transparent;
        var result:BitmapData = new BitmapData(width, height, transparent);
        var matrix:Matrix = new Matrix();
		var dx:int = shiftX;
		var dy:int = shiftY;
		matrix.translate (-dx, -dy);
        result.draw(bitmapData, matrix);
        return new Bitmap(result);
	}
}
}
