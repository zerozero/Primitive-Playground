package com.jonrowe.away3d.view.event
{
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	
	import flash.events.Event;
	
	public class DisplayPrimitiveEvent extends Event
	{
		public static const DISPLAY :String = "display_primitive";
		public static const REMOVE :String = "remove_primitive";
		
		public var primitive :IPrimitive;
		
		public function DisplayPrimitiveEvent(type:String, primitive :IPrimitive, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.primitive = primitive;
		}
		
		
	}
}