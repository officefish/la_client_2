package 
{

import com.la.mvc.GameContext;
import com.sla.LastArgumentGame;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import com.demonsters.debugger.MonsterDebugger;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.system.Security;

import com.log.Logger;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import starling.core.Starling;
import org.robotlegs.mvcs.StarlingContext;

	
	/**
	 * ...
	 * @author 
	 */
    [SWF(frameRate = 60, width="800", height="600", backgroundColor="#0")]
    public class Main extends Sprite
	{
		//private var context:GameContext;
		private var _starling:Starling;
        private var _starlingContext:StarlingContext; 


		public function Main():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;


			MonsterDebugger.initialize (this);
			
			// new client with starling now alive!!!
			_starling = new Starling(LastArgumentGame, stage);
			_starling.antiAliasing = 2;
			stage.quality = StageQuality.HIGH;
			_starling.start();
			
			
			
			//MonsterDebugger.trace(this, "Hello World!");
			
			//Security.allowDomain("*"); 
			//Security.loadPolicyFile("http://127.0.0.1:8000/crossdomain.xml")
			//Security.loadPolicyFile("xmlsocket://127.0.0.1:8000")
			
            //context = new GameContext(this);
			
			//this.stage.addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown)

		}

        

	}

	
}