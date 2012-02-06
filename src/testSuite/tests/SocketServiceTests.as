package testSuite.tests
{
	import away3d.primitives.Cube;
	import away3d.primitives.PrimitiveBase;
	
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.services.ISocketService;
	import com.jonrowe.away3d.services.SocketService;
	import com.jonrowe.away3d.services.event.SocketServiceEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	
	public class SocketServiceTests
	{		
		private var socket :ISocketService;
		private var serviceDispatcher:EventDispatcher = new EventDispatcher();
		private var sceneProxy :SceneProxy;
		private var p_serviceDispatcher:EventDispatcher = new EventDispatcher();
		
		[Before(async)]
		public function setUp():void
		{
			serviceDispatcher = new EventDispatcher();
			socket = new SocketService();
			SocketService(socket).eventDispatcher = serviceDispatcher;
			
			p_serviceDispatcher = new EventDispatcher();
			sceneProxy = new SceneProxy();
			SceneProxy(sceneProxy).eventDispatcher = p_serviceDispatcher;
			
			Async.proceedOnEvent(this,serviceDispatcher,SocketService.CONNECTED,500,handleTimeout);
			socket.connect();
		}
		
		[After(async)]
		public function tearDown():void
		{
			socket = null;
			serviceDispatcher = null;
			sceneProxy = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
		//			TESTS		//
		
		[Ignore]
		[Test(async, description="Async connect to socket should return within 500 ms")]
		public function connect_xmlsocket_dispatcheventWithin500ms():void
		{
			var asyncHandler:Function = Async.asyncHandler( this, handleSuccess, 500, null, handleTimeout );
			serviceDispatcher.addEventListener(SocketService.CONNECTED, asyncHandler, false, 0, true );
			socket.connect();
		}
		
		
		[Test(async, description="Async handshake to socket should return within 500 ms")]
		public function handshake_authorID_dispatchEventWithin500ms():void
		{
			
			var asyncHandler:Function = Async.asyncHandler( this, handleSuccess, 500, null, handleTimeout );
			serviceDispatcher.addEventListener(SocketService.HANDSHAKED, asyncHandler, false, 0, true );
			socket.handshake(1);
		}
		
		[Test(async, description="Async send create object to socket and return within 500 ms")]
		public function createObject_objectWithParameters_dispatchEventWithin500ms():void
		{
			var asyncHandler:Function = Async.asyncHandler( this, handleSuccess, 500, null, handleTimeout );
			serviceDispatcher.addEventListener(SocketServiceEvent.OBJECT_CREATED, asyncHandler, false, 0, true );
			var init :PrimitiveInit = new PrimitiveInit("Cube", "Cube-1", Cube, PrimitiveObjectBase.DEFAULT_MATERIAL, {} );
			socket.createObject(init);
			
		}
		
		[Test(async)]
		public function handleNewMemberResult_mockjsonResponseFromSocket_dispatchWithin500ms():void{
			var asyncHandler:Function = Async.asyncHandler( this, handleSuccess, 500, null, handleTimeout );
			serviceDispatcher.addEventListener(SocketServiceEvent.NEW_MEMBER, asyncHandler, false, 0, true );
			
			socket.handleResult({	result:"OK", 
									type:SocketService.NEW_MEMBER, 
									data:{	authorID:1, 
											message:"Someone has joined the group"}});
		}
		
		[Test]
		public function encode_decode_json():void{
			var name :String = "Jon";
			var type :String = "HANDSHAKED";
			
			var json :String = socket.toJSON({
												id:name,
												type:type
											});
			var obj :Object = socket.fromJSON(json);
			Assert.assertEquals(obj.id,name);
		}
		
		// 		EVENT HANDLERS		//
		
		private function handleTimeout(passThroughData:Object):void{
			Assert.fail( "Timeout reached before event");	
		}
		
		private function handleSuccess(event:Event, passThroughData:Object):void{
			
		}
		
	}
}