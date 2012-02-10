package com.jonrowe.away3d.view.event
{
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	
	import flash.events.Event;
	
	public class DuplicatePrimitiveEvent extends Event
	{
		public static const DUPLICATE :String = "duplicate_object";
		
		public var primitive :IMeshGroupContainer3D;
		
		public function DuplicatePrimitiveEvent(type:String, primitive :IMeshGroupContainer3D, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.primitive = primitive;
		}
		
		
	}
}