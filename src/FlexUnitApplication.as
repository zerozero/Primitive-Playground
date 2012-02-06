package
{
	import Array;
	
	import flash.display.Sprite;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	import testSuite.AutoCreatedSuite;
	import testSuite.tests.PrimitiveModelTest;
	
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
			testsToRun.push(testSuite.AutoCreatedSuite);
			testsToRun.push(testSuite.tests.PrimitiveModelTest);
			return testsToRun;
		}
	}
}