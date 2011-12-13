package
{
	import com.jonrowe.away3d.productFactory.primitives.*;
	import com.jonrowe.away3d.view.*;
	import com.jonrowe.away3d.view.component.*;
	
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
			mediatorMap.mapView(EditView, EditViewMediator);
			mediatorMap.mapView(Main,ApplicationMediator);
			mediatorMap.mapView(Primitive,PrimitiveMediator);
			super.startup();
			//gui
		}
		
		//manually map mediators to primitives since primitives are not display objects and do not emit ADDED_TO_STAGE events
		public function createMediator( primitive :Object ):void{
			mediatorMap.createMediator(primitive);
			
		}
	}
}