package com.jonrowe.away3d.view.component
{
	import com.bit101.components.Accordion;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class EditPrimitiveAccordion extends Accordion
	{
		public function EditPrimitiveAccordion(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		/**
		 * Initializes the component.
		 */
		protected override function init():void
		{
			super.init();
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		protected override function addChildren() : void
		{
			_windows = new Array();
			_vbox = new VBox(this);
			_vbox.spacing = 0;
		}
		
		
		public function addSection( title :String, sprite :Sprite, minimized :Boolean = true ):void{
		
			var window:Window = new Window(_vbox, 0, 0, title);
			window.addChild(sprite);
			window.grips.visible = false;
			window.draggable = false;
			window.addEventListener(Event.SELECT, onWindowSelect);
			window.shadow = false;
			window.minimized = false;
			window.minimized = minimized;
			
			_windows.push(window);
			//setSize(158, sprite.height+window.height);
		}
	}
}