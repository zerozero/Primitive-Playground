package com.jonrowe.away3d.view.component
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.primitives.Plane;
	
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.Text;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import uk.co.soulwire.gui.SimpleGUI;
	import com.jonrowe.away3d.view.component.gui.CreatePrimitive;
	import com.jonrowe.away3d.view.component.gui.EditMaterials;
	import com.jonrowe.away3d.view.component.gui.EditPosition;
	import com.jonrowe.away3d.view.component.gui.EditRotation;
	import com.jonrowe.away3d.view.component.gui.EditScale;
	
	public class EditGUI extends Sprite
	{
		
		private var accordion :EditPrimitiveAccordion;
		public var primitive :IPrimitive;
		
		public function EditGUI(primitive :IPrimitive)
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