package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.Socrates;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.view.event.EntityEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class SocratesMediator extends Mediator
	{
		
		[Inject]
		public var _view :Socrates;

		[Inject]
		public var sceneProxy :SceneProxy;
		
		public function SocratesMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			view.addEventListener(MeshGroupContainer3D.ENTITY_SELECT, onClickEntity);
			view.addEventListener(MeshGroupContainer3D.START_DRAG, onStartDrag);
			view.addEventListener(MeshGroupContainer3D.END_DRAG, onEndDrag);
			view.selected = true;
			//add a listener for other entities being selected - will need to move to proxy to manage selection rules when remote clients can select
			addContextListener(EntityEvent.ENTITY_SELECT, onEntitySelect);
			dispatch(new EntityEvent(EntityEvent.ENTITY_SELECT, view as IMeshGroupContainer3D ));
		}
		
		protected function onStartDrag( e:Event ):void{
			dispatch(new EntityEvent(EntityEvent.START_DRAG, e.currentTarget as IMeshGroupContainer3D ));						
		}
		
		protected function onEndDrag( e:Event ):void{
			dispatch(new EntityEvent(EntityEvent.END_DRAG, e.currentTarget as IMeshGroupContainer3D ));			
		}
		
		/**
		 * this entity was clicked 
		 * @param e
		 * 
		 */		
		protected function onClickEntity( e:Event ):void{
			sceneProxy.selectedPrimitive = e.currentTarget as IMeshGroupContainer3D;
			dispatch(new EntityEvent(EntityEvent.ENTITY_SELECT, e.currentTarget as IMeshGroupContainer3D ));
		}
		
		/**
		 * respond to other entities being selected 
		 * @param e
		 * 
		 */		
		protected function onEntitySelect( e:EntityEvent ):void{
			if (e.primitive != getViewComponent() as IMeshGroupContainer3D)
				MeshGroupContainer3D(getViewComponent()).selected = false;
		}
		
		public function get view():Socrates{
			return _view;
		}
		
	}
}