package com.la.mvc.view.debug 
{
	import com.junkbyte.console.Cc;
	import com.junkbyte.console.ConsoleChannel;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import com.demonsters.debugger.MonsterDebugger;

	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Console 
	{
		protected var ch:ConsoleChannel = new ConsoleChannel ("App");
		private var contextView:Sprite;
		

		
		public function Console() 
		{
			Cc.config.style.backgroundColor = 0x444444;
			Cc.config.style.backgroundAlpha = 0.9;
			
			Cc.commandLine = true; // enable command line
			Cc.memoryMonitor = false;
			Cc.fpsMonitor = false;
			Cc.displayRoller = false;
			
			Cc.config.commandLineAllowed = true;
			Cc.config.showTimestamp = true;
			//Cc.config.timeStampFormatter = timeStampFormatter;
			
			Cc.width = 450;
			Cc.height = 300;
			Cc.remoting = false;
			Cc.visible = true//CONFIG::debug;
		}
		
		public function setContextView (sprite:Sprite) :void {
			this.contextView = sprite;
			Cc.startOnStage(contextView, "debugger"); 
		}
		
		public function info (msg:String) :void {
			ch.info (msg);
		}
		
		public function warn (msg:String) :void {
			ch.warn (msg);
		}
		
		public function error (msg:String) :void {
			ch.error (msg);
		}
		
		public function debug (msg:String, target:Object = null) :void {
			MonsterDebugger.trace (target, 'console: ' + msg);
			ch.debug(msg);
			Cc.debug(msg);
			 
		}
		
		public function debugData (data:Object) :void {
			MonsterDebugger.trace (null, data);
		}
	}

}