package com.jonrowe.away3d.view.event
{
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	
	import flash.events.Event;
	
	public class EntityEvent extends Event
	{
		public static const ENTITY_SELECT :String = "entity_select";
		public static const START_DRAG :String = "entity_start_drag";
		public static const END_DRAG :String = "entity_end_drag";
		
		public var primitive :IMeshGroupContainer3D;
		
		public function EntityEvent(type:String, primitive :IMeshGroupContainer3D, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.primitive = primitive;
		}
		
		
	}
}