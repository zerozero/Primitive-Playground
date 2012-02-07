package
{
	import com.jonrowe.away3d.controller.CreateObjectCommand;
	import com.jonrowe.away3d.controller.NewMemberCommand;
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.model.event.*;
	import com.jonrowe.away3d.productFactory.primitives.*;
	import com.jonrowe.away3d.services.*;
	import com.jonrowe.away3d.services.event.*;
	import com.jonrowe.away3d.view.*;
	import com.jonrowe.away3d.view.component.*;
	import com.jonrowe.away3d.view.component.gui.*;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class PrimitivesContext extends Context
	{
		public function PrimitivesContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void{
			//primitives
			
			commandMap.mapEvent(SocketServiceEvent.NEW_MEMBER, NewMemberCommand, SocketServiceEvent, true);
			
			injector.mapSingletonOf(ISocketService,SocketService);
			injector.mapSingletonOf(IFileService,FileService);
			
			mediatorMap.mapView(EditView, EditViewMediator);
			mediatorMap.mapView(Primitive,PrimitiveMediator);
			mediatorMap.mapView(CreatePrimitive,CreatePrimitiveMediator,ICreatePrimitveComponent);
			mediatorMap.mapView(Canvas3D,Canvas3DMediator);
			
			mediatorMap.mapView(Main,ApplicationMediator);
			
			injector.mapSingleton(SceneProxy);
			super.startup();
			
		}
		
		//manually map mediators to primitives since primitives are not display objects and do not emit ADDED_TO_STAGE events
		public function createMediator( primitive :Object ):void{
			mediatorMap.createMediator(primitive);
			
		}
	}
}