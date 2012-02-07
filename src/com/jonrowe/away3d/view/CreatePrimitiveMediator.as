package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.model.SceneProxy;
	import com.jonrowe.away3d.services.FileService;
	import com.jonrowe.away3d.services.IFileService;
	import com.jonrowe.away3d.view.component.gui.CreatePrimitive;
	import com.jonrowe.away3d.view.component.gui.ICreatePrimitveComponent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CreatePrimitiveMediator extends Mediator
	{
		
		[Inject]
		public var _view :ICreatePrimitveComponent;
		
		[Inject]
		public var sceneProxy :SceneProxy;
		
		[Inject]
		public var fileService :IFileService;
		
		public function CreatePrimitiveMediator()
		{
			super();
		}
		
		/**
		 * a new primitive component will be created for every primitive so this will
		 * get called every time a primitive is created
		 * initialize the gui view (cretae primitive section)
		 * This is a poor way to do this but is forced on us a bit by the nature of SimpleGUI
		 * 
		 */		
		override public function onRegister():void{
			
			if (!view.hasInitialized){
				view.initialize(sceneProxy.primitives);
				view.createChildren();
				Sprite(view).addEventListener( CreatePrimitive.MAKE, onMake );
				Sprite(view).addEventListener(CreatePrimitive.DUPLICATE, onDuplicate);
				Sprite(view).addEventListener(CreatePrimitive.DELETE, onDelete);
				Sprite(view).addEventListener(CreatePrimitive.IMPORT, onImport);
			}
		}
		
		private function onDelete( e:Event ):void{
			sceneProxy.deleteSelectedPrimitve();
		}
		
		private function onDuplicate( e:Event ):void{
			sceneProxy.duplicateSelectedPrimitve();
		}
		
		private function onMake( e:Event ):void{
			//make sure something has been selected
			if (view.selected){
				sceneProxy.primitiveListSelection = view.selected as String;
				sceneProxy.createPrimitveType( sceneProxy.primitiveListSelection );
			}
		}
		
		private function onImport( e:Event ):void{
			fileService.loadMesh();
		}
		
		public function get view():ICreatePrimitveComponent{
			return _view;
		}
	}
}