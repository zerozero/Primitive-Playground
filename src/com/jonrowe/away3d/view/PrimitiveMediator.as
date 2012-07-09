package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.meshGroupFactory.containers.Primitive;
	import com.jonrowe.away3d.model.SceneProxy;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class PrimitiveMediator extends Mediator
	{
		
		[Inject]
		public var _view :Primitive;

		[Inject]
		public var sceneProxy :SceneProxy;
		
		public function PrimitiveMediator()
		{
			super();
		}
		
		
		public function get view():Primitive{
			return _view;
		}
		
		public function set view( component:Primitive ):void{
			_view = component;
		}
		
	}
}