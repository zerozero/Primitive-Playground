package com.jonrowe.away3d.controller
{
	import com.jonrowe.away3d.model.event.CreatePrimitiveEvent;
	import com.jonrowe.away3d.services.ISocketService;
	
	import org.robotlegs.mvcs.Command;
	
	
	public class CreateObjectCommand extends Command
	{
		
		
		[Inject]
		public var event:CreatePrimitiveEvent;
		
		[Inject]
		public var socket:ISocketService;

		
		override public function execute():void
		{
			socket.createObject(event.init);
		}
	}
}

