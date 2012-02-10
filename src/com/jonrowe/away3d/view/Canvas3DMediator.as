package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.view.component.Canvas3D;
	import com.jonrowe.away3d.view.event.DisplayPrimitiveEvent;
	import com.jonrowe.away3d.view.event.EntityEvent;
	
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
			addContextListener(EntityEvent.START_DRAG, onEntityStartDrag);
			addContextListener(EntityEvent.END_DRAG, onEntityEndDrag);
		}
		
		
		
		protected function onSceneReady( e:Event ):void{
			sceneProxy.createDefaultObject();
		}
		
		protected function onEntityStartDrag( e:EntityEvent ):void{
			view.startDragging( e.primitive, sceneProxy.dragPlane, sceneProxy.useGlobalPlane );
		}
		
		protected function onEntityEndDrag( e:EntityEvent ):void{
			view.endDragging( e.primitive );			
		}
		
		protected function onDisplayPrimitive( e:DisplayPrimitiveEvent ):void{
			mediatorMap.createMediator(IMeshGroupContainer3D(e.primitive));
			view.displayPrimitive( e.primitive );
		}
		
		protected function onRemovePrimitive( e:DisplayPrimitiveEvent ):void{
			mediatorMap.removeMediatorByView(e.primitive);
			view.removePrimitive(e.primitive);
		}
		
		public function get view():Canvas3D{
			return _view;
		}
		
	}
}