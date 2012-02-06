package com.jonrowe.away3d.view.component.gui
{
	import away3d.containers.ObjectContainer3D;
	import away3d.primitives.Plane;
	
	import com.bit101.components.Component;
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.geom.Vector3D;
	
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