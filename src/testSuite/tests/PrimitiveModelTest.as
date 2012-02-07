package testSuite.tests
{
	import away3d.primitives.Capsule;
	
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.ProductType;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.view.event.*;
	
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class PrimitiveModelTest
	{		
		private var sceneProxy :SceneProxy;
		private var modelDispatcher :EventDispatcher;
		
		[Before]
		public function setUp():void
		{
			sceneProxy = new SceneProxy();
			modelDispatcher = new EventDispatcher();
			sceneProxy.eventDispatcher = modelDispatcher;
		}
		
		[After]
		public function tearDown():void
		{
			modelDispatcher = null;
			sceneProxy.eventDispatcher = null;
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
		
		[Test]
		public function testListOfPrimitivesExists():void{
			var primitives :Object = sceneProxy.primitives;
			Assert.assertNotNull(primitives);
		}
		
		[Test]
		public function testChangeDragPlane():void{
			sceneProxy.dragPlane = "XY";
			Assert.assertTrue("Should be XY", sceneProxy.dragPlane == "XY");
		}
		
		[Test]
		public function testSelectedPrimitiveToCreate():void{
			var primitives :Object = sceneProxy.primitives;
			sceneProxy.primitiveListSelection = "Cube";
			Assert.assertEquals("should both be Cube", primitives[sceneProxy.primitiveListSelection], primitives["Cube"]);
		}
		
		[Test(async, description="Create Primitive")]
		public function testCreatePrimitive():void{
			var primitives :Object = sceneProxy.primitives;
			sceneProxy.primitiveListSelection = "Cube";
			var asyncHandler:Function = Async.asyncHandler( this, testCreatePrimitiveResult, 500, null, handleTimeout );
			sceneProxy.eventDispatcher.addEventListener( DisplayPrimitiveEvent.DISPLAY, asyncHandler, false, 0, true );
			sceneProxy.createPrimitveType( sceneProxy.primitiveListSelection );
		}
		
		private function testCreatePrimitiveResult( e:DisplayPrimitiveEvent, passThroughData:Object ):void{
			var primitives :Object = sceneProxy.primitives;
			Assert.assertEquals("type should be Cube", e.primitive.type, "Cube");
			Assert.assertTrue("Should be one object in the primitivesCollection ", sceneProxy.primitiveObjects.length == 1);
		}
		
		[Test(async, description="Duplicate Primitive")]
		public function testDuplicatePrimitive():void{
			//inits list of primitives if not yet defined
			var primitives :Object = sceneProxy.primitives;
			//create a mock primitive
			var primitive :IPrimitive = PrimitiveObjectBase.create( ProductType.PRIMITIVE );
			primitive.init( "Cube", sceneProxy.createObjectInit( "Cube" ) );
			//set it as the selected primitive
			sceneProxy.selectedPrimitive = primitive;
			//test duplication
			var asyncHandler:Function = Async.asyncHandler( this, testDuplicatePrimitiveResult, 500, null, handleTimeout );
			sceneProxy.eventDispatcher.addEventListener( DisplayPrimitiveEvent.DISPLAY, asyncHandler, false, 0, true );
			sceneProxy.duplicateSelectedPrimitve( );
		}
		
		private function testDuplicatePrimitiveResult( e:DisplayPrimitiveEvent, passThroughData:Object ):void{
			var primitives :Object = sceneProxy.primitives;
			Assert.assertEquals("type should be Cube", e.primitive.type, "Cube");
		}
		
		[Test(async, description="Delete Primitive")]
		public function testDeletePrimitive():void{
			//inits list of primitives if not yet defined
			var primitives :Object = sceneProxy.primitives;
			//create a mock primitive
			
			sceneProxy.createPrimitveType("Cube");
			//set it as the selected primitive
			sceneProxy.selectedPrimitive = sceneProxy.primitiveObjects.getItemAt(0) as IPrimitive;
			
			//test deletion
			var asyncHandler:Function = Async.asyncHandler( this, testDeletePrimitiveResult, 500, null, handleTimeout );
			sceneProxy.eventDispatcher.addEventListener( DisplayPrimitiveEvent.REMOVE, asyncHandler, false, 0, true );
			sceneProxy.deleteSelectedPrimitve( );
		}
		
		private function testDeletePrimitiveResult( e:DisplayPrimitiveEvent, passThroughData:Object ):void{
			var primitives :Object = sceneProxy.primitives;
			Assert.assertEquals("type should be Cube", e.primitive.type, "Cube");
			Assert.assertTrue("Should be no objects in the primitivesCollection ", sceneProxy.primitiveObjects.length == 0);
		}
		
		[Test]
		public function createObjectInitializer_initWithName_validInitObject():void{
			var primitives :Object = sceneProxy.primitives;
			var init :PrimitiveInit = sceneProxy.createObjectInit("Capsule");
			Assert.assertNotNull(init);
			Assert.assertTrue( init.primitiveClass == Capsule );
			Assert.assertTrue( init.name.indexOf("Capsule") > -1 );
		}
		
		protected function handleTimeout( passThroughData:Object ):void {
			Assert.fail( "Timeout reached before event");	
		}
		
	}
}