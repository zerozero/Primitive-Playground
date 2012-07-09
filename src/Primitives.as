package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0x333333")]
	public class Primitives extends Sprite
	{
		public function Primitives()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var context :PrimitivesContext  = new PrimitivesContext( this );
			
			var pp :Main = new Main();
			addChild(pp);

			stage.addEventListener( Event.RESIZE, pp.onStageResize );
		}
	}
}