package com.jonrowe.away3d.services.event
{
	import away3d.loaders.Loader3D;
	
	import com.jonrowe.away3d.meshGroupFactory.PrimitiveInit;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	
	import flash.events.Event;
	
	public class Loader3DEvent extends Event
	{
		public static const LOADED :String = "loader3dloaded";
		
		public var data :IMeshGroupContainer3D;
		
		public function Loader3DEvent(type:String, data :IMeshGroupContainer3D, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		
	}
}