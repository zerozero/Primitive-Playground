package com.jonrowe.away3d.view.component.gui
{
	import away3d.primitives.*;
	
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class CreatePrimitive extends Sprite
	{
		
		public static const MAKE :String = "makePrimitive";
		public static const DUPLICATE :String = "duplicatePrimitive";
		public static const DELETE :String = "deletePrimitive";
		
		private var gui :SimpleGUI;
		
		public var _selected :Object;
		public var primitives :Array = [
			
			{label:"Capsule",data:new PrimitiveInit(Capsule,PrimitiveObjectBase.DEFAULT_MATERIAL ,{})},	
			{label:"Cone",data:new PrimitiveInit(Cone,PrimitiveObjectBase.DEFAULT_MATERIAL ,{})},	
			{label:"Cube",data:new PrimitiveInit(Cube,PrimitiveObjectBase.DEFAULT_MATERIAL ,{})},	
			{label:"Sphere",data:new PrimitiveInit(Sphere,PrimitiveObjectBase.DEFAULT_MATERIAL ,{})},	
			{label:"Plane",data:new PrimitiveInit(Plane,PrimitiveObjectBase.DEFAULT_MATERIAL ,{})},	
			{label:"Cylinder",data:new PrimitiveInit(Cylinder,PrimitiveObjectBase.DEFAULT_MATERIAL ,{})}	
			
		];
		
		
		public function CreatePrimitive()
		{
			super();
			createChildren();
		}
		
		public function set selected(obj:Object):void{
			_selected = obj;
		}
		
		public function get selected():Object{
			return _selected;
		}
		
		public function createChildren():void{
			
			//top level gui - object select and make
			gui = new SimpleGUI(this,"PRIMITIVE PLAYGROUND","P");
			gui.addGroup("Add");
			gui.addComboBox("selected",primitives,{label:"Primitive:"});
			gui.addButton("Make", {callback:onMake});
			gui.addButton("Duplicate", {callback:onDuplicate});
			gui.addButton("Delete", {callback:onDelete});
			gui.show();
			
		}
	
		private function onDuplicate():void{
			dispatchEvent( new Event( DUPLICATE ));
		}
		
		private function onDelete():void{
			dispatchEvent( new Event( DELETE ));
		}
		
		
		private function onMake():void{
			dispatchEvent(new Event(MAKE));
			
		}
		
	}
}