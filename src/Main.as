package 
{

import com.la.mvc.GameContext;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import com.demonsters.debugger.MonsterDebugger;
import flash.display.Sprite;
import flash.events.MouseEvent;

import com.log.Logger;
import com.ps.collection.Collection;
import com.ps.collection.view.CollectionView;
import com.ps.collection.LocalCollection;
import com.ps.collection.SpellCollection;
import com.ps.connection.Connection;
import com.ps.game.Game;
	import com.ps.game.GameEvent;
import com.ps.intro.Intro;
import com.ps.popup.Popup;
	import com.ps.trajectory.TrajectoryContainer;
	import flash.display.Sprite;
    import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

	
	/**
	 * ...
	 * @author 
	 */
    [SWF(frameRate = 60, width="800", height="600", backgroundColor="#555555")]
    public class Main extends Sprite
	{
		//private var card:Card
		//private var game:Game;
        //private var _lobby:Intro;
        //private var collectionView:CollectionView;

       // private var collection:Collection;

        private var context:GameContext;

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
			//MonsterDebugger.trace(this, "Hello World!");
			
            context = new GameContext(this);
			
			//this.stage.addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown)

		}

        

	}

	
}