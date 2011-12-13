package com.jonrowe.away3d.view.event
{
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	
	import flash.events.Event;
	
	public class DuplicatePrimitiveEvent extends Event
	{
		public static const DUPLICATE :String = "duplicate_object";
		
		public var primitive :IPrimitive;
		
		public function DuplicatePrimitiveEvent(type:String, primitive :IPrimitive, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.primitive = primitive;
		}
		
		
	}
}