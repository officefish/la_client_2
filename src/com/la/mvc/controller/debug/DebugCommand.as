package com.la.mvc.controller.debug 
{
	import com.la.event.ConsoleEvent;
	import flash.display.Sprite;
	import org.robotlegs.mvcs.Command;
	import com.demonsters.debugger.MonsterDebugger;
	import com.la.mvc.view.debug.Console;


	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DebugCommand extends Command 
	{
		[Inject (name='appConsole')]
		public var console:Console;
		
		[Inject]
		public var event:ConsoleEvent;
		
	
		override public function execute():void {
			console.setContextView(contextView as Sprite);
			console.debug(event.msg, event.initiator);
		}

	}

}