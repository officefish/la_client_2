package com.sla.mvc.controller.match.scenario.exeption 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioExeption 
	{
		public static const PROVOCATION:int = 0;
		public static function getWarning (index:int) :String {
			var warning:String = ''
			switch (index) {
				case PROVOCATION: {
					warning = 'You shound attack Defender first!'
				}
			}
			return warning;
		}
	}
	
	

}