package com.jonrowe.away3d.meshGroupFactory
{
	
	public class MeshGroupFactoryError extends Error
	{
		public static const INSTANTIATION_ON_NON_CONSTRUCTOR_ERROR :String = "instantiation attempted on non constructor, " +
																				"check the value in MeshGroupTypeMap";
		public static const ATTEMPTED_ACCESS_OF_UNAVAILABLE_MESH_ERROR :String = "attempted to access a mesh that is not present " +
																				"in the AssetLibrary. Check the mesh is being " +
																				"imported and that all mesh names correspond";
		
		function MeshGroupFactoryError(message:*=null, id:*=null):void{
			super(message, id);
		}
	}
}