package com.jonrowe.away3d.view.event
{
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	
	import flash.events.Event;
	
	public class EntityEvent extends Event
	{
		public static const ENTITY_SELECT :String = "entity_select";
		public static const START_DRAG :String = "entity_start_drag";
		public static const END_DRAG :String = "entity_end_drag";
		
		public var primitive :IPrimitive;
		
		public function EntityEvent(type:String, primitive :IPrimitive, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.primitive = primitive;
		}
		
		
	}
}