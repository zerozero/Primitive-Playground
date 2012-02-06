package com.jonrowe.away3d.services
{
	//import JSON;
	
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.services.data.NewMemberVO;
	import com.jonrowe.away3d.services.event.SocketServiceEvent;
	import com.rational.serialization.json.JSON;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SocketService extends Actor implements ISocketService
	{
		public static const CONNECTED :String = "socket connected";
		public static const HANDSHAKED :String = "socket handshaked";
		
		
		private static const SOCKET_DOMAIN :String =  "164.177.158.250"; 
		
		public static const USERS : String = "users";
		public static const HANDSHAKE : String = "handshake";
		public static const CREATE_OBJECT : String = "create_object";
		public static const NEW_MEMBER : String = "new member";
		public static const MESSAGE : String = "message";
		public static const UPDATE : String = "update";
		public static const PAUSE : String = "pause";
		public static const COMMAND : String = "command";
		public static const CHARACTER_ASSIGN : String = "character_assign";
		public static const GOODBYE : String = "goodbye";
		
		private var tcp_socket :XMLSocket
		private var hasPolicyFile : Boolean = false;
		
		public function SocketService()
		{
			super();
		}
		
		public function connect():void{
			tcp_socket = new XMLSocket();
			
			tcp_socket.addEventListener(Event.CONNECT, onConnetcted);
			tcp_socket.addEventListener(Event.CLOSE, onCloseConnection);
			tcp_socket.addEventListener(DataEvent.DATA, onIncomingData);
			tcp_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError );
			tcp_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError );

			tcp_socket.connect(SOCKET_DOMAIN,8124);
		}
		
		public function handshake(id:int):void{
			
			var messageObj :Object = {
									type:HANDSHAKE,
									id:String(id)
									};
			var json :String = toJSON(messageObj);
			send(json);
		}
		
		
		/**
		 * 
		 * @param type
		 * @param params
		 * 
		 */		
		public function createObject(init:PrimitiveInit):void{
			
			var messageObj :Object = {
										type:CREATE_OBJECT,
										data:{
											type :init.type,
											name :init.name,
											material :init.material,
											option :init.options
										}
									};
			var json :String = toJSON(messageObj);
			send(json);
		}
		
		public function toJSON(obj:Object):String{
			return com.rational.serialization.json.JSON.encode(obj);
		}
		
		public function fromJSON(jsonStr:String):Object{
			return com.rational.serialization.json.JSON.decode(jsonStr);
		}
		
		public function handleResult(obj:Object):void{
			switch(true){
				case obj.type == HANDSHAKE:
					dispatch( new Event(HANDSHAKED));
					break;
				case obj.type == CREATE_OBJECT:
					dispatch( new SocketServiceEvent( SocketServiceEvent.OBJECT_CREATED, obj.data ));
					break;
				case obj.type == NEW_MEMBER:
					var vo :NewMemberVO = new NewMemberVO(obj.data.authorID,obj.data.message);
					dispatch( new SocketServiceEvent( SocketServiceEvent.NEW_MEMBER, vo ));
					//sent by socket server when a new user has joined this group
					//do something 
					break;
			}
		}
		//			PRIVATE			//
		
		private function send( message :String ):void{
			if (tcp_socket.connected){
				tcp_socket.send(message);
			}
		}
		
		//			EVENT			//
		
		private function onConnetcted( e:Event ):void{
			if (!hasPolicyFile){
				hasPolicyFile = true;
				dispatch( new Event(CONNECTED));
			}
		}
		
		private function onCloseConnection( e:Event ):void{
			
		}
		
		/**
		 * message received from a client 
		 * @param event
		 * 
		 */		
		private function onIncomingData( event:DataEvent ):void
		{
			//var rawJSON :String = event.data;
			var jsonStr :String = event.data;
			var obj :Object = fromJSON(jsonStr);
			
			switch(true){
				case (obj.result == "OK"):
					handleResult(obj);					
					break;
				case (obj.result == "ERROR"):
					trace("ERROR "+obj.data.message);
					break;
			}
			
		}
		
		private function onIOError( e:Event ):void{
			
		}
		
		private function onSecurityError( e:Event ):void{
			
		}
	}
}