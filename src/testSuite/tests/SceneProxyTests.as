package testSuite.tests
{
	import away3d.entities.Mesh;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PrimitiveBase;
	
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupType;
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.Primitive;
	import com.jonrowe.away3d.meshGroupFactory.containers.TransformWidget;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.view.event.*;
	
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class SceneProxyTests
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
		
		[Test (description="Primitives list is null by default, is conditionally created the first time it is accessed")]
		public function GetPrimitivesList_PrimitivesListNull_PrimitivesListNotNull():void{
			Assert.assertNull(primitives);
			var primitives :Object = sceneProxy.primitives;
			Assert.assertNotNull(primitives);
		}
		
		
		[Test(async, description="Create a primitive type Mesh Group init with string")]
		public function CreateMeshGroup_InitWithString_PrimitiveNotNull():void{
			
			var asyncHandler:Function = Async.asyncHandler( this, CreatePrimitiveTypeMeshGroupResult, 500, null, handleTimeout );
			sceneProxy.eventDispatcher.addEventListener( DisplayPrimitiveEvent.DISPLAY, asyncHandler, false, 0, true );
			sceneProxy.createMeshGroup( "Cube" );
		}
		
		
		private function CreatePrimitiveTypeMeshGroupResult( e:DisplayPrimitiveEvent, passThroughData:Object ):void{
			var primitives :Object = sceneProxy.primitives;
			Assert.assertTrue("type should be Primitive", e.primitive is Primitive);
			Assert.assertTrue("mesh geometry should be Cube Geometry", Mesh(e.primitive.meshes[0]).geometry is CubeGeometry);
			Assert.assertTrue("Should be one object in the primitivesCollection ", sceneProxy.primitiveObjects.length == 1);
		}
		
		[Test]
		public function CreateTransformWidget_ReturnTransformWidget():void{
			var tw :TransformWidget = sceneProxy.createTransformWidget() as TransformWidget;
			Assert.assertNotNull("should not be null",tw);
		}
		
		
		[Test(async, description="Delete Primitive")]
		public function testDeletePrimitive():void{
			//inits list of primitives if not yet defined
			var primitives :Object = sceneProxy.primitives;
			//create a mock primitive
			
			sceneProxy.createMeshGroup("Cube");
			//set it as the selected primitive
			sceneProxy.selectedPrimitive = sceneProxy.primitiveObjects[0] as IMeshGroupContainer3D;
			
			//test deletion
			var asyncHandler:Function = Async.asyncHandler( this, testDeletePrimitiveResult, 500, null, handleTimeout );
			sceneProxy.eventDispatcher.addEventListener( DisplayPrimitiveEvent.REMOVE, asyncHandler, false, 0, true );
			sceneProxy.deleteSelectedPrimitve( );
		}
		
		private function testDeletePrimitiveResult( e:DisplayPrimitiveEvent, passThroughData:Object ):void{
			var primitives :Object = sceneProxy.primitives;
			Assert.assertTrue("mesh geometry should be Cube Geometry", Mesh(e.primitive.meshes[0]).geometry is CubeGeometry);
			Assert.assertTrue("Should be no objects in the primitivesCollection ", sceneProxy.primitiveObjects.length == 0);
		}
		
		
		
		protected function handleTimeout( passThroughData:Object ):void {
			Assert.fail( "Timeout reached before event");	
		}
		
	}
}