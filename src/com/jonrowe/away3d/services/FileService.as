package com.jonrowe.away3d.services
{
	import away3d.entities.Mesh;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.loaders.parsers.Max3DSParser;
	import away3d.materials.ColorMaterial;
	
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.services.event.Loader3DEvent;
	
	import org.robotlegs.mvcs.Actor;

	public class FileService extends Actor implements IFileService
	{
		private static const DEFAULT_MATERIAL :ColorMaterial = new ColorMaterial( 0x3366cc, 1 );
		
		[Embed(source="meshes/idle7.2.3ds", mimeType="application/octet-stream")]
		private var Socrates:Class;
		
		private var loader:Loader3D;
		
		public function FileService()
		{
		}
		
		
		private var _loadedMesh:Mesh;
		public function get loadedMesh():Mesh{
			return _loadedMesh;
		}
		
		public function loadMesh():void{
			Loader3D.enableParser(Max3DSParser);
			loader = new Loader3D();
			loader.parseData(Socrates, null, new AssetLoaderContext(false));
			for (var i:int = 0; i < loader.numChildren; i++)
			{
				var mesh:Mesh = Mesh(loader.getChildAt(i));
				mesh.scale(20);
				mesh.material = DEFAULT_MATERIAL;
			}
			loader.scale(0.6);
			_loadedMesh = mesh;
			
			var primitive :IPrimitive = new Primitive() as IPrimitive;
			primitive.init("imported", loader);
			
			dispatch( new Loader3DEvent( Loader3DEvent.DISPLAY, primitive ));
		}
	}
}