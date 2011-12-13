package com.jonrowe.away3d.view
{
	import away3d.entities.Entity;
	import away3d.events.MouseEvent3D;
	
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.view.event.CreatePrimitiveEvent;
	import com.jonrowe.away3d.view.event.DuplicatePrimitiveEvent;
	import com.jonrowe.away3d.view.event.EntitySelectEvent;
	import com.jonrowe.away3d.view.event.StageResizeEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class ApplicationMediator extends Mediator
	{
		
		[Inject]
		public var _view :Main;
		
		public function ApplicationMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			addContextListener(DuplicatePrimitiveEvent.DUPLICATE, onDuplicateObject);
			addContextListener(CreatePrimitiveEvent.CREATE,onCreatePrimitive );
			view.addEventListener(Main.RESIZE, onResize);
		}
		
		
		protected function onDuplicateObject( e:DuplicatePrimitiveEvent):void{
			view.duplicate(e.primitive);
		}
		
		protected function onCreatePrimitive(e:CreatePrimitiveEvent):void{
			view.create(e.init);
		}
		
		private function onResize(e:Event):void{
			dispatch( new StageResizeEvent( StageResizeEvent.STAGE_RESIZE ));
		}
		
		public function get view():Main{
			return _view;
		}
		
	}
}