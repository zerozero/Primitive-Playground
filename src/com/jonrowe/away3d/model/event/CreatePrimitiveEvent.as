package com.jonrowe.away3d.model.event
{
	import com.jonrowe.away3d.meshGroupFactory.PrimitiveInit;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	
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