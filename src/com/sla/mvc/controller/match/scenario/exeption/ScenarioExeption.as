package com.sla.mvc.controller.match.scenario.exeption 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioExeption 
	{
		public static const PROVOCATION:int = 0;
		public static const SPELL_INVISIBLE:int = 1;
		public static function getWarning (index:int) :String {
			var warning:String = ''
			switch (index) {
				case PROVOCATION: {
					warning = 'You shound attack Defender first!'
					break;
				}
				case SPELL_INVISIBLE: {
					warning = 'This target is spell invisible!'
					break;
				}
			}
			return warning;
		}
	}
	
	

}