package testSuite
{
	import testSuite.tests.TestAsync;
	import testSuite.tests.TestCase1;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SampleSuite
	{
		public var t1:TestCase1;
		public var t2:TestAsync;
	}
}