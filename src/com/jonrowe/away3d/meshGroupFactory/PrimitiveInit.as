package com.jonrowe.away3d.meshGroupFactory
{
	import away3d.materials.MaterialBase;

	public class PrimitiveInit
	{
		public var primitiveClass :Class;
		public var material :MaterialBase;
		public var options :Object;
		public var name :String;
		public var type :String;
		
		public function PrimitiveInit( type :String, name:String, primitiveClass :Class, material :MaterialBase, options :Object ){
			this.primitiveClass = primitiveClass;
			this.material = material;
			this.options = options;
			this.name = name;
			this.type = type;
		}
	}
}