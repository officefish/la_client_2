package com.indico.fan 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FanData 
	{
		
		private var _position:Point;
		private var _rotation:Number;
		private var _distance:Number;
		private var _angle:Number;
		private var _longPosition:Point;
		
		public function set position (value:Point) :void {
			_position = value;
		}
		public function get position () :Point {
			return _position;
		}
		
		public function set rotation (value:Number) :void {
			_rotation = value;
		}
		public function get rotation () :Number {
			return _rotation;
		}
		
		public function set distance (value:Number) :void {
			_distance = value;
		}
		public function get distance () :Number {
			return _distance;
		}
		
		public function set angle (value:Number) :void {
			_angle = value;
		}
		public function get angle () :Number {
			return _angle;
		}
		
		public function set longPosition (value:Point) :void {
			_longPosition = value;
		}
		public function get longPosition () :Point {
			return _longPosition;
		}
		
	}

}