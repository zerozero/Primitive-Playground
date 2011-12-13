package com.jonrowe.away3d.productFactory.primitives
{
	import away3d.containers.ObjectContainer3D;
	import away3d.debug.Trident;
	import away3d.entities.Entity;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.ColorMaterial;
	import away3d.materials.MaterialBase;
	
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.ProductFactory;
	import com.jonrowe.away3d.productFactory.ProductTypeMap;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class PrimitiveObjectBase extends ObjectContainer3D implements IPrimitive
	{
		private var _primitiveName :String;
		private var _type :String;
		private var _object3D:ObjectContainer3D;
		
		protected var _selected :Boolean;
		protected var _scale :Number = 1;
		
		public var transformWidget :ObjectContainer3D;
		public var trident :Trident;
		
		public static const ENTITY_SELECT :String = 'entity_select';
		public static const START_DRAG :String = 'start_drag';
		public static const END_DRAG :String = 'end_drag';
		
		public static const DEFAULT_MATERIAL :ColorMaterial = new ColorMaterial( 0x6666cc, 0.8 );
		
		/*		CONSTRUCT		*/
		
		public function PrimitiveObjectBase()
		{
			
			trident = new Trident(100,true);
			
		}
		
		
		/*		STATIC		*/
		
		public static function create( type :String ):IPrimitive{
			return new ProductFactory( new ProductTypeMap() ).getProduct( type );
		}
		
		
		/*		GET/SET		*/
		
		public function set object3D( obj :ObjectContainer3D ):void{
			_object3D = obj;
		}
		
		public function get object3D():ObjectContainer3D{
			return _object3D;
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
			Entity(object3D).showBounds = selected;
			if (selected){
				addChild(trident);
				dispatchEvent( new Event(ENTITY_SELECT));
			}else{
				if (contains( trident ))
					removeChild(trident);
			}
		}
		
		public function get selected( ):Boolean{
			return _selected;	
		}
		
		
		
		/*		IMPLEMENT		*/
		
		public function init( type :String, initObjOrPrimitive :* ):void
		{
			this.type = type;
			if (initObjOrPrimitive is PrimitiveInit){
				var primitiveClass :Class = initObjOrPrimitive.primitiveClass; 
				object3D = new primitiveClass(initObjOrPrimitive.material) as ObjectContainer3D;
				var prop :String;
				for ( prop in initObjOrPrimitive.options ){
					object3D[prop] = initObjOrPrimitive.options[prop]; 
				}
			}else if (initObjOrPrimitive is ObjectContainer3D){
				object3D = initObjOrPrimitive;
			}else{
				throw new Error("Wrong type of object passed to Primitive init");
			}
			
			addChild( object3D );
			Entity(object3D).mouseEnabled = true;
			Entity(object3D).addEventListener(MouseEvent3D.CLICK, onClickEntity);
			Entity(object3D).addEventListener(MouseEvent3D.MOUSE_DOWN, onMouseDownEntity);
			Entity(object3D).addEventListener(MouseEvent3D.MOUSE_UP, onMouseUpEntity);
		}
		
		
		public function light( lights :Array ):void{
			//only light meshes
			var mesh :Mesh = object3D as Mesh;
			if (!mesh)
				return;
			
			var mat :MaterialBase = mesh.material;
			if (mat)
				mat.lights = lights;
		}
		
		
		override public function movePivot( x:Number, y:Number, z:Number ):void{
			super.movePivot(x,y,z);
			trident.moveTo(x,y,z);
		}
		
		override public function set pivotPoint(pivot:Vector3D):void{
			super.pivotPoint = pivot;
			trident.position = pivot;
		}
		
		
		/*		EVENT		*/
		
		private function onClickEntity( e:MouseEvent3D ):void{
			selected = !selected;
		}
		
		private function onMouseDownEntity( e:MouseEvent3D ):void{
			trace('down');
			dispatchEvent( new Event( START_DRAG ));
		}
		
		private function onMouseUpEntity( e:MouseEvent3D ):void{
			trace('up');
			dispatchEvent( new Event( END_DRAG ));			
		}
		
		
	}
}