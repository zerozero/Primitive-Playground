package testSuite.tests
{
	import away3d.library.AssetLibrary;
	import away3d.loaders.Loader3D;
	
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.services.FileService;
	import com.jonrowe.away3d.services.event.Loader3DEvent;
	
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	
	public class FileServiceTests
	{		
		private var files :FileService;
		private var serviceDispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			files = new FileService();
			FileService(files).eventDispatcher = serviceDispatcher;
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
		
		[Test]
		public function testServiceExists_ServiceNotNull():void{
			Assert.assertNotNull(files);
		}
		
		[Test]
		public function loadEmbeddedMesh_MeshNotNull():void{
			files.loadMesh();
			Assert.assertNotNull(files.loadedMesh);
		}
		
		[Test(async)]
		public function loadEmbeddedMesh_Loader3DNotNull():void{
			var asyncHandler:Function = Async.asyncHandler( this, loadEmbeddedMeshResult, 500, null, handleTimeout );
			files.eventDispatcher.addEventListener( Loader3DEvent.DISPLAY, asyncHandler, false, 0, true );
			files.loadMesh();
		}
		
		private function loadEmbeddedMeshResult( e:Loader3DEvent, passThroughData:Object ):void{
			Assert.assertTrue("type should be Loader3D", e.data is IPrimitive);
		}
		
		[Test]
		public function loadEmbeddedMeshToLibrary_AssetCharacterIsLoaded():void{
			files.loadMesh();
			Assert.assertTrue("Should not be null ", AssetLibrary.getAsset("Character") != null);
		}
		
		
		protected function handleTimeout( passThroughData:Object ):void {
			Assert.fail( "Timeout reached before event");	
		}
	}
}