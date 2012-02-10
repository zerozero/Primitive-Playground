package com.jonrowe.away3d.view.component 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.events.MouseEvent3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.Loader3D;
	import away3d.tools.utils.Drag3D;
	
	import com.jonrowe.away3d.meshGroupFactory.PrimitiveInit;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.component.WireframeSingleAxisGrid;
	import com.jonrowe.away3d.utils.Drag2D;
	import com.jonrowe.away3d.utils.HoverDragController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class Canvas3D extends Sprite
	{
		/*		PUBLIC PROPERTIES		*/
		
		public var gui :SimpleGUI;
		
		public static const SCENE_READY :String = 'scene_ready';
		public static const SELECTION_CHANGE :String = 'selection_change';
		
		/*		PRIVATE PROPERTIES		*/
		
		private var _view:View3D;
		private var _selected :IMeshGroupContainer3D;
		private var camController:HoverDragController;   
		private var directionalLight :DirectionalLight;
		private var pointLight :PointLight;
		private var drag :Drag2D;
		
		/*		CONSTRUCT		*/
		
		public function Canvas3D()
		{
			super();
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		
		/*		GET/SET		*/
		
		public function get selected():IMeshGroupContainer3D{
			return _selected;
		}
		
		public function set selected(p:IMeshGroupContainer3D):void{
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
		
		public function displayPrimitive( primitive :IMeshGroupContainer3D ):void{
			_view.scene.addChild(primitive as ObjectContainer3D);
			primitive.light([pointLight]);
			
		}
		
		public function displayLoadedMesh( mesh : IMeshGroupContainer3D ):void{
			_view.scene.addChild( mesh as ObjectContainer3D );
			//mesh.light([pointLight]);
		}
		
		public function removePrimitive( primitive :IMeshGroupContainer3D ):void{
			_view.scene.removeChild( primitive as ObjectContainer3D );
		}
		
		
		public function setSize(w:int, h:int):void{
			_view.width = w;
			_view.height = h;
			
		}
		
		public function startDragging( primitive :IMeshGroupContainer3D, plane :String, useGlobalPlane :Boolean ):void{
			drag = new Drag2D(_view,ObjectContainer3D(primitive));
			if (plane) drag.plane = plane;
			
			//drag.offsetCenter = true;
			drag.useRotations = true;
			
			drag.debug = true;
			if ( !useGlobalPlane ){
				drag.planeObject3d = ObjectContainer3D(primitive);
			}else{
				drag.planeObject3d  = null;
			}
			camController.active = false;
		}
		
		public function endDragging( primitive :IMeshGroupContainer3D ):void{
			camController.active = true;
			if (!drag) return;
			drag.debug = false;
			drag = null;
		}
		
		
		/*		PRIVATE		*/
		
		
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
		
		
		private function onAddedToStage( e:Event ):void{
			createChildren();
			initLights();
			initScene();
			initCamController();
			dispatchEvent( new Event(SCENE_READY));
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onEnterFrame(ev : Event) : void {
			if (drag)
				drag.updateDrag();
			_view.render();
			
		} 

		
	}
}