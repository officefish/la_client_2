package com.sla.mvc.view.collection 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionCursor
	{
		
		public static const LEFT:int = 1;
		public static const RIGHT:int = 2;
		public static const DEFAULT:int = 0;
		
		[Embed(source="../../../../../../lib/assets/left.png")]
		private static var LeftCursor:Class;
		private static var left:Bitmap = new LeftCursor as Bitmap;
		
		
		[Embed(source="../../../../../../lib/assets/right.png")]
		private static var RightCursor:Class;
		private static var right:Bitmap = new RightCursor as Bitmap;
		
		private static var mouseLeftCursorData:MouseCursorData = new MouseCursorData();  
		private static var leftCursorData:Vector.<BitmapData> = new Vector.<BitmapData>();  
				
		private static var mouseRightCursorData:MouseCursorData = new MouseCursorData(); 
		private static var rightCursorData:Vector.<BitmapData> = new Vector.<BitmapData>();  

		
		public static function init () :void {
			leftCursorData.push(left.bitmapData); 
			mouseLeftCursorData.data = leftCursorData; 
			Mouse.registerCursor("leftNav", mouseLeftCursorData);
			
			rightCursorData.push(right.bitmapData); 
			mouseRightCursorData.data = rightCursorData; 
			Mouse.registerCursor("rightNav", mouseRightCursorData);
		}
		
		public static function setState (state:int) :void {
			switch (state) {
				case 0: {
					Mouse.cursor = MouseCursor.AUTO;
					break;
				}
				case 1: {
					Mouse.cursor = "leftNav"; 
					break;
				}
				case 2: {
					Mouse.cursor = "rightNav"; 
					break;
				}
			}
		}
	}

}