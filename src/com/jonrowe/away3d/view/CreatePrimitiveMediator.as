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
		public var _view :CreatePrimitive;
		
		[Inject]
		public var sceneProxy :SceneProxy;
		
		
		
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
				view.addEventListener( CreatePrimitive.MAKE, onMake );
				view.addEventListener(CreatePrimitive.DUPLICATE, onDuplicate);
				view.addEventListener(CreatePrimitive.DELETE, onDelete);
				view.addEventListener(CreatePrimitive.IMPORT, onImport);
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
				sceneProxy.primitiveListSelection = view.selected;
				sceneProxy.createMeshGroup( sceneProxy.primitiveListSelection );
				dispatch(e.clone());
			}
		}
		
		private function onImport( e:Event ):void{
		}
		
		public function get view():CreatePrimitive{
			return _view;
		}
		
		public function set view( component:CreatePrimitive ):void{
			_view = component;
		}
	}
}