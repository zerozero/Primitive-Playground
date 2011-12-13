package com.jonrowe.away3d.productFactory
{
	import away3d.materials.MaterialBase;

	public class PrimitiveInit
	{
		public var primitiveClass :Class;
		public var material :MaterialBase;
		public var options :Object;
		
		public function PrimitiveInit( primitiveClass :Class, material :MaterialBase, options :Object ){
			this.primitiveClass = primitiveClass;
			this.material = material;
			this.options = options;
		}
	}
}