package testSuite.tests.view
{
	import com.jonrowe.away3d.meshGroupFactory.containers.MeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.containers.Primitive;
	import com.jonrowe.away3d.view.PrimitiveMediator;
	
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	public class MeshGroupContainer3DTests
	{	
		private var instance :PrimitiveMediator;
		
		[Before]
		public function setUp():void
		{
			instance = new PrimitiveMediator();
			instance.view = new Primitive();
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
		
		[Test]
		public function testAppendMesh():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testApplyMaterial():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testCreate():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testDeleteObject():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testLight():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_meshContainer():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_meshContainer():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_meshes():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testMovePivot():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_pivotPoint():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_meshGroupName():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_meshGroupName():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_selected():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_selected():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_type():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_type():void
		{
			Assert.fail("Test method Not yet implemented");
		}
	}
}