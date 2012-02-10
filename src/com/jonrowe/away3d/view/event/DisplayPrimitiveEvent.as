package com.jonrowe.away3d.view.event
{
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	
	import flash.events.Event;
	
	public class DisplayPrimitiveEvent extends Event
	{
		public static const DISPLAY :String = "display_primitive";
		public static const REMOVE :String = "remove_primitive";
		
		public var primitive :IMeshGroupContainer3D;
		
		public function DisplayPrimitiveEvent(type:String, primitive :IMeshGroupContainer3D, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.primitive = primitive;
		}
		
		
	}
}