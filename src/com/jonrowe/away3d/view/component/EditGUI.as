package com.jonrowe.away3d.view.component
{
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.view.component.gui.CreatePrimitive;
	import com.jonrowe.away3d.view.component.gui.EditMaterials;
	import com.jonrowe.away3d.view.component.gui.EditPosition;
	import com.jonrowe.away3d.view.component.gui.EditRotation;
	import com.jonrowe.away3d.view.component.gui.EditScale;
	
	import flash.display.Sprite;
	
	public class EditGUI extends Sprite
	{
		
		private var accordion :EditPrimitiveAccordion;
		public var primitive :IMeshGroupContainer3D;
		
		public function EditGUI(primitive :IMeshGroupContainer3D)
		{
			super();
			this.primitive = primitive;
			createChildren();
		}
		
		public function setSize( w:uint, h:uint ):void{
			accordion.setSize(w,h);
		}
		
		private function createChildren():void{
			
			accordion = new EditPrimitiveAccordion(this);
			accordion.addSection("Create", new CreatePrimitive(),false);
			accordion.addSection("Position", new EditPosition(primitive));
			accordion.addSection("Rotation", new EditRotation(primitive));
			accordion.addSection("Scale", new EditScale(primitive));
			accordion.addSection("Materials", new EditMaterials(primitive));
			
			
		}
	
		
	}
}