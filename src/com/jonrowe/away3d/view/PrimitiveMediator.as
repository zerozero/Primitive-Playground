package com.jonrowe.away3d.view
{
	import away3d.entities.Entity;
	import away3d.events.MouseEvent3D;
	
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.view.event.EntitySelectEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class PrimitiveMediator extends Mediator
	{
		
		[Inject]
		public var _view :Primitive;

		[Inject]
		public var sceneProxy :SceneProxy;
		
		public function PrimitiveMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			view.addEventListener(PrimitiveObjectBase.ENTITY_SELECT, onClickEntity);
			view.selected = true;
			//add a listener for other entities being selected - will need to move to proxy to manage selection rules when remote clients can select
			addContextListener(EntitySelectEvent.ENTITY_SELECT, onEntitySelect);
			dispatch(new EntitySelectEvent(EntitySelectEvent.ENTITY_SELECT, view as IPrimitive ));
		}
		
		
		
		protected function onClickEntity( e:Event ):void{
			sceneProxy.selectedPrimitive = e.currentTarget as IPrimitive;
			dispatch(new EntitySelectEvent(EntitySelectEvent.ENTITY_SELECT, e.currentTarget as IPrimitive ));
		}
		
		protected function onEntitySelect( e:EntitySelectEvent ):void{
			if (e.primitive != getViewComponent() as IPrimitive)
				PrimitiveObjectBase(getViewComponent()).selected = false;
		}
		
		public function get view():Primitive{
			return _view;
		}
		
	}
}