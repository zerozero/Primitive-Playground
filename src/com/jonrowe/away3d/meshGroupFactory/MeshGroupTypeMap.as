package com.jonrowe.away3d.meshGroupFactory
{
	import com.jonrowe.away3d.meshGroupFactory.containers.*;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupTypeMap;

	public class MeshGroupTypeMap implements IMeshGroupTypeMap
	{
		protected var map : Object;
		
		public function MeshGroupTypeMap()
		{
			this.map = defaultMap();
		}

		public function getProductClass(productType:String):Class
		{
			return map[ productType ];
		}
		
		protected function defaultMap() : Object {
			var obj : Object = new Object();

			obj[ MeshGroupType.SOCRATES ] = Socrates;
			obj[ MeshGroupType.PRIMITIVE ] = Primitive;
			
			return obj;
		}

	}
}