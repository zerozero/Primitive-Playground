package testSuite.tests
{
	import org.flexunit.Assert;

	public class TestCase1
	{
		private var count :int = 0;
		
		[Before]
		public function runBeforeEveryTest():void{
			count = 10;
			trace("runBeforeEveryTest",count);
		}
		
		[After]
		public function runAfterEveryTest():void{
			count = 0;
		}
		
		[Test]
		public function subtraction():void{
			Assert.assertEquals(8, count-2);
		}
		
		[Test(description="Test is supposed to Fail",issueID="0012443")]
		public function fails2():void {}
		
		[Test]
		public function simpleAdd():void{
			var x:int = 5 + 3;
			Assert.assertEquals(8,x);
		}
	}
}
