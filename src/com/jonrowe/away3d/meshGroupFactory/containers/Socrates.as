package com.jonrowe.away3d.meshGroupFactory.containers
{
	import away3d.entities.Mesh;
	import away3d.library.AssetLibrary;
	import away3d.materials.ColorMaterial;
	
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupFactoryError;

	public class Socrates extends MeshGroupContainer3D
	{
		
		
		public function Socrates()
		{
			super();
			
			appendLibraryAsset( "Character", 0xfc035f );
			appendLibraryAsset( "Sandals.001", 0xffff00 );
			appendLibraryAsset( "Sandals", 0xffff00 );
			appendLibraryAsset( "hair", 0xffffff );
			appendLibraryAsset( "beard", 0xffffff );
			appendLibraryAsset( "brows", 0xffffff );
			appendLibraryAsset( "Sphere", 0xffffff );
			appendLibraryAsset( "Sphere.001", 0xffffff );
			
		}
	}
}