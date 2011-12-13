package com.jonrowe.away3d.view.component.gui
{
	import away3d.containers.ObjectContainer3D;
	import away3d.primitives.Plane;
	
	import com.bit101.components.InputText;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class EditScale extends Sprite
	{
		public var primitive :IPrimitive;
		
		private var gui :SimpleGUI;
		private var rotateToParams :InputText;
		private var lookAtParams :InputText;
		private var movePivotParams :InputText;
		
		private static const MAX_WIDTH : int = 126;
		
		public function EditScale(primitive :IPrimitive)
		{
			super();
			this.primitive = primitive;
			createChildren();
		}
		
		
		private function createChildren():void{
			gui = new SimpleGUI(this, null, "o");
			//fixed an issue with Numeric Stepper that was causing this panel to be drawn incorrectly
			//added call to super.draw() to force invalidation
			gui.addStepper("primitive.object3D.scaleX", 0.1, 10,{label:"scale x", step:0.1, width:MAX_WIDTH - 26});
			gui.addStepper("primitive.object3D.scaleY", 0.1, 10,{label:"scale y", step:0.1, width:MAX_WIDTH - 26});
			gui.addStepper("primitive.object3D.scaleZ", 0.1, 10,{label:"scale z", step:0.1, width:MAX_WIDTH - 26,enabled:!(primitive.object3D is Plane)});
			
			gui.show();
		}
		
		
		
		
	}
}