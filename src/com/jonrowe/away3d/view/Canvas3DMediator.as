package com.jonrowe.away3d.view
{
	import away3d.entities.Entity;
	import away3d.events.MouseEvent3D;
	
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.model.event.CreatePrimitiveEvent;
	import com.jonrowe.away3d.productFactory.ProductType;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.services.event.Loader3DEvent;
	import com.jonrowe.away3d.view.component.Canvas3D;
	import com.jonrowe.away3d.view.event.DisplayPrimitiveEvent;
	import com.jonrowe.away3d.view.event.DuplicatePrimitiveEvent;
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
			addContextListener(Loader3DEvent.DISPLAY, onDisplayLoadedMesh);
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
			mediatorMap.createMediator(Primitive(e.primitive));
			view.displayPrimitive( e.primitive );
		}
		
		protected function onRemovePrimitive( e:DisplayPrimitiveEvent ):void{
			mediatorMap.removeMediatorByView(e.primitive);
			view.removePrimitive(e.primitive);
		}
		
		protected function onDisplayLoadedMesh( e:Loader3DEvent ):void{
			mediatorMap.createMediator(Primitive(e.data));
			view.displayLoadedMesh( e.data );
		}
		
		
		public function get view():Canvas3D{
			return _view;
		}
		
	}
}