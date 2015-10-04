package com.sla.mvc.model.data 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EptitudePeriod 
	{
		/*
	 '-1':'ACTIVATED',
    '0':'START_STEP',
    '1':'END_STEP',
    '2':'SELF_PLACED',
    '3':'ASSOCIATE_PLACED',
    '4':'OPPONENT_PLACED',
    '5':'ALL_PLACED',
    '6':'ASSOCIATE_RACE_PLACED',
    '7':'OPPONENT_RACE_PLACED',
    '8':'ALL_RACE_PLACED',
    '9':'SELF_WOUND',
    '10':'ASSOCIATE_WOUND',
    '11':'OPPONENT_WOUND',
    '12':'ALL_WOUND',
    '13':'SELF_DIE',
    '14':'ASSOCIATE_DIE',
    '15':'OPPONENT_DIE',
    '16':'ALL_DIE',
    '17':'ASSOCIATE_TREATED',
    '18':'OPPONENT_TREATED',
    '19':'ALL_TREATED',
    '20':'ASSOCIATE_SPELL',
    '21':'OPPONENT_SPELL',
    '22':'ALL_SPELL',
    '23':'ASSOCIATE_PLAY_CARD',
    '24':'OPPONENT_PLAY_CARD',
    '25':'ALL_PLAY_CARD',
    '26':'ATTACK'
	*/
		public static function string (value:int) :String {
			var str:String;
			switch (value) {
				case 0: {
					str = 'START_STEP'
					break;
				}
				case 1: {
					str = 'END_STEP'
					break;
				}
				case 2: {
					str = 'SELF_PLACED'
					break;
				}
				case 3: {
					str = 'ASSOCIATE_PLACED'
					break;
				}
				case 4: {
					str = 'OPPONENT_PLACED'
					break;
				}
				case 5: {
					str = 'ALL_PLACED'
					break;
				}
				case 6: {
					str = 'ASSOCIATE_RACE_PLACED'
					break;
				}
				case 7: {
					str = 'OPPONENT_RACE_PLACED'
					break;
				}
				case 8: {
					str = 'ALL_RACE_PLACED'
					break;
				}
				case 9: {
					str = 'SELF_WOUND'
					break;
				}
				case 10: {
					str = 'ASSOCIATE_WOUND'
					break;
				}
				case 11: {
					str = 'OPPONENT_WOUND'
					break;
				}
				case 12: {
					str = 'ALL_WOUND'
					break;
				}
				case 13: {
					str = 'SELF_DIE'
					break;
				}
				case 14: {
					str = 'ASSOCIATE_DIE'
					break;
				}
				case 15: {
					str = 'OPPONENT_DIE'
					break;
				}
				case 16: {
					str = 'ALL_DIE'
					break;
				}
				case 17: {
					str = 'ASSOCIATE_TREATED'
					break;
				}
				case 18: {
					str = 'OPPONENT_TREATED'
					break;
				}
				case 19: {
					str = 'ALL_TREATED'
					break;
				}
				case 20: {
					str = 'ASSOCIATE_SPELL'
					break;
				}
				case 21: {
					str = 'OPPONENT_SPELL'
					break;
				}
				case 22: {
					str = 'ALL_SPELL'
					break;
				}
				case 23: {
					str = 'ASSOCIATE_PLAY_CARD'
					break;
				}
				case 24: {
					str = 'OPPONENT_PLAY_CARD'
					break;
				}
				case 25: {
					str = 'ALL_PLAY_CARD'
					break;
				}
				case 26: {
					str = 'ATTACK'
					break;
				}
				case 55: {
					str = 'ACTIVATE_ACTIVE';
					break;
				}
				
			}
			return str;
		}
		
	}

}