package com.jonrowe.away3d.view.component.gui
{
	import away3d.containers.ObjectContainer3D;
	
	import com.bit101.components.Component;
	import com.bit101.components.InputText;
	import com.bit101.components.RadioButton;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class EditPosition extends BaseGUI
	{
		
		public var plane :String = "XZ";
		
		private var gui :SimpleGUI;
		private var moveToParams :InputText;
		private var translateParams:InputText;
		private var translateDistance:InputText;
		
		private static const MAX_WIDTH : int = 126;
		
		public static const CHANGE_PLANE :String = "change_plane";
		public static const CHANGE_GLOBAL_LOCAL :String = "change_global_local";
		
		public function EditPosition()
		{
			super();
			
		}
		
		
		
		
		
		override public function createChildren():void{
			gui = new SimpleGUI(this, null, "o");
			
			//gui.addGroup("Position");
			gui.addStepper("meshGroup.x", int.MIN_VALUE, int.MAX_VALUE,{label:"x", step:10, width:MAX_WIDTH});
			gui.addStepper("meshGroup.y", int.MIN_VALUE, int.MAX_VALUE,{label:"y", step:10, width:MAX_WIDTH});
			gui.addStepper("meshGroup.z", int.MIN_VALUE, int.MAX_VALUE,{label:"z", step:10, width:MAX_WIDTH});
			
			gui.addStepper("moveForward", int.MIN_VALUE, int.MAX_VALUE,{label:"forward/back", step:10, width:MAX_WIDTH-54});
			gui.addStepper("moveLeft", int.MIN_VALUE, int.MAX_VALUE,{label:"left/right", step:10, width:MAX_WIDTH-35});
			gui.addStepper("moveUp", int.MIN_VALUE, int.MAX_VALUE,{label:"up/down", step:10, width:MAX_WIDTH-34});
			
			moveToParams = gui.addControl(InputText, {label:"move to x,y,z:", width:64}) as InputText;
			gui.addButton("Move", {callback:onMoveTo});
			
			translateParams = gui.addControl(InputText, {label:"trans axis x,y,z:", width:64}) as InputText;
			translateDistance = gui.addControl(InputText, {label:"trans distance:", width:64}) as InputText;
			gui.addButton("Translate", {callback:onTransform});
			
			gui.addLabel("Drag Plane:");
			var rb :Component = gui.addControl( RadioButton, {label:"XY", width:64}) as RadioButton;
			rb.addEventListener(MouseEvent.CLICK, onRBclick);
			
			rb = gui.addControl( RadioButton, {label:"XZ", width:64, selected:true }) as RadioButton;
			rb.addEventListener(MouseEvent.CLICK, onRBclick);

			rb = gui.addControl( RadioButton, {label:"ZY", width:64 }) as RadioButton;
			rb.addEventListener(MouseEvent.CLICK, onRBclick);
			
			gui.addToggle("useGlobalPlane",{label:"global/local",selected:false});
			
			dispatchEvent( new Event( CHANGE_PLANE ));
			gui.show();
		}
		
		private function onRBclick( e:MouseEvent ):void{
			plane = RadioButton(e.currentTarget).label;
			dispatchEvent( new Event( CHANGE_PLANE ));
		}
		
		
		private function onMoveTo():void{
			
			var componentValues :Array = moveToParams.text.split(",");
			if (componentValues.length == 3){
				ObjectContainer3D(meshGroup).moveTo(componentValues[0],componentValues[1],componentValues[2]);
			}
		}
		
		private function onTransform():void{
			
			var componentValues :Array = translateParams.text.split(",");
			var distance :Number = Number(translateDistance.text);
			if (componentValues.length == 3){ 
				ObjectContainer3D(meshGroup).translate(new Vector3D(componentValues[0],componentValues[1],componentValues[2]),distance);
			}
		}
		
		//FWD
		private var _useGlobalPlane :Boolean;
		public function set useGlobalPlane( trueOrFalse:Boolean ):void{
			_useGlobalPlane = trueOrFalse;
			dispatchEvent( new Event( CHANGE_GLOBAL_LOCAL ));
		}
		
		public function get useGlobalPlane():Boolean{
			return _useGlobalPlane;
		}
		
		private var _moveForward :Number = 0;
		public function set moveForward( amount :Number):void{
			var increment :Number = amount - _moveForward;
			_moveForward = amount;
			ObjectContainer3D(meshGroup).moveForward(increment);
		}
		
		public function get moveForward():Number{
			return _moveForward;
		}
		
		//BACK
		private var _moveBackward :Number = 0;
		public function set moveBackward( amount :Number):void{
			var increment :Number = amount - _moveBackward;
			_moveBackward = amount;
			ObjectContainer3D(meshGroup).moveBackward(increment);
		}
		
		public function get moveBackward():Number{
			return _moveBackward;
		}
		
		//LEFT
		private var _moveLeft :Number = 0;
		public function set moveLeft( amount :Number):void{
			var increment :Number = amount - _moveLeft;
			_moveLeft = amount;
			ObjectContainer3D(meshGroup).moveLeft(increment);
		}
		
		public function get moveLeft():Number{
			return _moveLeft;
		}
		
		//RIGHT
		private var _moveRight :Number = 0;
		public function set moveRight( amount :Number):void{
			var increment :Number = amount - _moveRight;
			_moveRight = amount;
			ObjectContainer3D(meshGroup).moveRight(increment);
		}
		
		public function get moveRight():Number{
			return _moveRight;
		}
		
		//UP
		private var _moveUp :Number = 0;
		public function set moveUp( amount :Number):void{
			var increment :Number = amount - _moveUp;
			_moveUp = amount;
			ObjectContainer3D(meshGroup).moveUp(increment);
		}
		
		public function get moveUp():Number{
			return _moveUp;
		}
		
		//DOWN
		private var _moveDown :Number = 0;
		public function set moveDown( amount :Number):void{
			var increment :Number = amount - _moveDown;
			_moveDown = amount;
			ObjectContainer3D(meshGroup).moveDown(increment);
		}
		
		public function get moveDown():Number{
			return _moveDown;
		}
		
		
	}
}