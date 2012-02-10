package com.jonrowe.away3d.meshGroupFactory.containers
{
	import away3d.containers.ObjectContainer3D;
	import away3d.debug.Trident;
	import away3d.entities.Entity;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.library.AssetLibrary;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupFactory;
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupFactoryError;
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupType;
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupTypeMap;
	import com.jonrowe.away3d.meshGroupFactory.PrimitiveInit;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class MeshGroupContainer3D extends ObjectContainer3D implements IMeshGroupContainer3D
	{
		private var _primitiveName :String;
		private var _type :String;
		private var _meshContainer:ObjectContainer3D = new ObjectContainer3D();
		private var _meshes:Vector.<Mesh> = new Vector.<Mesh>();
		
		protected var _selected :Boolean;
		protected var _scale :Number = 1;
		
		public var transformWidget :ObjectContainer3D;
		
		public var trident :Trident;
		
		public static const ENTITY_SELECT :String = 'entity_select';
		public static const START_DRAG :String = 'start_drag';
		public static const END_DRAG :String = 'end_drag';
		
		public static const DEFAULT_MATERIAL :ColorMaterial = new ColorMaterial( 0x6666cc, 0.8 );
		
		/*		CONSTRUCT		*/
		
		public function MeshGroupContainer3D()
		{
			
			trident = new Trident(100,true);
			addChild( meshContainer );
		}
		
		
		/*		STATIC		*/
		
		/**
		 * creates a new MeshGroupContainer3D of the specified type - will return a Primitive if the type corresponds to one of the known Primitive types 
		 * @param type
		 * @return 
		 * 
		 */		
		public static function create( type :String ):IMeshGroupContainer3D{
			
			var container :IMeshGroupContainer3D = new MeshGroupFactory( new MeshGroupTypeMap() ).getProduct( Primitive.hasType( type ) ? MeshGroupType.PRIMITIVE : type );
			container.type = type;
			return container;
		}
		
		
		/*		GET/SET		*/
		
		public function get meshes():Vector.<Mesh>{
			return _meshes;
		}
		
		public function set meshContainer( obj :ObjectContainer3D ):void{
			_meshContainer = obj;
		}
		
		public function get meshContainer():ObjectContainer3D{
			return _meshContainer;
		}
		
		public function set primitiveName( name :String ):void{
			_primitiveName = name;
		}
		
		public function get primitiveName( ):String{
			return _primitiveName;	
		}
		
		public function set type( name :String ):void{
			_type = name;
		}
		
		public function get type( ):String{
			return _type;	
		}
		
		public function set selected( trueOrFalse :Boolean):void{
			_selected = trueOrFalse;
			
			if (selected){
				selectChildren();
				addChild(trident);
				dispatchEvent( new Event(ENTITY_SELECT));
			}else{
				deselectChildren();
				if (contains( trident ))
					removeChild(trident);
			}
		}
		
		public function get selected( ):Boolean{
			return _selected;	
		}
		
		private function selectChildren():void{
			var mesh :Mesh ;
			for each (mesh in meshes){
				mesh.showBounds = true;
			}
		}
		
		private function deselectChildren():void{
			var mesh :Mesh ;
			for each (mesh in meshes){
				mesh.showBounds = false;
			}
		}
		
		/*		IMPLEMENT		*/
		
		protected function appendLibraryAsset( name:String, color :int ):void{
			var mesh :Mesh;
			mesh = AssetLibrary.getAsset(name) as Mesh;
			if (!mesh) throw new MeshGroupFactoryError(  MeshGroupFactoryError.ATTEMPTED_ACCESS_OF_UNAVAILABLE_MESH_ERROR );
			mesh.material = new ColorMaterial( color, 1 );
			this.appendMesh(mesh);
		}
		
		
		/**
		 * append a mesh to the group 
		 * @param mesh
		 * 
		 */		
		public function appendMesh( mesh:Mesh ):void{
			addChild( mesh );
			mesh.mouseEnabled = true;
			mesh.addEventListener(MouseEvent3D.CLICK, onClickEntity);
			mesh.addEventListener(MouseEvent3D.MOUSE_DOWN, onMouseDownEntity);
			mesh.addEventListener(MouseEvent3D.MOUSE_UP, onMouseUpEntity);
			meshes.push( mesh );
		}
		
		
		/**
		 * applies a material to every mesh in the group 
		 * @param material
		 * 
		 */		
		public function applyMaterial( material :MaterialBase ):void{
			var mesh :Mesh ;
			for each (mesh in meshes){
				if ( mesh.material )
					material.lights = mesh.material.lights;
				mesh.material = material;
			}
			
		}
		
		/**
		 * sets the lights for every mesh in the group 
		 * @param lights
		 * 
		 */		
		public function light( lights :Array ):void{
			var mesh :Mesh ;
			for each (mesh in meshes){
				var mat :MaterialBase = mesh.material;
				if (mat)
					mat.lights = lights;
			}
		}
		
		
		
		override public function movePivot( x:Number, y:Number, z:Number ):void{
			super.movePivot(x,y,z);
			trident.moveTo(x,y,z);
		}
		
		override public function set pivotPoint(pivot:Vector3D):void{
			super.pivotPoint = pivot;
			trident.position = pivot;
		}
		
		public function deleteObject():Boolean{
			this.parent.removeChild( this );
			return this.parent == null;
		}
		
		
		/*		EVENT		*/
		
		private function onClickEntity( e:MouseEvent3D ):void{
			selected = !selected;
		}
		
		private function onMouseDownEntity( e:MouseEvent3D ):void{
			dispatchEvent( new Event( START_DRAG ));
			this._scene.addEventListener(MouseEvent3D.MOUSE_UP, onMouseUpEntity);
		}
		
		private function onMouseUpEntity( e:MouseEvent3D ):void{
			dispatchEvent( new Event( END_DRAG ));			
		}
		
		
	}
}