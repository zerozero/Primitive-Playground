package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.meshGroupFactory.containers.Socrates;
	import com.jonrowe.away3d.model.SceneProxy;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class SocratesMediator extends Mediator
	{
		
		[Inject]
		public var _view :Socrates;

		[Inject]
		public var sceneProxy :SceneProxy;
		
		public function SocratesMediator()
		{
			super();
		}
		
		public function get view():Socrates{
			return _view;
		}
		
		public function set view( component:Socrates ):void{
			_view = component;
		}

	}
}