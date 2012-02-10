package
{
	
	
	
	import com.adobe.viewsource.ViewSource;
	import com.jonrowe.away3d.view.component.Canvas3D;
	import com.jonrowe.away3d.view.component.EditView;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class Main extends Sprite
	{
		public static const RESIZE :String = "stage_resize"; 
		
		public static const VERSION_STRING :String = "version 0.0.1";
		
		
		private var context :PrimitivesContext;
		private var asView3D :Canvas3D;
		
		
		public function Main()
		{
			super();
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