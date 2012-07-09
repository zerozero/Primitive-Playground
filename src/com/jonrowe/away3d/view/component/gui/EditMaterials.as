package com.jonrowe.away3d.view.component.gui
{
	import away3d.materials.ColorMaterial;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class EditMaterials extends BaseGUI
	{
		private var gui :SimpleGUI;
		public var color :int = 0x6666cc;
		public var colorAlpha :Number = 0.8;
		public var bothsides :Boolean;
		
		public function EditMaterials()
		{
			super();
		}
		
		override public function createChildren():void{
			gui = new SimpleGUI(this, null, "o");
			
			gui.addGroup("whats this?");
			
			gui.addColour("color");
			gui.addToggle("bothsides",{label:"both sides"});
			gui.addSlider("colorAlpha",0.05,1,{label:"alpha", width:178});
			gui.addButton("Apply", {callback:onApplyColor});
			gui.show();
		}
		
		private function onApplyColor():void{
			
			meshGroup.applyMaterial( new ColorMaterial(color,colorAlpha));
			
			/*var mesh :Mesh = Mesh(meshGroup.object3D) ;
			if (!mesh)
				return;
			var mat :MaterialBase = mesh.material;
			var lights :Array = mat.lights;
			mesh.material = new ColorMaterial(color,colorAlpha);
			mesh.material.bothSides = bothsides;
			mesh.material.lights = lights;*/
		}
	}
}