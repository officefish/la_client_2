package com.la.mvc.controller.collection 
{
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.collection.ICollection;
	import com.la.mvc.view.IIntro;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CloseCollectionCommand extends Command 
	{
		
		[Inject (name='collection')]
		public var collection:ICollection; 
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject] 
		public var intro:IIntro;
		
		override public function execute():void 
		{
			rootModel.currentState = GameState.INTRO;
			contextView.removeChild (collection as DisplayObject);
			intro.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(intro as DisplayObject); 
		}
		
	}

}