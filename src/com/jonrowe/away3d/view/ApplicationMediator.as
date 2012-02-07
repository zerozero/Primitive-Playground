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
	import com.jonrowe.away3d.view.event.StageResizeEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class ApplicationMediator extends Mediator
	{
		
		[Inject]
		public var _view :Main;
		
		[Inject]
		public var socketService :ISocketService;
		
		public function ApplicationMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			addContextListener(SocketService.CONNECTED, onConnected);
			view.addEventListener(Main.RESIZE, onResize);
			view.createChildren();
		}
		
		
		
		protected function onResize(e:Event):void{
			dispatch( new StageResizeEvent( StageResizeEvent.STAGE_RESIZE ));
		}
		
		protected function onConnected(e:Event):void{
			socketService.handshake(view.params.userid);
		}
		
		public function get view():Main{
			return _view;
		}
		
	}
}