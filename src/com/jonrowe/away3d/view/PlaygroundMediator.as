package com.jonrowe.away3d.view
{
	import away3d.entities.Entity;
	import away3d.events.MouseEvent3D;
	
	import com.jonrowe.away3d.model.event.CreatePrimitiveEvent;
	import com.jonrowe.away3d.productFactory.ProductType;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.services.ISocketService;
	import com.jonrowe.away3d.services.SocketService;
	import com.jonrowe.away3d.view.event.DuplicatePrimitiveEvent;
	import com.jonrowe.away3d.view.event.EntityEvent;
	import com.jonrowe.away3d.view.event.PrintMessageEvent;
	import com.jonrowe.away3d.view.event.StageResizeEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class PlaygroundMediator extends Mediator
	{
		
		[Inject]
		public var _view :Primitives;
		
		
		public function PlaygroundMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			addContextListener( PrintMessageEvent.PRINT_MESSAGE, onPrintMessage );
		}
		
		private function onPrintMessage ( e:PrintMessageEvent ):void{
		}
		
		public function get view():Primitives{
			return _view;
		}
		
	}
}