package testSuite.tests
{
	import com.bit101.components.Component;
	import com.jonrowe.away3d.view.component.gui.LoginForm;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	import org.flexunit.internals.runners.statements.SequencerWithDecoration;
	import org.fluint.sequence.*;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	
	/**
	 * I've had to explicitly create a new fluint 4 directory andf import the old fluint stuf from fb4
	 * since most of the sequence stuff is absent from the flexunit 4.1 swc
	 * Also had to set a CONFIG compiler option to prevent adding flexClasses.
	 * Not sure if this is correct but seems to work - 
	 * - hopefully will be able to utilise the sequence stuff for unit testing Away3D objects? 
	 * @author jonrowe
	 * 
	 */	
	public class TestSequencesBoilerplate
	{
		
		public var form :LoginForm;
		
		[Before(async, ui)]
		public function setUp():void {
			form = new LoginForm();
			
			/* form.addEventListener( FlexEvent.CREATION_COMPLETE, Async.asyncHandler( pendUntilComplete, 100 ), false, 0, true );  */
			form.addEventListener( Event.ADDED, Async.asyncHandler( this, pendUntilComplete, 100 ), false, 0, true );
			UIImpersonator.addChild( form );
		}
		
		protected function pendUntilComplete(event:Event, passThroughData:Object):void{
			trace("pendUntilComplete");
		}
		
		[After(async, ui)]
		public function tearDown():void {
			UIImpersonator.removeChild( form );                    
			form = null;
		}
		
		import org.fluint.sequence.*;
		
		[Test(async, ui)]
		public function testLogin():void {
               var passThroughData:Object = new Object();
               passThroughData.username = 'myuser1';
               passThroughData.password = 'somepsswd';

               var sequence:SequenceRunner = new SequenceRunner( this );
			   
				//fluint library was throwing errors after upgrade to FB4.6 so these are removed - 
               /*sequence.addStep( new SequenceSetter( form.username, {text:passThroughData.username} ) );
               sequence.addStep( new SequenceWaiter( form.username, Component.DRAW, 100 ) );

              sequence.addStep( new SequenceSetter( form.password, {text:passThroughData.password} ) );
              sequence.addStep( new SequenceWaiter( form.password, Component.DRAW, 100 ) );

              sequence.addStep( new SequenceEventDispatcher( form.loginBtn, new MouseEvent( 'click', true, false ) ) );
              sequence.addStep( new SequenceWaiter( form, 'loginRequested', 100 ) );*/
                      
              sequence.addAssertHandler( handleLoginEvent, passThroughData );
                      
              sequence.run();
      }
		
		protected function handleLoginEvent( event:TextEvent, passThroughData:Object ):void {
			Assert.assertEquals( passThroughData.password, event.text );
			//Viewer's comment: Should this not be Assert.assertEquals?
		}
	}
}