package com.indico.fan {
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Fan extends Sprite 
	{
		private var _radiusShift:Number = 50;
		private var _radius:Number = 400;
		private var _distance:Number = 15;
		private var _distanceShift:Number = 1.2;
		private var _long:uint = 50;
		
		public function set radius (value:Number) :void {
			_radius = value;
		}
		public function get radius () :Number {
			return _radius;
		}
		public function set radiusShift (value:Number) :void {
			_radiusShift = value;
		}
		public function get radiusShift () :Number {
			return _radiusShift;
		}
		public function set distance (value:Number) :void {
			_distance = value;
		}
		public function get distance () :Number {
			return _distance;
		}
		public function set distanceShift (value:Number) :void {
			_distanceShift = value;
		}
		public function get distanceShift () :Number {
			return _distanceShift;
		}
		public function set long (value:uint) :void {
			_long = value;
		}
		public function get long () :uint {
			return _long;
		}
		
		private function degreesToRadians(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		public function calculate (count:uint, whiteFlag:Boolean) :Vector.<FanData> {
			var vector:Vector.<FanData> = new Vector.<FanData>();
			var x1:int;
			var y1:int;
			var x2:int;
			var y2:int;
			var qAngle:Number;
			var shift:int = distance;
			var cof:int;
			var cRadius:uint = radius;
			
			if (whiteFlag) {
				cof = 270;
			} else {
				cof = 90;
			}
			
			cRadius += radiusShift * count;
			shift -= distanceShift * count;
			
			if (count > 1) {
				if (isEven(count)) {
					cof -= (shift / 2) * (count - 1);
				} else {
					cof -= (shift) * ((count - 1) / 2)
				}
			}
			if (!whiteFlag) {
				cof += (count - 1) * shift;
			}
			
			// - (5 * (count - 1)) ;
			var data:FanData;
			var angle:Number;
					
			if (whiteFlag) {
				for (var i:int = 0; i < count; i ++) {
					angle = degreesToRadians(cof);
					x1 = (Math.cos(angle) * cRadius);
					y1 = (Math.sin(angle) * cRadius);
					x2 = (Math.cos(angle) * (cRadius + long));
					y2 = (Math.sin(angle) * (cRadius + long));
					qAngle = Math.atan2(y1, x1) / Math.PI * 180;
					qAngle = (qAngle < 0) ? qAngle + 360 : qAngle;
					qAngle = degreesToRadians(qAngle + 90);
					y1 += cRadius;
					y2 += cRadius;
					data = new FanData();
					data.distance = cof;
					data.angle = angle;
					data.position = new Point(x1, y1);
					data.longPosition = new Point(x2, y2);
					data.rotation = qAngle;
					//{'cof':cof, 'angle':angle, 'x':x1, 'y':y1, 'rotation':qAngle };
					vector.push(data);
					cof += shift;
				}
			} else {
				for (i = count - 1; i > - 1; i --) {
					angle = degreesToRadians(cof);
					x1 = (Math.cos(angle) * cRadius);
					y1 = (Math.sin(angle) * cRadius);
					x2 = (Math.cos(angle) * (cRadius + long));
					y2 = (Math.sin(angle) * (cRadius + long));
					qAngle = Math.atan2(y1, x1) / Math.PI * 180;
					qAngle = (qAngle < 0) ? qAngle + 360 : qAngle;
					qAngle = degreesToRadians(qAngle + 90);
					y1 -= cRadius;
					y2 -= cRadius;
										
					data = new FanData();
					data.distance = cof;
					data.angle = angle;
					data.position = new Point(x1, y1);
					data.longPosition = new Point(x2, y2);
					data.rotation = qAngle;
					//{'cof':cof, 'angle':angle, 'x':x1, 'y':y1, 'rotation':qAngle };
					vector.push(data);
					cof -= shift;
					
				}
			}
			
			return vector;
		}
		public function isEven(value:Number) :Boolean {
			return (value % 2 == 0);
		}
		
		
	}
	
	

}