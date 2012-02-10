package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.services.IFileService;
	import com.jonrowe.away3d.services.ISocketService;
	import com.jonrowe.away3d.services.SocketService;
	import com.jonrowe.away3d.view.event.StageResizeEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class ApplicationMediator extends Mediator
	{
		
		[Inject]
		public var _view :Main;
		
		[Inject]
		public var socketService :ISocketService;
		
		[Inject]
		public var fileService :IFileService;
		
		public function ApplicationMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			addContextListener(SocketService.CONNECTED, onConnected);
			view.addEventListener(Main.RESIZE, onResize);
			view.createChildren();
			fileService.loadMesh();
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