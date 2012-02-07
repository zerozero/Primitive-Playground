package com.jonrowe.away3d.view.event
{
	import flash.events.Event;
	
	public class PrintMessageEvent extends Event
	{
		public static const PRINT_MESSAGE :String = "print_message";
		
		public var text :String;
		
		public function PrintMessageEvent(type:String, text :String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.text = text;
		}
		
		
	}
}