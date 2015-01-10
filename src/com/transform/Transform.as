/**
 * Created by root on 10/29/14.
 */
package com.transform {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;
<<<<<<< HEAD
import flash.geom.Rectangle;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

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
<<<<<<< HEAD
	
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
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
}
}
