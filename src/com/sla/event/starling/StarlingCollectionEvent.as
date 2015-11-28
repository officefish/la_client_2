package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingCollectionEvent extends Event 
	{
		
		public static const EDIT:String = 'editDeckinCollection';
		public static const REMOVE:String = 'removeDeckinCollection';
		public static const PREVIEW:String = 'previewCollectionCard';
		public static const SAVE:String = 'saveDeckInCollection';
		public static const CLOSE:String = 'sCloseCollection';
		public static const NEW_DECK:String = 'sNewDeck';
		public static const HERO_DELECT:String = 'heroSelect';
		public static const CRAFT:String = 'craft';
		public static const CRAFT_READY:String = 'craftReady';
		public static const SAVE_ABILITIES:String = 'saveAbilities';
		public static const CRAFT_ABILITIES:String = 'craftAbilities';
		public static const CRAFT_ABILITIES_READY:String = 'craftAbilitiesReady';
		
		
		public function StarlingCollectionEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}