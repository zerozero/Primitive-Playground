package testSuite
{
	import testSuite.tests.*;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SampleSuite
	{
		public var t1:TestCase1;
		public var t2:TestAsync;
		public var t3:TestAsyncSetup;
		public var t4:TestSequences;
	}
}