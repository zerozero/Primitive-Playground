package com.jonrowe.away3d.services.event
{
	import away3d.loaders.Loader3D;
	
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	
	import flash.events.Event;
	
	public class Loader3DEvent extends Event
	{
		public static const DISPLAY :String = "displayLoader3D";
		
		public var data :IPrimitive;
		
		public function Loader3DEvent(type:String, data :IPrimitive, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		
	}
}