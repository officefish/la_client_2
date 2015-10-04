package com.sla.mvc.view.field 
{
	import com.sla.mvc.view.field.minion.Minion;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MinionPosition 
	{
		public static function getVectorPositions (numChildren:int) :Vector.<int> {
			var positions:Vector.<int> = new Vector.<int>();
			var sum:int = Field.PADDING + Minion.WIDTH;
			var startPosition:int = sum / 2 * (numChildren - 1) * -1;
			var position:int;
			for (var i:int = 0; i < numChildren; i ++) {
				position = startPosition + (sum * i);
				positions.push(position);
			}
			return positions;
		}
		
		public static function getArrayPositions (numChildren:int) :Array {
			var positions:Array = [];
			var sum:int = Field.PADDING + Minion.WIDTH;
			var startPosition:int = sum / 2 * (numChildren - 1) * -1;
			var position:int;
			for (var i:int = 0; i < numChildren; i ++) {
				position = startPosition + (sum * i);
				positions.push(position);
			}
			return positions;
		}
	}

}