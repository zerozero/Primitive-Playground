package testSuite.tests
{
	import away3d.entities.Mesh;
	import away3d.primitives.CapsuleGeometry;
	
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupFactory;
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupFactoryError;
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupType;
	import com.jonrowe.away3d.meshGroupFactory.MeshGroupTypeMap;
	import com.jonrowe.away3d.meshGroupFactory.containers.Primitive;
	import com.jonrowe.away3d.meshGroupFactory.containers.Socrates;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.services.FileService;
	
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	public class MeshGroupFactoryTests
	{		
		[Before]
		public function setUp():void
		{
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
		
		
		[Test(description="Create a primitive type Mesh Group, init with string")]
		public function CreatePrimtiveMeshGroup_InitWithString_PrimitiveNotNull():void{
			var type :String = "CapsuleGeometry";
			var meshGroup :IMeshGroupContainer3D = new MeshGroupFactory( new MeshGroupTypeMap() ).getProduct( Primitive.hasType( type ) ? MeshGroupType.PRIMITIVE : type );
			meshGroup.type = type;
			
			Assert.assertNotNull("Should not be null",meshGroup);
			Assert.assertTrue("Should be Primitive", meshGroup is Primitive);
			Assert.assertTrue("Type should be CapsuleGeometry "+meshGroup.type,meshGroup.type == "CapsuleGeometry");
			Assert.assertNotNull("Mesh should be capsule", CapsuleGeometry(Mesh(meshGroup.meshes[0]).geometry));
		}
		
		
		[Test(description="Create a Mesh Group, init with unknown string", expects="com.jonrowe.away3d.meshGroupFactory.MeshGroupFactoryError")]
		public function CreatePrimtiveMeshGroup_InitWithUnknownString_MeshGroupFactoryError():void{
			var type :String = "foo";
			
			var meshGroup :IMeshGroupContainer3D = new MeshGroupFactory( new MeshGroupTypeMap() ).getProduct( Primitive.hasType( type ) ? MeshGroupType.PRIMITIVE : type );
			Assert.assertFalse("A MeshGroupFactoryError was expected but not thrown");
		}
		
		//create a complex (imported) meshgroup
		[Test(description="Create a Mesh Group, meshes present in AssetLib")]
		public function CreateLoadedMeshGroup_ModelImported_MeshGroupCreated():void{
			var type :String = MeshGroupType.SOCRATES;
			
			var fs :FileService = new FileService();
			fs.eventDispatcher = new EventDispatcher();
			fs.loadMesh();
			var meshGroup :IMeshGroupContainer3D = new MeshGroupFactory( new MeshGroupTypeMap() ).getProduct( Primitive.hasType( type ) ? MeshGroupType.PRIMITIVE : type );
			
			Assert.assertNotNull("Should not be null",meshGroup);
			Assert.assertTrue("Should be a Socrates object", meshGroup is Socrates);
		}
		
		//create a complex meshgroup with missing mesh defs
		
		[Test(description="Create a Mesh Group, meshes not present in AssetLib", expects="com.jonrowe.away3d.meshGroupFactory.MeshGroupFactoryError")]
		public function CreateLoadedMeshGroup_ModelNotImported_MeshGroupFactoryError():void{
			var type :String = MeshGroupType.SOCRATES;
			var meshGroup :IMeshGroupContainer3D = new MeshGroupFactory( new MeshGroupTypeMap() ).getProduct( type );
			Assert.assertFalse("A MeshGroupFactoryError was expected but not thrown");
		}
		
		
	}
}