package com.jonrowe.away3d.view
{
	import away3d.entities.Entity;
	import away3d.events.MouseEvent3D;
	
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
		
		public function PrimitiveMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			trace("primitive registered");
			view.addEventListener(PrimitiveObjectBase.ENTITY_SELECT, onClickEntity);
			view.selected = true;
			
			addContextListener(EntitySelectEvent.ENTITY_SELECT, onEntitySelect);
		}
		
		
		
		protected function onClickEntity( e:Event ):void{
			
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