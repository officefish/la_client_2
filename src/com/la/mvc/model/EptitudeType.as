package com.la.mvc.model 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EptitudeType 
	{
		
		public static function string (value:int) :String {
			var str:String;
			switch (value) {
				case 1: {
					str = 'JERK(рывок)'
					break;
				}
				case 2: {
					str = 'DOUBLE_ATTACK(двойная аттака)'
					break;
				}
				case 3: {
					str = 'PASSIVE_ATTACK(пассивная атака)'
					break;
				}
				case 4: {
					str = 'PROVOCATION(провокация)'
					break;
				}
				case 5: {
					str = 'INCREASE_ATTACK(увеличение аттаки)'
					break;
				}
				case 6: {
					str = 'INCREASE_HEALTH(увеличение здоровья)'
					break;
				}
				case 7: {
					str = 'DECREASE_ATTACK(уменьшение аттаки)'
					break;
				}
				case 8: {
					str = 'DECREASE_HEALTH(уменьшение здоровья)'
					break;
				}
				case 9: {
					str = 'CHANGE_ATTACK_TILL(изменение аттаки до)'
					break;
				}
				case 10: {
					str = 'CHANGE_HEALTH_TILL(изменение здоровья до)'
					break;
				}
				case 11: {
					str = 'FULL_HEALTH(полное восстановление здоровья)'
					break;
				}
				case 12: {
					str = 'DUMBNESS(немота)'
					break;
				}
				case 13: {
					str = 'TREATMENT(лечение)'
					break;
				}
				case 14: {
					str = 'PICK_CARD(карта из колоды)'
					break;
				}
				case 15: {
					str = 'BACK_CARD_TO_HAND(возвращение карты в колоду)'
					break;
				}
				case 16: {
					str = 'KILL(убийство)'
					break;
				}
				case 17: {
					str = 'SHADOW(тень)'
					break;
				}
				case 18: {
					str = 'FREEZE(заморозка)'
					break;
				}
				case 19: {
					str = 'NEW_UNIT(новый юнит)'
					break;
				}
				case 20: {
					str = 'SHIELD(божественный щит)'
					break;
				}
				case 21: {
					str = 'INCREASE_ATTACK_MIXIN(доп.увеличение к аттаке)'
					break;
				}
				case 22: {
					str = 'DECREASE_ATTACK_MIXIN(допюцвеличение к здоровью)'
					break;
				}
				case 23: {
					str = 'CAN_NOT_ATTACK(не может аттаковать)'
					break;
				}
				case 24: {
					str = 'REPLACE_ATTACK_HEALTH(меняет местами аттаку и здоровье)'
					break;
				}
				case 25: {
					str = 'SALE(скидка на карту)'
					break;
				}
				case 26: {
					str = 'INCREASE_SPELL(увеличение силы магии)'
					break;
				}
				case 27: {
					str = 'DECREASE_SPELL(уменьшение силы магии)'
					break;
				}
				case 28: {
					str = 'SPELL_INVISIBLE(не доступен для аттак магией)'
					break;
				}
				case 29: {
					str = 'MASSIVE_ATTACK(массовая аттака)'
					break;
				}
				case 30: {
					str = 'INCREASE_ATTACK_AND_HEALTH(увеличение аттаки и здоровья)'
					break;
				}
				case 31: {
					str = 'INCREASE_HEALTH_MIXIN(доп.увеличение к здоровью)'
					break;
				}
				case 32: {
					str = 'DECREASE_HEALTH_MIXIN(доп.уменьщение к здоровью)'
					break;
				}
				case 33: {
					str = 'ENTICE_UNIT:(переманивание юнита)'
					break;
				}
				case 34: {
					str = 'NEW_SPELL(новая карта магии)'
					break;
				}
				case 35: {
					str = 'COPY_UNIT(копирование юнита)'
					break;
				}
				case 36: {
					str = 'UNIT_CONVERTION(превращение юнита в другого)'
					break;
				}
				
				
			}
			return str;
		}
	}

}