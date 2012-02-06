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
	
	public class CreatePrimitive extends BaseGUI implements ICreatePrimitveComponent
	{
		
		public static const MAKE :String = "makePrimitive";
		public static const DUPLICATE :String = "duplicatePrimitive";
		public static const DELETE :String = "deletePrimitive";
		
		private static const NAME :String = "CreatePrimitive";
		
		private var gui :SimpleGUI;
		private var dataProvider :Array = [];
		
		private var _selectedPrimitiveToCreate :Object;
		
		
		
		public function CreatePrimitive()
		{
			super();
		}
		
		public function set selected(obj:Object):void{
			_selectedPrimitiveToCreate = obj;
		}
		
		public function get selected():Object{
			return _selectedPrimitiveToCreate;
		}
		
		public function getName():String{
			return NAME;
		}
		
		public function initialize(primitives:Object):void{
			
			for (var obj :String in primitives)
				dataProvider.push({label:obj,data:obj});
			this.hasInitialized = true;
		}
		
		public function createChildren():void{
			
			//top level gui - object select and make
			gui = new SimpleGUI(this,"PP "+Main.VERSION_STRING,"P");
			gui.addGroup("Add");
			gui.addComboBox("selected",dataProvider,{label:"Primitive:"});
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