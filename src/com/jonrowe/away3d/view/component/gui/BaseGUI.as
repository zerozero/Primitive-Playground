package com.jonrowe.away3d.view.component.gui
{
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	
	import flash.display.Sprite;
	
	public class BaseGUI extends Sprite
	{
		
		private var _hasInitialised :Boolean = false;
		
		protected var _meshGroup :IMeshGroupContainer3D;
		
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
		
		public function set meshGroup( meshGroup :IMeshGroupContainer3D ):void{
			_meshGroup = meshGroup;
			removeChildren();
			createChildren();
		}
		
		public function get meshGroup():IMeshGroupContainer3D{
			return _meshGroup;
		}
		
		public function createChildren():void{
			//override this
		}
	}
}