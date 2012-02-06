package com.jonrowe.away3d.model.event
{
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	
	import flash.events.Event;
	
	public class CreatePrimitiveEvent extends Event
	{
		public static const CREATE :String = "createPrimitive";
		
		public var init :PrimitiveInit;
		
		public function CreatePrimitiveEvent(type:String, init: PrimitiveInit, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.init = init;
		}
		
		
	}
}