package
{
	import Array;
	
	import flash.display.Sprite;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	import org.flexunit.runner.Request;
	
	import testSuite.tests.TestAsync;
	import testSuite.tests.TestCase1;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "Primitives_AS");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(Request.methods(testSuite.tests.TestAsync,["timerShortWay",
				"testAsyncFail",
				"timerLongWay",
				"timerCount"]));
			
			testsToRun.push(Request.methods(testSuite.tests.TestCase1,["fails2",
				"simpleAdd",
				"subtraction"]));
			
			return testsToRun;
		}
	}
}