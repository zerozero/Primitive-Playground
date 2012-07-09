package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.meshGroupFactory.containers.TransformWidget;
	import com.jonrowe.away3d.meshGroupFactory.containers.event.MeshGroupEvent;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.view.component.Canvas3D;
	import com.jonrowe.away3d.view.event.DisplayPrimitiveEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class Canvas3DMediator extends Mediator
	{
		
		[Inject]
		public var _view :Canvas3D;
		
		[Inject]
		public var sceneProxy :SceneProxy;
		
		public function Canvas3DMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			view.addEventListener(Canvas3D.SCENE_READY, onSceneReady);
			
			addContextListener(DisplayPrimitiveEvent.DISPLAY, onDisplayPrimitive);
			addContextListener(DisplayPrimitiveEvent.REMOVE, onRemovePrimitive);
		}
		
		/**
		 * scene is ready  
		 * @param e
		 * 
		 */		
		protected function onSceneReady( e:Event ):void{
			view.view3D.scene.addEventListener(MeshGroupEvent.MESH_GROUP_CLICK, onMeshGroupClick);
			view.view3D.scene.addEventListener(MeshGroupEvent.MESH_GROUP_MOUSE_DOWN, onMeshGroupMouseDown);
			view.view3D.scene.addEventListener(MeshGroupEvent.MESH_GROUP_MOUSE_UP, onMeshGroupMouseUp);
			view.view3D.scene.addEventListener(MeshGroupEvent.MESH_GROUP_SELECT, onMeshGroupSelect);
			
			sceneProxy.createDefaultObject();
		}
		
		/**
		 * display a newly created meshGroup 
		 * @param e
		 * 
		 */		
		protected function onDisplayPrimitive( e:DisplayPrimitiveEvent ):void{
			mediatorMap.createMediator(IMeshGroupContainer3D(e.primitive));
			view.addMeshGroup( e.primitive );
		}
		
		/**
		 * remove a meshGroup 
		 * @param e
		 * 
		 */		
		protected function onRemovePrimitive( e:DisplayPrimitiveEvent ):void{
			mediatorMap.removeMediatorByView(e.primitive);
			view.removeMeshGroup(e.primitive);
		}
		
		/**
		 * mouseDown on meshGroup 
		 * @param e
		 * 
		 */		
		protected function onMeshGroupMouseDown( e:MeshGroupEvent):void{
			dispatch(e.clone());					
		}
		
		/**
		 * mouseup on meshGroup 
		 * @param e
		 * 
		 */		
		protected function onMeshGroupMouseUp( e:MeshGroupEvent ):void{
			dispatch(e.clone());			
		}
		
		/**
		 * this entity was clicked 
		 * @param e
		 * 
		 */		
		protected function onMeshGroupClick( e:MeshGroupEvent ):void{
			dispatch(e.clone());
		}
		
		/**
		 * meshGroup was selected 
		 * display a transform widget
		 * @param e
		 * 
		 */		
		protected function onMeshGroupSelect( e:MeshGroupEvent ):void{
			dispatch(e.clone());
			if (!view.transformWidget)
				view.transformWidget = sceneProxy.createTransformWidget() as TransformWidget;
			view.displayTransformWidget(e.meshGroup);
		}
		
		
		public function get view():Canvas3D{
			return _view;
		}
		
		public function set view(canvas:Canvas3D):void{
			_view = canvas;
		}
		
	}
}