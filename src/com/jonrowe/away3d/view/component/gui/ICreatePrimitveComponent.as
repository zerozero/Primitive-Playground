package com.jonrowe.away3d.view.component.gui
{
	public interface ICreatePrimitveComponent extends IGUIComponent
	{
		function getName():String;
		function initialize(primitives:Object):void;
		function createChildren():void;
		function get selected():Object;
		function set selected(obj:Object):void;
	}
}