/**
 * Created by root on 11/6/14.
 */
package com.la.mvc.model {
import com.greensock.plugins.Positions2DPlugin;
import flash.display.DisplayObject;
import flash.geom.Point;
import flash.utils.Timer;

import org.robotlegs.mvcs.Actor;

public class MatchModel extends Actor {

    private var _matchId:int;
    private var _mode:int;

    private var _preflopEndFlag:Boolean = false;

    private var _playerHero:int;
    private var _opponentHero:int;

    private var _playerHeroHealth:int;
    private var _opponentHeroHealth:int;
	
	private var scenario:Array;
	
	private var attackUnit:DisplayObject;
	private var attackUnitPosition:Point;
	
	private var _whiteFlag:Boolean;
	
	private var _selectListener:Function;
	
	private var _previewTimer:Timer;
	private var _timerCallback:Function;

    public function MatchModel() {
    }

    public function set matchId (value:int) :void {
        _matchId = value;
    }

    public function get matchId () :int {
        return _matchId;
    }

    public function set mode (value:int) :void {
        _mode = value;
    }

    public function get mode () :int {
        return _mode;
    }

    public function set preflopEndFlag (value:Boolean) :void {
        _preflopEndFlag = value;
    }

    public function get preflopEndFlag () :Boolean {
        return _preflopEndFlag;
    }

    public function set playerHero (value:int) :void {
        _playerHero = value;
    }

    public function get playerHero () :int {
        return _playerHero;
    }

    public function set opponentHero (value:int) :void {
        _opponentHero = value;
    }

    public function get opponentHero () :int {
        return _opponentHero;
    }

    public function set playerHeroHealth (value:int) :void {
        _playerHeroHealth = value;
    }

    public function get playerHeroHealth () :int {
        return _playerHeroHealth;
    }

    public function set opponentHeroHealth (value:int) :void {
        _opponentHeroHealth = value;
    }

    public function get opponentHeroHealth () :int {
        return _opponentHeroHealth;
    }
	
	public function setScenario (scenario:Array) :void {
		this.scenario = scenario;
	}
	
	public function concatScenario (scenario:Array) :void {
		this.scenario = this.scenario.concat(scenario);
	}
	
	public function get scenarioLength () :int {
		if (scenario) {
			return scenario.length;
		} else {
			return 0;
		}
		
	}
	
	public function getScenarioAction () :Object {
		return scenario.shift();
	}
	
	public function setAttackUnit (value:DisplayObject) :void {
		this.attackUnit = value;
	}
	
	public function getAttackUnit () :DisplayObject {
		return attackUnit;
	}
	
	public function setAttackUnitPosition (value:Point) :void {
		this.attackUnitPosition = value;
	}
	public function getAttackUnitPosition () :Point {
		return attackUnitPosition;
	}
	
	public function set whiteFlag (value:Boolean) :void {
		this._whiteFlag = value;
	}
	
	public function get whiteFlag () :Boolean {
		return _whiteFlag;
	}
	
	public function set selectListener (func:Function) :void {
		this._selectListener = func; 
	}
	public function get selectListener () :Function {
		return _selectListener;
	}
	
	public function set previewTimer (timer:Timer) :void {
		_previewTimer = timer;
	}
	
	public function get previewTimer () :Timer {
		return _previewTimer;
	}
	
	public function set timerCallback (value:Function) :void {
		_timerCallback = value;
	}
	
	public function get timerCallback () :Function {
		return _timerCallback;
	}

}
}
