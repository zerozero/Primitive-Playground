package testSuite.tests
{
	import com.bit101.components.Component;
	import com.bit101.components.InputText;
	
	import flash.events.Event;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	public class TestAsyncSetupBoilerplate
	{
		public var textInput :InputText;
		
		[Before(async,ui)]
		public function setup():void{
			textInput = new InputText();
			Async.proceedOnEvent(this,textInput,Component.DRAW,1000);
			UIImpersonator.addChild(textInput);
		}
		
		[After(ui)]
		public function tearDown():void{
			UIImpersonator.removeChild(textInput);
			textInput = null;
		}
		
		[Test(async)]
		public function testSetTextProperty():void{
			var passThroughData:Object = new Object();
			passThroughData.propertyName = 'text';
			passThroughData.propertyValue = 'digitalprimates';	 
			textInput.addEventListener( Component.DRAW,
										Async.asyncHandler( this, handleVerifyProperty, 100, passThroughData, handleEventNeverOccurred ),
										false, 0, true );
			textInput.text = passThroughData.propertyValue;
		}

		protected function handleVerifyProperty( event:Event, passThroughData:Object ):void {
		}
		
		protected function handleEventNeverOccurred( passThroughData:Object ):void {
			Assert.fail('Pending Event Never Occurred');
		}
	}
}