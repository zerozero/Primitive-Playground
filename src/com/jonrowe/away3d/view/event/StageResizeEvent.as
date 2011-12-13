package com.jonrowe.away3d.view.event
{
	import flash.events.Event;
	
	public class StageResizeEvent extends Event
	{
		public static const STAGE_RESIZE :String = "stage_resize";
		
		public function StageResizeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
	}
}