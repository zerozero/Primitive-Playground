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
		private var editPosition  :EditPosition;
		private var editRotation :EditRotation;
		private var editScale :EditScale;
		private var editMaterials :EditMaterials;
		private var meshGroup :IMeshGroupContainer3D;
		
		public function EditGUI()
		{
			super();
			createChildren();
		}
		
		public function setSize( w:uint, h:uint ):void{
			accordion.setSize(w,h);
		}
		
		public function set activeMeshGroup( meshGroup :IMeshGroupContainer3D ):void{
			this.meshGroup = meshGroup;
			editPosition.meshGroup = meshGroup;
			editRotation.meshGroup = meshGroup;
			editScale.meshGroup = meshGroup;
			editMaterials.meshGroup = meshGroup;
		}
		
		private function createChildren():void{
			
			accordion = new EditPrimitiveAccordion(this);
			accordion.addSection("Create", new CreatePrimitive(),false);
			
			editPosition = new EditPosition();
			accordion.addSection("Position", editPosition);
			editRotation = new EditRotation();
			accordion.addSection("Rotation", editRotation);
			editScale = new EditScale();
			accordion.addSection("Scale", editScale);
			editMaterials = new EditMaterials();
			accordion.addSection("Materials", editMaterials);
			
			
		}
	
		
	}
}