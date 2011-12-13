package com.jonrowe.away3d.view.event
{
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	
	import flash.events.Event;
	
	public class EntitySelectEvent extends Event
	{
		public static const ENTITY_SELECT :String = "entity_select";
		
		public var primitive :IPrimitive;
		
		public function EntitySelectEvent(type:String, primitive :IPrimitive, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.primitive = primitive;
		}
		
		
	}
}