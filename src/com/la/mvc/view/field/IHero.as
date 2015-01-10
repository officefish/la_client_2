/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.field {
public interface IHero extends IAttackAvailable {
    function hideHealth () :void;
    function showHealth () :void;
    function setType(value:int):void;
	function clone () :IHero;
   
}
}
