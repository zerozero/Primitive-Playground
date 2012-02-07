package com.jonrowe.away3d.model
{
	import away3d.primitives.*;
	
	import com.jonrowe.away3d.model.event.CreatePrimitiveEvent;
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.ProductType;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.services.data.NewMemberVO;
	import com.jonrowe.away3d.view.event.DisplayPrimitiveEvent;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SceneProxy extends Actor
	{
		
		public static const NEW_MEMBER_JOINED :String = "new_member_joined";
		
		private var _primitives :Object;
		private var _primitiveListSelection :String;
		private var _selectedPrimitive:IPrimitive;
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
		public function set primitiveListSelection( type :String ):void{
			_primitiveListSelection = type;
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
		public function set selectedPrimitive( type :IPrimitive ):void{
			_selectedPrimitive = type;
		}
		
		/**
		 * accessor for the _primitiveListSelection property 
		 * @return a <code>PrimitiveInit</code> object
		 * 
		 */		
		public function get selectedPrimitive():IPrimitive{
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
			createPrimitveType("Cube");
		}
		
		/**
		 * creates a primitive by name where name should be a name as defined in productTypeMap 
		 * @param name
		 * 
		 */		
		public function createPrimitveType( type:String ):void{
			var primitive :IPrimitive = PrimitiveObjectBase.create( ProductType.PRIMITIVE );
			primitive.init( type, createObjectInit( type ) );
			_primitiveObjects.addItem(primitive);
			dispatch( new DisplayPrimitiveEvent(DisplayPrimitiveEvent.DISPLAY, primitive ));
		}
		
		public function createObjectInit( type:String ):PrimitiveInit{
			var objectInit :PrimitiveInit = new PrimitiveInit(	type,
																getNextPrimitive(type), 
																primitives[type],
																PrimitiveObjectBase.DEFAULT_MATERIAL ,
																{} ); 
			return objectInit;
		}
		
		
		public function duplicateSelectedPrimitve():void{
			if (selectedPrimitive){
				createPrimitveType( selectedPrimitive.type );
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
		
		
		public function deletePrimitve( primitive :IPrimitive ):void{
			
			_primitiveObjects.removeItemAt( _primitiveObjects.getItemIndex( primitive ));
			selectedPrimitive = null;
			
			dispatch( new DisplayPrimitiveEvent(DisplayPrimitiveEvent.REMOVE, primitive ));
				
		}
		/**
		 * cretaes a unique name for the primitive derived from the count
		 * of primitves of type <type> 
		 * This is an unsafe method for creating unique names sinc eit doesn't take into account deleted primitives - change
		 * @param type - the string type of the primitive
		 * @return 
		 * 
		 */		
		public function getNextPrimitive( type :String ):String{
			appendInventory(type);
			return type+"-"+_inventory[type];
		}
		
		/**
		 * appends a primitive of type <type> to the inventory count 
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
		
		
		
		
		protected function initializePrimitives():void{
			
			_primitives = {};
			
			_primitives["Capsule"] = Capsule;
			_primitives["Cone"] = Cone;
			_primitives["Cube"] = Cube;
			_primitives["Sphere"] = Sphere;
			_primitives["Plane"] = Plane;
			_primitives["Cylinder"] = Cylinder;
			
		}
		
	}
}