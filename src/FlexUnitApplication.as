package
{
	import Array;
	
	import flash.display.Sprite;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	import testSuite.tests.FileServiceTests;
	import testSuite.tests.MeshGroupFactoryTests;
	import testSuite.tests.SceneProxyTests;
	import testSuite.tests.SocketServiceTests;
	import testSuite.tests.TestAsyncBoilerplate;
	import testSuite.tests.TestAsyncSetupBoilerplate;
	import testSuite.tests.TestCaseBoilerplate;
	import testSuite.tests.TestSequencesBoilerplate;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			testRunner.portNumber=8765; 
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "Primitives_AS");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(testSuite.tests.FileServiceTests);
			testsToRun.push(testSuite.tests.MeshGroupFactoryTests);
			testsToRun.push(testSuite.tests.SceneProxyTests);
			testsToRun.push(testSuite.tests.SocketServiceTests);
			testsToRun.push(testSuite.tests.TestAsyncBoilerplate);
			testsToRun.push(testSuite.tests.TestAsyncSetupBoilerplate);
			testsToRun.push(testSuite.tests.TestCaseBoilerplate);
			testsToRun.push(testSuite.tests.TestSequencesBoilerplate);
			return testsToRun;
		}
	}
}