package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.meshGroupFactory.containers.event.MeshGroupEvent;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.view.component.EditView;
	import com.jonrowe.away3d.view.component.gui.*;
	import com.jonrowe.away3d.view.event.StageResizeEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EditViewMediator extends Mediator
	{
		
		[Inject]
		public var _view :EditView;
		
		[Inject]
		public var sceneProxy :SceneProxy;
		
		public function EditViewMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			addContextListener(MeshGroupEvent.MESH_GROUP_CLICK, onSelectEntity);
			addContextListener(StageResizeEvent.STAGE_RESIZE, onStageResize);
			view.addEventListener( EditPosition.CHANGE_PLANE, onChangePlane, true );
			view.addEventListener( EditPosition.CHANGE_GLOBAL_LOCAL, onChangeGlobalLocalPlane, true );
			view.createChildren();
			/*view.addEventListener( CreatePrimitive.MAKE, onMake, true );*/
		}
		
		private function onSelectEntity( e:MeshGroupEvent ):void{
			view.createGUI(IMeshGroupContainer3D(e.meshGroup));
			/*if (!view.hasEventListener(CreatePrimitive.DUPLICATE))
				view.addEventListener(CreatePrimitive.DUPLICATE, onDuplicate, true);*/
		}
		
		private function onChangePlane( e:Event ):void{
			sceneProxy.dragPlane = EditPosition(e.target).plane;
		}
		
		private function onChangeGlobalLocalPlane( e:Event ):void{
			sceneProxy.useGlobalPlane = EditPosition(e.target).useGlobalPlane;
		}
		
		/*private function onDuplicate( e:Event ):void{
			dispatch( new DuplicatePrimitiveEvent(DuplicatePrimitiveEvent.DUPLICATE, view.editGUI.primitive as IPrimitive ));
		}
		
		private function onMake( e:Event ):void{
			var createPrimitiveView :CreatePrimitive = e.target as CreatePrimitive;
			dispatch( new CreatePrimitiveEvent(CreatePrimitiveEvent.CREATE, createPrimitiveView.selected as PrimitiveInit ));
		}*/
		
		private function onStageResize(e:StageResizeEvent):void{
			view.resize();
		}
		
		public function get view():EditView{
			return _view;
		}
	}
}