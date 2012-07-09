package testSuite.tests
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class TestAsyncBoilerplate
	{
		private var timer :Timer;
		
		[Before]
		public function setup():void{
			timer = new Timer(100,1);
		}
		
		[After]
		public function tearDown():void{
			if (timer )
				timer.stop();
			timer = null;
			
		}
		
		[Test(async, description="Async Example")]
		public function timerLongWay():void{
			var asyncHandler:Function = Async.asyncHandler( this, handleTimerComplete, 500, null, handleTimeout );
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler, false, 0, true );
			timer.start();
		}
		
		protected function handleTimerComplete( event:TimerEvent, passThroughData:Object ):void {
			
		}
		
		protected function handleTimeout( passThroughData:Object ):void {
			Assert.fail( "Timeout reached before event");	
		}
		
		[Ignore]
		[Test(async, description="An async test that will fail")]
		public function testAsyncFail() : void {
			timer.delay = 1000;
			var asyncHandler:Function = Async.asyncHandler( this, handleTimerComplete, 500, null, handleTimeout );
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler, false, 0, true );
			timer.start();	
		}
		
		[Test(async)]
		public function timerShortWay():void {
			timer.delay = 100;
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, 
				Async.asyncHandler( this, handleTimerComplete, 500, null, handleTimeout ), false, 0, true );
			timer.start();			
		}
		
		[Test (async)]
		public function timerCount() : void {
			var o:Object = new Object();
			o.repeatCount = 3;
			
			timer.repeatCount = o.repeatCount;
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, 
				Async.asyncHandler(this, handleTimerCheckCount, 500, o, handleTimeout ), false, 0, true );
			timer.start();	
		}
		
		protected function handleTimerCheckCount( event:TimerEvent, passThroughData:Object ):void {
			Assert.assertEquals( ( event.target as Timer ).currentCount, passThroughData.repeatCount );
		}

	}
}