package com.jonrowe.away3d.view.component.gui
{
	import com.bit101.components.InputText;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	
	import flash.display.Sprite;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class EditScale extends Sprite
	{
		public var primitive :IMeshGroupContainer3D;
		
		private var gui :SimpleGUI;
		private var rotateToParams :InputText;
		private var lookAtParams :InputText;
		private var movePivotParams :InputText;
		
		private static const MAX_WIDTH : int = 126;
		
		public function EditScale(primitive :IMeshGroupContainer3D)
		{
			super();
			this.primitive = primitive;
			createChildren();
		}
		
		
		private function createChildren():void{
			
			gui = new SimpleGUI(this, null, "o");
			//fixed an issue with Numeric Stepper that was causing this panel to be drawn incorrectly
			//added call to super.draw() to force invalidation
			gui.addStepper("primitive.scaleX", 0.1, 10,{label:"scale x", step:0.1, width:MAX_WIDTH - 26});
			gui.addStepper("primitive.scaleY", 0.1, 10,{label:"scale y", step:0.1, width:MAX_WIDTH - 26});
			gui.addStepper("primitive.scaleZ", 0.1, 10,{label:"scale z", step:0.1, width:MAX_WIDTH - 26});
			
			gui.show();
		}
		
		
		
		
	}
}