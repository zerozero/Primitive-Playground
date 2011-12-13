package com.jonrowe.away3d.productFactory
{
	import com.jonrowe.away3d.productFactory.primitives.*;
	import com.jonrowe.away3d.productFactory.interfaces.IProductTypeMap;

	public class ProductTypeMap implements IProductTypeMap
	{
		protected var map : Object;
		
		public function ProductTypeMap()
		{
			this.map = defaultMap();
		}

		public function getProductClass(productType:String):Class
		{
			return map[ productType ];
		}
		
		protected function defaultMap() : Object {
			var obj : Object = new Object();
			
			//scene
			/*obj[ ProductType.AXES ] = PrimitiveAxes;
			obj[ ProductType.TRIDENT ] = PrimitiveTrident;
			obj[ ProductType.TRANSFORM_WIDGET ] = PrimitiveTransformWidget;
			
			//wire
			obj[ ProductType.WIRE_SPHERE ] = PrimitiveWireSphere;
			obj[ ProductType.WIRE_CUBE ] = PrimitiveWireCube;
			obj[ ProductType.WIRE_PLANE ] = PrimitiveWirePlane;
			
			//solid
			obj[ ProductType.CAPSULE ] = PrimitiveCapsule;
			obj[ ProductType.CONE ] = PrimitiveCone;
			obj[ ProductType.CUBE ] = PrimitiveCube;
			obj[ ProductType.CYLINDER ] = PrimitiveCylinder;
			obj[ ProductType.SPHERE ] = PrimitiveSphere;
			obj[ ProductType.PLANE ] = PrimitivePlane;*/

			obj[ ProductType.PRIMITIVE ] = Primitive;
			
			
			return obj;
		}

	}
}