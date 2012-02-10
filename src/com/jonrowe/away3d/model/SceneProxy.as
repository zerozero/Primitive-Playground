package com.jonrowe.away3d.model
{
	import away3d.entities.Mesh;
	import away3d.primitives.*;
	
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupType;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.Socrates;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.services.data.NewMemberVO;
	import com.jonrowe.away3d.view.event.DisplayPrimitiveEvent;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SceneProxy extends Actor
	{
		
		public static const NEW_MEMBER_JOINED :String = "new_member_joined";
		
		public static const TYPE_PRIMITIVE :String = "type_primitive";
		public static const TYPE_LOADER :String = "type_loader";
		
		private var _primitives :Object;
		private var _primitiveListSelection :String;
		private var _selectedPrimitive:IMeshGroupContainer3D;
		private var _inventory :Object = {};
		private var _primitiveObjects :ArrayCollection = new ArrayCollection();
		
		public function SceneProxy()
		{
			super();
		}
		
		/**
		 * 
		 * @return a list of primitives available to the app 
		 * 
		 */		
		public function get primitives():Object{
			if (!_primitives)
				initializePrimitives();
			return _primitives;
		}
		
		/**
		 * mutator for the _primitiveListSelection property.
		 *  
		 * @param primtiveInit
		 * 
		 */		
		public function set primitiveListSelection( val:String ):void{
			_primitiveListSelection = val;
		}
		
		/**
		 * accessor for the _primitiveListSelection property 
		 * @return a <code>PrimitiveInit</code> object
		 * 
		 */		
		public function get primitiveListSelection():String{
			return _primitiveListSelection;
		}
		
		
		/**
		 * mutator for the _selectedPrimitive property.
		 *  
		 * @param primtiveInit
		 * 
		 */		
		public function set selectedPrimitive( type :IMeshGroupContainer3D ):void{
			_selectedPrimitive = type;
		}
		
		/**
		 * accessor for the _primitiveListSelection property 
		 * @return a <code>PrimitiveInit</code> object
		 * 
		 */		
		public function get selectedPrimitive():IMeshGroupContainer3D{
			return _selectedPrimitive;
		}
		
		public function get primitiveObjects():ArrayCollection{
			return _primitiveObjects;
		}
		
		/**
		 * accessor for the _primitiveListSelection property 
		 * @return a <code>PrimitiveInit</code> object
		 * 
		 */	
		private var _dragPlane :String;
		public function get dragPlane():String{
			return _dragPlane;
		}
		
		public function set dragPlane(plane:String):void{
			_dragPlane = plane;
		}
		
		/**
		 * accessor for the _primitiveListSelection property 
		 * @return a <code>PrimitiveInit</code> object
		 * 
		 */	
		private var _useGlobalPlane :Boolean;
		public function get useGlobalPlane():Boolean{
			return _useGlobalPlane;
		}
		
		public function set useGlobalPlane(trueOrFalse:Boolean):void{
			_useGlobalPlane = trueOrFalse;
		}
		
		
		public function createDefaultObject():void{
			createMeshGroup("Cube");
		}
		
		public function createMeshGroup( type:String ):void{
			var meshGroup :IMeshGroupContainer3D = MeshGroupContainer3D.create( type );
			_primitiveObjects.addItem(meshGroup);
			dispatch( new DisplayPrimitiveEvent(DisplayPrimitiveEvent.DISPLAY, meshGroup ));
				/*if ( params.type == TYPE_PRIMITIVE ){
					createPrimitive( params.classname );
				}else{
					createLoadedModel( params.type );
				}*/
		}
		
		/**
		 * creates a meshGroup by name where type
		 * @param type
		 * 
		 */		
		/*public function createPrimitive( classname:String ):void{
			var params:Object = getPrimitiveClass(classname);
			var clss :Class = params.classRef;
			//var p :PrimitveBase = PrimitveBase(new (params.classname));
			var meshGroup :IMeshGroupContainer3D = MeshGroupContainer3D.create( MeshGroupType.PRIMITIVE );
			meshGroup.appendMesh( new clss(MeshGroupContainer3D.DEFAULT_MATERIAL) );
			
			_primitiveObjects.addItem(meshGroup);
			dispatch( new DisplayPrimitiveEvent(DisplayPrimitiveEvent.DISPLAY, meshGroup ));
		}*/
		
		/**
		 * creates a meshgroup from a loaded model
		 * the concrete class is responsible for retrieving assets from the asset library
		 * it is up to the author to make sure the correct assets are available in the loaded model
		 * and that the model has been correctly loaded at startup..
		 * @param type
		 * 
		 */		
		/*private function createLoadedModel( type :String ):void{
			var meshGroup :IMeshGroupContainer3D = MeshGroupContainer3D.create( type );
			_primitiveObjects.addItem(meshGroup);
			dispatch( new DisplayPrimitiveEvent(DisplayPrimitiveEvent.DISPLAY, meshGroup ));
		}*/
		
		
		public function duplicateSelectedPrimitve():void{
			if (selectedPrimitive){
				var meshGroup :IMeshGroupContainer3D = MeshGroupContainer3D.create( MeshGroupType.PRIMITIVE );
				var meshes :Vector.<Mesh> = selectedPrimitive.meshes;
				for ( var i:uint = 0; i<meshes.length; i++ ){
					meshGroup.appendMesh( meshes[i].clone() as Mesh);
				}
				_primitiveObjects.addItem(meshGroup);
				dispatch( new DisplayPrimitiveEvent(DisplayPrimitiveEvent.DISPLAY, meshGroup ));
			}else{
				//dispatch nothing selected error
			}
				
		}
		
		public function deleteSelectedPrimitve():void{
			if (selectedPrimitive){
				deletePrimitve( selectedPrimitive );
			}else{
				//dispatch nothing selected error
			}
				
		}
		
		
		public function deletePrimitve( meshGroup :IMeshGroupContainer3D ):void{
			
			_primitiveObjects.removeItemAt( _primitiveObjects.getItemIndex( meshGroup ));
			selectedPrimitive = null;
			
			dispatch( new DisplayPrimitiveEvent(DisplayPrimitiveEvent.REMOVE, meshGroup ));
				
		}
		/**
		 * cretaes a unique name for the meshGroup derived from the count
		 * of primitves of type <type> 
		 * This is an unsafe method for creating unique names sinc eit doesn't take into account deleted primitives - change
		 * @param type - the string type of the meshGroup
		 * @return 
		 * 
		 */		
		public function getNextPrimitive( type :String ):String{
			appendInventory(type);
			return type+"-"+_inventory[type];
		}
		
		/**
		 * appends a meshGroup of type <type> to the inventory count 
		 * @param type
		 * 
		 */		
		private function appendInventory( type :String ):void{
			if (!_inventory[type])
				_inventory[type] = 0;
			_inventory[type]++;
		}
		
		
		//temp - should have it's own model
		private var _newMember :NewMemberVO;
		public function set newMember( obj:NewMemberVO ):void{
			_newMember = obj;
			dispatch(new Event( NEW_MEMBER_JOINED ));
		}
		
		public function get newMember():NewMemberVO{
			return _newMember;
		}
		
		private function getPrimitiveClass( type :String ):Object{
			return primitives[type];
		}
		
		
		protected function initializePrimitives():void{
			
			_primitives = {};
			
			_primitives["Capsule"] = "Capsule"
			_primitives["Cone"] = "Cone"
			_primitives["Cube"] = "Cube";
			_primitives["Sphere"] = "Sphere"
			_primitives["Plane"] = "Plane"
			_primitives["Cylinder"] = "Cylinder";
			_primitives[MeshGroupType.SOCRATES] = MeshGroupType.SOCRATES;
			
/*			_primitives["Capsule"] = {classRef:Capsule, type: TYPE_PRIMITIVE };
			_primitives["Cone"] = {classRef:Cone, type: TYPE_PRIMITIVE };
			_primitives["Cube"] = {classRef:Cube, type: TYPE_PRIMITIVE };
			_primitives["Sphere"] = {classRef:Sphere, type: TYPE_PRIMITIVE };
			_primitives["Plane"] = {classRef:Plane, type: TYPE_PRIMITIVE };
			_primitives["Cylinder"] = {classRef:Cylinder, type: TYPE_PRIMITIVE };
			_primitives["Socrates"] = {classRef:Socrates, type: MeshGroupType.SOCRATES };
			*/
		}
		
	}
}