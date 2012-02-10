package com.jonrowe.away3d.view.component.gui
{
	import away3d.containers.ObjectContainer3D;
	
	import com.bit101.components.InputText;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class EditRotation extends Sprite
	{
		public var primitive :IMeshGroupContainer3D;
		
		private var gui :SimpleGUI;
		private var rotateToParams :InputText;
		private var lookAtParams :InputText;
		private var movePivotParams :InputText;
		
		private static const MAX_WIDTH : int = 126;
		
		public function EditRotation(primitive :IMeshGroupContainer3D)
		{
			super();
			this.primitive = primitive;
			createChildren();
		}
		
		
		private function createChildren():void{
			gui = new SimpleGUI(this, null, "o");
			
			gui.addStepper("primitive.rotationX", int.MIN_VALUE, int.MAX_VALUE,{label:"rotation x", step:5, width:MAX_WIDTH-38});
			gui.addStepper("primitive.rotationY", int.MIN_VALUE, int.MAX_VALUE,{label:"rotation y", step:5, width:MAX_WIDTH-38});
			gui.addStepper("primitive.rotationZ", int.MIN_VALUE, int.MAX_VALUE,{label:"rotation z", step:5, width:MAX_WIDTH-38});
			
			gui.addStepper("pitch", -180, 180,{label:"pitch", step:5, width:MAX_WIDTH-38});
			gui.addStepper("roll", -180, 180,{label:"roll", step:5, width:MAX_WIDTH-38});
			gui.addStepper("yaw", -180, 180,{label:"yaw", step:5, width:MAX_WIDTH-38});
			
			rotateToParams = gui.addControl(InputText, {label:"rotate to x,y,z:", width:64}) as InputText;
			gui.addButton("Rotate", {callback:onRotateTo});
			
			lookAtParams = gui.addControl(InputText, {label:"look at x,y,z:", width:64}) as InputText;
			gui.addButton("Look At", {callback:onLookAt});
			
			movePivotParams = gui.addControl(InputText, {label:"move pivot x,y,z:", width:64}) as InputText;
			gui.addButton("Move Pivot", {callback:onMovePivot});
			gui.show();
		}
		
		
		private function onRotateTo():void{
			
			var componentValues :Array = rotateToParams.text.split(",");
			if (componentValues.length == 3){
				ObjectContainer3D(primitive).rotateTo(componentValues[0],componentValues[1],componentValues[2]);
			}
		}
		
		private function onLookAt():void{
			
			var componentValues :Array = lookAtParams.text.split(",");
			if (componentValues.length == 3){
				ObjectContainer3D(primitive).lookAt(new Vector3D(componentValues[0],componentValues[1],componentValues[2]));
			}
		}
		
		private function onMovePivot():void{
			
			var componentValues :Array = movePivotParams.text.split(",");
			if (componentValues.length == 3){
				IMeshGroupContainer3D(primitive).pivotPoint = new Vector3D(componentValues[0],componentValues[1],componentValues[2]);
			}
		}
		
		//PITCH
		private var _pitch:Number = 0;
		public function set pitch( amount :Number):void{
			var increment :Number = amount - _pitch;
			_pitch= amount;
			ObjectContainer3D(primitive).pitch(increment);
		}
		
		public function get pitch():Number{
			return _pitch;
		}
		
		//ROLL
		private var _roll :Number = 0;
		public function set roll( amount :Number):void{
			var increment :Number = amount - _roll;
			_roll = amount;
			ObjectContainer3D(primitive).roll(increment);
		}
		
		public function get roll():Number{
			return _roll;
		}
		
		//YAW
		private var _yaw :Number = 0;
		public function set yaw( amount :Number):void{
			var increment :Number = amount - _yaw;
			_yaw = amount;
			ObjectContainer3D(primitive).yaw(increment);
		}
		
		public function get yaw():Number{
			return _yaw;
		}
		
	}
}