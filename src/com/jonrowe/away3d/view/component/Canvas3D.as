package com.jonrowe.away3d.view.component 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.events.MouseEvent3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.tools.utils.Drag3D;
	
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.productFactory.primitives.component.WireframeSingleAxisGrid;
	import com.jonrowe.away3d.utils.HoverDragController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class Canvas3D extends Sprite
	{
		/*		PUBLIC PROPERTIES		*/
		
		public var gui :SimpleGUI;
		
		public static const SELECTION_CHANGE :String = 'selection_change';
		
		/*		PRIVATE PROPERTIES		*/
		
		private var _view:View3D;
		private var _selected :IPrimitive;
		private var camController:HoverDragController;   
		private var directionalLight :DirectionalLight;
		private var pointLight :PointLight;
		private var drag :Drag3D;
		
		/*		CONSTRUCT		*/
		
		public function Canvas3D()
		{
			super();
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			createChildren();
		}
		
		
		/*		GET/SET		*/
		
		public function get selected():IPrimitive{
			return _selected;
		}
		
		public function set selected(p:IPrimitive):void{
			_selected = p;
		}
		
		/*		OVERRIDE		*/
		
		public function createChildren():void
		{
			
			if(!this._view)
			{
				_view = new View3D(); 
				_view.backgroundColor = 0x393939; 
				_view.antiAlias = 2; 
			}
			this.addChild(_view); 
			
			
		}
		
		
		
		/*		PUBLIC		*/
		
		public function createObject( type :String, initObj :PrimitiveInit ):IPrimitive{
			var primitive :IPrimitive = PrimitiveObjectBase.create( type );
			primitive.init( type, initObj );
			ObjectContainer3D(primitive).addEventListener( MouseEvent3D.MOUSE_DOWN, onMouseDownEntity );
			ObjectContainer3D(primitive).addEventListener( MouseEvent3D.MOUSE_UP, onMouseUpEntity );
			_view.scene.addChild(primitive as ObjectContainer3D);
			
			//tempoarily - light the primitive
//			primitive.light([directionalLight]);
			primitive.light([pointLight]);
			
			return primitive;
		}
		
		public function duplicateObject( primitive :IPrimitive ):IPrimitive{
			var type :String = primitive.type;
			var newPrimitive :IPrimitive = PrimitiveObjectBase.create( type );
			newPrimitive.init(type, primitive.object3D.clone());
			_view.scene.addChild(newPrimitive as ObjectContainer3D);
			return newPrimitive;
		}
		
		public function setSize(w:int, h:int):void{
			_view.width = w;
			_view.height = h;
			
		}
		
		
		/*		PRIVATE		*/
		
		
		private function initView():void{
			_view.width = 600;
			_view.height = 600;
		}
		
		private function initScene():void{
			
			var grid :WireframeSingleAxisGrid = new WireframeSingleAxisGrid(10,1000,1.5,WireframeSingleAxisGrid.PLANE_XZ,0x4a4a4a);
			_view.scene.addChild(grid);
			
			
			var stats :AwayStats = new AwayStats(_view);
			addChild(stats);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		private function initCamController():void{
			camController = new HoverDragController(_view.camera, this);
			camController.radius = 800;
		}
		
		private function initLights():void{
			directionalLight = new DirectionalLight();
			directionalLight.specular = 0.3;
			_view.scene.addChild(directionalLight);
			
			pointLight = new PointLight();
			pointLight.moveTo(300,300,-300);
			pointLight.radius = 1;
			_view.scene.addChild(pointLight);
		}
		
		
		/*		EVENT		*/
		
		private function onMouseDownEntity( e:MouseEvent3D ):void{
			
			drag = new Drag3D(_view,ObjectContainer3D(e.target));
			drag.useRotations = true;
			camController.active = false;
		}
		
		private function onMouseUpEntity( e:MouseEvent3D ):void{
			drag = null;
			camController.active = true;
		}
		private function onAddedToStage( e:Event ):void{
			initView();
			initLights();
			initScene();
			initCamController();
		}
		
		private function onEnterFrame(ev : Event) : void {
			if (drag)
				drag.updateDrag();
			_view.render();
			
		} 

		
	}
}