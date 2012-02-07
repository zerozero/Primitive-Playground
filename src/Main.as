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
	import com.jonrowe.away3d.view.component.Canvas3D;
	import com.jonrowe.away3d.view.component.EditView;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	
	public class Main extends Sprite
	{
		public static const RESIZE :String = "stage_resize"; 
		
		public static const VERSION_STRING :String = "version 0.0.1";
		
		
		private var context :PrimitivesContext;
		private var asView3D :Canvas3D;
		
		
		public function Main()
		{
			//visible = false;
			//createContext();
		}
		
		
		public function get params():Object{
			return LoaderInfo(this.root.loaderInfo).parameters;
		}
		
		
		//called from the applicationMediator
		public function createChildren():void{
			createGUI();
			create3DView();
			ViewSource.addMenuItem(this, "srcview/index.html"); 
			visible = true;
			onStageResize();
		}
		
		
		/*			PRIVATE			*/
		
		public function onStageResize(e:Event = null):void{
			asView3D.setSize( stage.stageWidth - 160, stage.stageHeight );
			dispatchEvent( new Event( RESIZE ));
		}
		
		private function createContext():void{
			context = new PrimitivesContext( this );
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