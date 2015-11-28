package com.sla.mvc.controller.init 
{
	import com.sla.event.LAContextEvent;
	import com.sla.mvc.model.RootModel;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitModelCommand extends StarlingCommand 
	{
		[Inject]
		public var rootModel:RootModel; 
				
		override public function execute():void 
		{
			super.execute();
			
			MonsterDebugger.log ("InitModelCommand::execute()");
			//var flashVars:Object = contextView.stage.loaderInfo.parameters; 
			//if (flashVars["userId"]) {
				//rootModel.username = flashVars["username"];
			//	rootModel.userId = flashVars["userId"];
			//} else {
				MonsterDebugger.log('пользователь не установлен')
				rootModel.nickname = 'admin' + Math.round(Math.random() * 1000);
				rootModel.userId = 1;
			//}
			
			dispatch(new LAContextEvent(LAContextEvent.MODEL_INIT));
		}		
	}

}