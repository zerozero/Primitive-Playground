package com.jonrowe.away3d.meshGroupFactory.containers.component
{
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.extrusions.LatheExtrude;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	import away3d.primitives.Cube;
	
	import flash.geom.Vector3D;
	
	public class Arrow3D extends Mesh
	{
		public function Arrow3D(color :int, length:Number = 1000, showLetters:Boolean = true)
		{
			super();
			buildArrow(color,length,showLetters);
		}
		
		private function buildArrow(color :int, length:Number, showLetters:Boolean):void
		{
			var base:Number = length*.9;
			var rad:Number = 2.4;
			var dRad:Number = rad*3;
			var offset:Number = length*.025;
			
			var matX:ColorMaterial = new ColorMaterial(color);
			
			var profileX:Vector.<Vector3D> = new Vector.<Vector3D>();
			profileX[0] = new Vector3D(length, 0 , 0);
			profileX[1] = new Vector3D(base, 0, offset);
			profileX[2] = new Vector3D(base, 0, -rad);
			
			var arrowX:LatheExtrude = new LatheExtrude(matX, profileX, LatheExtrude.X_AXIS, 1, 10);
			
			this.addChild( arrowX );
			
			
		}
	}
}