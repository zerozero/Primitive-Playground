package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.view.event.PrintMessageEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class PlaygroundMediator extends Mediator
	{
		
		[Inject]
		public var _view :Primitives;
		
		
		
		public function PlaygroundMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			addContextListener( PrintMessageEvent.PRINT_MESSAGE, onPrintMessage );
			
		}
		
		private function onPrintMessage ( e:PrintMessageEvent ):void{
		}
		
		public function get view():Primitives{
			return _view;
		}
		
	}
}