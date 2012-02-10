package com.jonrowe.away3d.services.event
{
	import com.jonrowe.away3d.meshGroupFactory.PrimitiveInit;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	
	import flash.events.Event;
	
	public class SocketServiceEvent extends Event
	{
		public static const NEW_MEMBER :String = "new member";
		public static const OBJECT_CREATED :String = "object created";
		
		public var data :Object;
		
		public function SocketServiceEvent(type:String, data :Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		
	}
}