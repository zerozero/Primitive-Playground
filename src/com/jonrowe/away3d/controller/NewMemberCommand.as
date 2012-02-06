package com.jonrowe.away3d.controller
{
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.services.data.NewMemberVO;
	import com.jonrowe.away3d.services.event.SocketServiceEvent;
	
	import org.robotlegs.mvcs.Command;
	
	
	public class NewMemberCommand extends Command
	{
		
		
		[Inject]
		public var event:SocketServiceEvent;
		
		[Inject]
		public var sceneProxy:SceneProxy;

		
		override public function execute():void
		{
			trace("NewMemberCommand "+event.data);
			sceneProxy.newMember = event.data as NewMemberVO;
		}
	}
}

