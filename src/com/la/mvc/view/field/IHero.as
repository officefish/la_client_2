/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
import com.la.mvc.view.IAttackAvailable;

public interface IHero extends IAttackAvailable {
    function hideHealth () :void;
    function showHealth () :void;
    function setType(value:int):void;
	function clone () :IHero;
	function clear():void;
   
}
}
