package com.jonrowe.away3d.view.component.gui
{
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	
	import flash.display.Sprite;
	import flash.events.TextEvent;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class LoginForm extends Sprite
	{
		private var gui :SimpleGUI;
		
		public var username :InputText;
		public var password :InputText;
		public var loginBtn :PushButton;
		
		public static const LOGIN :String = "loginRequested";
		
		public function LoginForm()
		{
			super();
			createChildren();
		}
		
		
		private function createChildren():void{
			gui = new SimpleGUI(this, null, "o");
			
			username = gui.addControl(InputText, {label:"username", width:64}) as InputText;
			password = gui.addControl(InputText, {label:"username", width:64}) as InputText;
			loginBtn = gui.addControl(PushButton,{label:"Login",callback:onLogin}) as PushButton;
			gui.show();
		}
		
		protected function onLogin():void{
			dispatchEvent( new TextEvent(LOGIN, false,false,password.text));
		}
		
		
	}
}