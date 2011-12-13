package com.jonrowe.away3d.view.component
{
	import com.bit101.components.Accordion;
	import com.bit101.components.CheckBox;
	import com.bit101.components.VScrollBar;
	import com.bit101.components.Window;
	import com.jonrowe.away3d.model.data.PropertyVO;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import uk.co.soulwire.gui.SimpleGUI;
	import com.jonrowe.away3d.view.component.gui.CreatePrimitive;
	
	public class EditView extends Sprite
	{
		private var dictionary :Dictionary;
		private var editContainer :Sprite;
		private var scrollbar:VScrollBar;
		
		private var guiHeight : int = 957;
		private var windowHeight : int;
		
		public var createPrimitiveGUI :CreatePrimitive;
		
		public var backgroundColor :int = 0x000000;//colour for GUI background
		
		public var editGUI :EditGUI;
		
		
		public function EditView()
		{
			super();
			dictionary = new Dictionary();
		}
		
		
		public function createChildren():void{
			
			
		}
		
		
		
		public function createGUI(primitive :IPrimitive ):void{
			
			hideGUIs();
			
			if (dictionary[primitive]){
				editGUI = dictionary[primitive];
			}else{
				editGUI = new EditGUI(primitive);
				dictionary[primitive] = editGUI;
			}
			addChild(editGUI );
			resize();
		}
		
		public function resize():void{
			for each( editGUI in dictionary ){
				editGUI.setSize(158, stage.stageHeight - 2);
			}
		}

		/*		PRIVATE		*/
		
		private function hideGUIs():void{
			
			for each( editGUI in dictionary ){
				if (contains(editGUI))
					removeChild(editGUI);
			}
		}
	}
}