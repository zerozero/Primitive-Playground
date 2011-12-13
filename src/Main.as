package
{
	
	
	
	import away3d.primitives.Cube;
	
	import com.adobe.viewsource.ViewSource;
	import com.bit101.components.Accordion;
	import com.bit101.components.ComboBox;
	import com.bit101.components.PushButton;
	import com.bit101.components.VScrollBar;
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.ProductType;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.primitives.Primitive;
	import com.jonrowe.away3d.productFactory.primitives.PrimitiveObjectBase;
	import com.jonrowe.away3d.view.component.EditView;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import uk.co.soulwire.gui.SimpleGUI;
	import com.jonrowe.away3d.view.component.Canvas3D;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0x727272")]
	public class Main extends Sprite
	{
		public static const RESIZE :String = "stage_resize"; 
		
		
		private var context :PrimitivesContext;
		private var asView3D :Canvas3D;
		
		
		public function Main()
		{
			visible = false;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener( Event.RESIZE, onStageResize );
			
			createContext();
			createChildren();
		}
		
		//called from the applicationMediator
		public function createChildren():void{
			create3DView();
			createGUI();
			createDefaultObject();
			ViewSource.addMenuItem(this, "srcview/index.html"); 
			onStageResize();
			visible = true;
		}
		
		
		public function duplicate( primitive :IPrimitive ):void{
			
			var dupe :IPrimitive = asView3D.duplicateObject( primitive );
			context.createMediator(Primitive(dupe));
		}
		
		public function create( init:PrimitiveInit ):void{
			var primitive :IPrimitive = asView3D.createObject(ProductType.PRIMITIVE, init);
			context.createMediator(Primitive(primitive));
		}
		
		/*			PRIVATE			*/
		
		private function onStageResize(e:Event = null):void{
			asView3D.setSize( stage.stageWidth - 160, stage.stageHeight );
			dispatchEvent( new Event( RESIZE ));
		}
		
		private function createContext():void{
			context = new PrimitivesContext( this );
		}
		
		
		private function createDefaultObject():void{
			
			var primitiveInit :PrimitiveInit = new PrimitiveInit(Cube,PrimitiveObjectBase.DEFAULT_MATERIAL ,{});
			var cube :IPrimitive = asView3D.createObject( ProductType.PRIMITIVE, primitiveInit );
			context.createMediator(Primitive(cube));
		}
		
		
		private function create3DView():void{
			
			asView3D = new Canvas3D();
			asView3D.x = 160;
			addChild (asView3D);
			
		}
		
		private function createGUI():void{
			
			var guiView :EditView = new EditView();
			addChild(guiView);
		}
		
		/*		EVENT		*/
		
		
		
	
	}
}