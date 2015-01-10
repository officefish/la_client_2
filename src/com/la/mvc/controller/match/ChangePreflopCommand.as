/**
 * Created by root on 11/9/14.
 */
package com.la.mvc.controller.match {
import com.la.event.MatchServiceEvent;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.scene.IScene;
import com.la.state.GameState;
import com.la.mvc.model.CardData;
import org.robotlegs.mvcs.Command;

public class ChangePreflopCommand extends Command {

    [Inject]
    public var event:MatchServiceEvent;

    [Inject (name='scene')]
    public var scene:IScene;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    override public function execute():void {
        rootModel.currentState = GameState.PREFLOP_SELECT;
        
        var cardDatas:Vector.<CardData> = getCardDataVector(event.getData().preflop);
        scene.replacePreflopCards(cardDatas);

    }

    private function getCardDataVector (data:Array) :Vector.<CardData> {
        var vector:Vector.<CardData> = new Vector.<CardData>();
		var cardData:CardData
        for (var i:int = 0; i < data.length; i ++) {
            cardData = CardData.converToData (data[i])
            vector.push(cardData)
        }
        return vector;
    }
}
}