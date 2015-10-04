package com.sla.mvc.view.hand 
{
	import com.indico.fan.Fan;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PlayerFanSettings 
	{
		public static function apply (count:int, fan:Fan) :void {
			var distance:Number;
			var distanceShift:Number;
			var radius:Number;
			var radiusShift:Number;
			switch (count) {
				case 1: {
					distance = 13;
					distanceShift = 1.2;
					radius = 420;
					radiusShift = 50;
					break;
				}
				case 2: {
					distance = 13;
					distanceShift = 1.2;
					radius = 420;
					radiusShift = 50;
					break;
				}
				case 3: {
					distance = 13;
					distanceShift = 1.2;
					radius = 420;
					radiusShift = 50;
					break;
				}
				case 4: {
					distance = 14;
					distanceShift = 1.3;
					radius = 420;
					radiusShift = 40;
					break;
				}
				case 5: {
					distance = 14;
					distanceShift = 1.3;
					radius = 420;
					radiusShift = 40;
					break;
				}
				case 6: {
					distance = 14;
					distanceShift = 1.3;
					radius = 420;
					radiusShift = 40;
					break;
				}
				case 7: {
					distance = 14;
					distanceShift = 1.3;
					radius = 420;
					radiusShift = 40;
					break;
				}
				case 8: {
					distance = 14;
					distanceShift = 1.3;
					radius = 460;
					radiusShift = 50;
					break;
				}
				case 9: {
					distance = 14;
					distanceShift = 1.3;
					radius = 460;
					radiusShift = 70;
					break;
				}
				case 10: {
					distance = 15;
					distanceShift = 1.3;
					radius = 460;
					radiusShift = 60;
					break;
				}
			}
			fan.distance = distance;
			fan.distanceShift = distanceShift;
			fan.radius = radius;
			fan.radiusShift = radiusShift;
		}
	}

}