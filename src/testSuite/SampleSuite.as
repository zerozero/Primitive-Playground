package testSuite
{
	import testSuite.tests.*;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SampleSuite
	{
		public var t1:TestCaseBoilerplate;
		public var t2:TestAsyncBoilerplate;
		public var t3:TestAsyncSetupBoilerplate;
		public var t4:TestSequencesBoilerplate;
	}
}