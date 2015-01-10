package com.la.mvc.model 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EptitudeLevel 
	{
		public static function string (value:int) :String {
			var str:String;
			switch (value) {
				case 0: {
					str = 'SELF(к самому себе)'
					break;
				}
				case 1: {
					str = 'RANDOM_OPPONENT_UNIT'
					break;
				}
				case 2: {
					str = 'RANDOM_OPPONENT'
					break;
				}
				case 3: {
					str = 'ALL_OPPONENT_UNITS'
					break;
				}
				case 4: {
					str = 'ALL_OPPONENT'
					break;
				}
				case 5: {
					str = 'RANDOM_ASSOCIATE_UNIT'
					break;
				}
				case 6: {
					str = 'RANDOM_ASSOCIATE'
					break;
				}
				case 7: {
					str = 'ALL_ASSOCIATE_UNITS'
					break;
				}
				case 8: {
					str = 'ALL_ASSOCIATE'
					break;
				}
				case 9: {
					str = 'LEFT_NEIGHBOR'
					break;
				}
				case 10: {
					str = 'RIGHT_NEIGHBOR'
					break;
				}
				case 11: {
					str = 'NEIGHBORS'
					break;
				}
				case 12: {
					str = 'SELECTED_OPPONENT_UNIT'
					break;
				}
				case 13: {
					str = 'SELECTED_OPPONENT'
					break;
				}
				case 14: {
					str = 'SELECTED_OPPONENT_UNIT_RICE'
					break;
				}
				case 15: {
					str = 'SELECTED_OPPONENT_UNIT_SUBRICE'
					break;
				}
				case 16: {
					str = 'SELECTED_OPPONENT_CONDITION'
					break;
				}
				case 17: {
					str = 'SELECTED_ASSOCIATE_UNIT'
					break;
				}
				case 18: {
					str = 'SELECTED_ASSOCIATE'
					break;
				}
				case 19: {
					str = 'SELECTED_ASSOCIATE_UNIT_RICE'
					break;
				}
				case 20: {
					str = 'SELECTED_ASSOCIATE_UNIT_SUBRICE'
					break;
				}
				case 21: {
					str = 'SELECTED_ASSOCIATE_CONDITION'
					break;
				}
				case 22: {
					str = 'SELECTED_ANY'
					break;
				}
				case 23: {
					str = 'SELECTED_ANY_UNIT'
					break;
				}
				case 24: {
					str = 'SELECTED_ANY_RACE'
					break;
				}
				case 25: {
					str = 'SELECTED_ANY_SUBRACE'
					break;
				}
				case 26: {
					str = 'SELECTED_ANY_CONDITION'
					break;
				}
				case 27: {
					str = 'ALL'
					break;
				}
				case 28: {
					str = 'ALL_UNITS'
					break;
				}
				case 29: {
					str = 'RANDOM_ALL'
					break;
				}
				case 30: {
					str = 'RANDOM_ALL_UNIT'
					break;
				}
				case 31: {
					str = 'OPPONENT_HERO'
					break;
				}
				case 32: {
					str = 'ASSOCIATE_HERO'
					break;
				}
				case 33: {
					str = 'ALL_ASSOCIATE_UNIT_RACE'
					break;
				}
				case 34: {
					str = 'ALL_OPPONENT_UNIT_RACE'
					break;
				}
				case 35: {
					str = 'ALL_UNIT_RACE'
					break;
				}
				case 36: {
					str = 'RANDOM_ASSOCIATE_UNIT_RACE'
					break;
				}
				case 37: {
					str = 'RANDOM_OPPONENT_UNIT_RACE'
					break;
				}
				case 38: {
					str = 'EXTRA_ALL_UNITS'
					break;
				}
				case 39: {
					str = 'LAST_PLACED'
					break;
				}
				case 40: {
					str = 'LAST_PLACED_ASSOCIATE'
					break;
				}
				case 41: {
					str = 'LAST_PLACED_OPPONENT'
					break;
				}
				case 42: {
					str = 'LAST_PLACED_RACE'
					break;
				}
				case 43: {
					str = 'RANDOM_ASSOCIATE_SPELL'
					break;
				}
				case 44: {
					str = 'RANDOM_OPPONENT_SPELL'
					break;
				}
				case 45: {
					str = 'RANDOM_ALL_SPELL'
					break;
				}
				case 46: {
					str = 'SELECTED_ASSOCIATE_SPELL'
					break;
				}
				case 47: {
					str = 'SELECTED_OPPONENT_SPELL'
					break;
				}
				case 48: {
					str = 'SELECTED_ALL_SPELL'
					break;
				}
				case 49: {
					str = 'LAST_ATTACKED'
					break;
				}
				case 50: {
					str = 'LAST_ATTACKED_UNIT'
					break;
				}
			}
			return str;
		}				
	}

}