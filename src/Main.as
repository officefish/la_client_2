package 
{

import com.la.mvc.GameContext;
<<<<<<< HEAD
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import com.demonsters.debugger.MonsterDebugger;
import flash.display.Sprite;
import flash.events.MouseEvent;

=======
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
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

	
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
		
<<<<<<< HEAD
		private function onMouseDown (event:MouseEvent) :void {
			MonsterDebugger.trace (event.target, 'down');
			if (event.target.parent) {
				MonsterDebugger.trace (event.target.parent, 'down_parent');
			}
			if (event.target.parent.parent) {
				MonsterDebugger.trace (event.target.parent.parent, 'down_parent_parent');
			}
		}
		
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

<<<<<<< HEAD
			MonsterDebugger.initialize (this);
			//MonsterDebugger.trace(this, "Hello World!");
			
            context = new GameContext(this);
			
			//this.stage.addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown)

		}

        
=======
            LocalCollection.getInstance().simulateCollection();
            SpellCollection.getInstance().simulateCollection();

            context = new GameContext(this);

            addChild(TrajectoryContainer.getInstance());

            /*
            Logger.setStage(stage);

            //var connection:Connection = new Connection();




            _lobby = new Lobby(800, 580);
            _lobby.addEventListener(Lobby.NEW_GAME, onNewGame);
            _lobby.addEventListener(Lobby.LOUNCH_GAME, onLounchGame);
            _lobby.addEventListener(Lobby.OPEN_COLLECTION, onOpenCollection);
           addChild(_lobby);

            collection = new Collection();
            collection.generateCollection(35);

            collectionView = new CollectionView();
            collectionView.addEventListener(CollectionView.READY, onCollectionReady);
            //addChildAt(collectionView,0);
            collectionView.placeCollection(collection.getCollection())
			
			Popup.getInstance().setStage (stage);
			

			*/


		}

        /*

        private function onCollectionReady (event:Event) :void {
            collection.setCollection(collectionView.getCollection())
            removeChild(collectionView);
            restartLobby();
        }

        private function restartLobby () :void {
            _lobby.removeEventListener(Intro.NEW_GAME, onNewGame);
            _lobby.removeEventListener(Intro.LOUNCH_GAME, onLounchGame);
            _lobby.removeEventListener(Intro.OPEN_COLLECTION, onOpenCollection);
            _lobby.destroy();
            _lobby = null;

            _lobby = new Intro(800, 580);
            _lobby.addEventListener(Intro.NEW_GAME, onNewGame);
            _lobby.addEventListener(Intro.LOUNCH_GAME, onLounchGame);
            _lobby.addEventListener(Intro.OPEN_COLLECTION, onOpenCollection);
            addChild(_lobby);
        }

        private function onNewGame (event:Event) :void {
            game = new Game (stage.stageWidth, stage.stageHeight);
            game.addEventListener (GameEvent.END_GAME, endGame);
            addChildAt (game, 0);
        }

        private function onLounchGame (event:Event) :void {
            game.lounch (collection.getCollection());
        }

        private function onOpenCollection (event:Event) :void {
            addChildAt(collectionView,0);
        }
		
		private function endGame (event:GameEvent) :void {
            game.removeEventListener(GameEvent.END_GAME, endGame);
            game.destroy();
            removeChild(game);
            restartLobby();
        }
        */
		
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
		
	}
	
}