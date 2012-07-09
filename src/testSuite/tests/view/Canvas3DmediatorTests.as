package testSuite.tests.view
{
	import away3d.entities.Mesh;
	
	import com.jonrowe.away3d.meshGroupFactory.containers.event.MeshGroupEvent;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.view.Canvas3DMediator;
	import com.jonrowe.away3d.view.component.Canvas3D;
	
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	
	public class Canvas3DmediatorTests
	{
		private var instance :Canvas3DMediator;
		private var view:Canvas3D;
		private var sceneProxy :SceneProxy;
		
		[Before]
		public function setUp():void
		{
			instance = new Canvas3DMediator();
			
			view = new Canvas3D();
			instance.view = view;

			sceneProxy = new SceneProxy();
			sceneProxy.eventDispatcher = new EventDispatcher();
			instance.sceneProxy = sceneProxy;
			
			instance.setViewComponent(instance.view);
			instance.eventDispatcher = new EventDispatcher();
			instance.onRegister();
		}
		
		[After]
		public function tearDown():void
		{
			instance.view = null;
			instance.sceneProxy = null;
			instance = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		//MouseDown
		[Test (async)]
		public function OnMeshGroupMouseDown_EntityEvent_ENTITY_MOUSE_DOWN():void{
			
			sceneProxy.createMeshGroup("Cube");
			var meshGroup :IMeshGroupContainer3D = sceneProxy.primitiveObjects.getItemAt(0) as IMeshGroupContainer3D;
			var mesh :Mesh = meshGroup.meshes[0] as Mesh;
			
			var handler :Function = Async.asyncHandler(this, onHandleMouseDown, 500,meshGroup, onHandleTimeout);
			instance.eventDispatcher.addEventListener(MeshGroupEvent.MESH_GROUP_MOUSE_DOWN, handler);
			
			view.dispatchEvent(new MeshGroupEvent( MeshGroupEvent.MESH_GROUP_MOUSE_DOWN, meshGroup, mesh ) );
			
		}
		
		//MouseUp
		[Test (async)]
		public function OnMeshGroupMouseUp_EntityEvent_ENTITY_MOUSE_UP():void{
			
			sceneProxy.createMeshGroup("Cube");
			var meshGroup :IMeshGroupContainer3D = sceneProxy.primitiveObjects.getItemAt(0) as IMeshGroupContainer3D;
			var mesh :Mesh = meshGroup.meshes[0] as Mesh;
			
			var handler :Function = Async.asyncHandler(this, onHandleMouseUp, 500,meshGroup, onHandleTimeout);
			instance.eventDispatcher.addEventListener(MeshGroupEvent.MESH_GROUP_MOUSE_UP, handler);
			
			view.dispatchEvent(new MeshGroupEvent( MeshGroupEvent.MESH_GROUP_MOUSE_UP, meshGroup, mesh ) );
			
		}
		
		//MouseDown
		[Test (async)]
		public function OnMeshGroupMouseClick_EntityEvent_ENTITY_MOUSE_CLICK():void{
			
			sceneProxy.createMeshGroup("Cube");
			var meshGroup :IMeshGroupContainer3D = sceneProxy.primitiveObjects.getItemAt(0) as IMeshGroupContainer3D;
			var mesh :Mesh = meshGroup.meshes[0] as Mesh;
			
			var handler :Function = Async.asyncHandler(this, onHandleMouseClick, 500,meshGroup, onHandleTimeout);
			instance.eventDispatcher.addEventListener(MeshGroupEvent.MESH_GROUP_CLICK, handler);
			
			view.dispatchEvent(new MeshGroupEvent( MeshGroupEvent.MESH_GROUP_CLICK, meshGroup, mesh ) );
			
		}
		
		private function onHandleMouseDown( e:MeshGroupEvent, passThrough:Object ):void{
			Assert.assertEquals("event is correct type ", e.type, MeshGroupEvent.MESH_GROUP_MOUSE_DOWN );
			Assert.assertTrue( "meshgroups should match ", e.meshGroup, passThrough );
		}
		
		private function onHandleMouseUp( e:MeshGroupEvent, passThrough:Object ):void{
			Assert.assertEquals("event is correct type ", e.type, MeshGroupEvent.MESH_GROUP_MOUSE_UP );
		}
		
		private function onHandleMouseClick( e:MeshGroupEvent, passThrough:Object ):void{
			Assert.assertEquals("event is correct type ", e.type, MeshGroupEvent.MESH_GROUP_CLICK );
		}
		
		private function onHandleTimeout( passThrough:Object ):void{
			Assert.fail( "Timeout reached before event");	
		}
		
	}
}