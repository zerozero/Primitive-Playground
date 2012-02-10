package com.jonrowe.away3d.meshGroupFactory.containers
{
	import away3d.primitives.*;
	
	public class Primitive extends MeshGroupContainer3D
	{
		public static const PRIMITIVES:Object = {
			Capsule:Capsule,
			Cone:Cone,
			Cube:Cube,
			Sphere:Sphere,
			Plane:Plane,
			Cylinder:Cylinder
		}
		
		public function Primitive()
		{
			super();
		}
		
		
		override public function set type( val:String ):void{
			super.type = val;
			var clss :Class = PRIMITIVES[val];
			appendMesh( new clss(MeshGroupContainer3D.DEFAULT_MATERIAL));
		}
		
		public static function hasType( val:String ):Boolean{
			return PRIMITIVES[val] != null;
		}
		
	}
}