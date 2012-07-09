package testSuite.tests.view
{
	import com.jonrowe.away3d.view.CreatePrimitiveMediator;
	import com.jonrowe.away3d.view.component.gui.CreatePrimitive;
	import com.jonrowe.away3d.model.SceneProxy;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import flexunit.framework.Assert;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.stub;
	import mockolate.verify;
	
	import org.flexunit.async.Async;	

	public class CreatePrimitiveMediatorTests
	{		
		private var instance :CreatePrimitiveMediator;
		private var view:CreatePrimitive;
		
		/*[Before (async,order=1)]
		public function prepareMockClasses():void{
			var mockolateMaker :IEventDispatcher = prepare(CreatePrimitive);
			Async.proceedOnEvent(this, mockolateMaker, Event.COMPLETE);
		}*/
		
		[Before]
		public function setUp():void
		{
			instance = new CreatePrimitiveMediator();
			/*view = nice(CreatePrimitive);
			stub(view).setter("selected").arg(true);*/
			
			view = new CreatePrimitive();
			instance.view = view;
			view.selected = "Cube";
			
			instance.sceneProxy = new SceneProxy();
			instance.sceneProxy.primitiveListSelection = view.selected;
			instance.sceneProxy.eventDispatcher = new EventDispatcher();
			
			instance.setViewComponent(instance.view);
			instance.eventDispatcher = new EventDispatcher();
			instance.onRegister();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test (async)]
		public function On_Make_Mouse_Click_CreatePrimitive_MAKE_event():void{
			
			var handler :Function = Async.asyncHandler(this, onHandleMouseClick, 500,null, onHandleTimeout);
			instance.eventDispatcher.addEventListener(CreatePrimitive.MAKE, handler);
			instance.view.dispatchEvent(new Event( CreatePrimitive.MAKE ));
			/*var e:Event = new Event( CreatePrimitive.MAKE );
			stub(view).method("dispatchEvent").args(e);
			view.dispatchEvent(e);*/
		}
		
		private function onHandleMouseClick( e:Event, passThrough:Object ):void{
			Assert.assertEquals("event is correct type ", e.type, CreatePrimitive.MAKE );
		}
		
		private function onHandleTimeout( passThrough:Object ):void{
			Assert.fail( "Timeout reached before event");	
		}
		
	}
}