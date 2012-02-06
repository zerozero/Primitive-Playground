package com.jonrowe.away3d.view.component.gui
{
	import flash.display.Sprite;
	
	public class BaseGUI extends Sprite
	{
		
		private var _hasInitialised :Boolean = false;
		
		
		public function BaseGUI()
		{
			super();
		}
		
		
		public function get hasInitialized():Boolean{
			return _hasInitialised;
		}
		
		public function set hasInitialized(trueOrFalse:Boolean):void{
			_hasInitialised = trueOrFalse;
		}
	}
}