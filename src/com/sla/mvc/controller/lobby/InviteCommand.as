package com.sla.mvc.controller.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.LobbyEvent;
	import com.sla.mvc.model.HeroModel;
	import com.sla.mvc.service.LobbyService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InviteCommand extends StarlingCommand 
	{
		
		[Inject]
		public var service:LobbyService;

		[Inject]
		public var event:LobbyEvent;

		[Inject]
		public var heroModel:HeroModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log('InviteCommand::execute()');
			service.sendMessage('invite_to_game',
                {
            'unit':event.data.id,
            'hero_uid':heroModel.type,
            'level':heroModel.level,
            'mode':event.data.mode
            })
		}
		
	}

}