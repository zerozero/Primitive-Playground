package com.jonrowe.away3d.view
{
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.view.component.gui.CreatePrimitive;
	import com.jonrowe.away3d.view.component.EditGUI;
	import com.jonrowe.away3d.view.component.EditView;
	import com.jonrowe.away3d.view.event.CreatePrimitiveEvent;
	import com.jonrowe.away3d.view.event.DuplicatePrimitiveEvent;
	import com.jonrowe.away3d.view.event.EntitySelectEvent;
	import com.jonrowe.away3d.view.event.StageResizeEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EditViewMediator extends Mediator
	{
		
		[Inject]
		public var _view :EditView;
		
		public function EditViewMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			addContextListener(EntitySelectEvent.ENTITY_SELECT, onSelectEntity);
			addContextListener(StageResizeEvent.STAGE_RESIZE, onStageResize);
			view.createChildren();
			view.addEventListener( CreatePrimitive.MAKE, onMake, true );
		}
		
		private function onSelectEntity( e:EntitySelectEvent ):void{
			view.createGUI(e.primitive);
			if (!view.hasEventListener(CreatePrimitive.DUPLICATE))
				view.addEventListener(CreatePrimitive.DUPLICATE, onDuplicate, true);
		}
		
		private function onDuplicate( e:Event ):void{
			dispatch( new DuplicatePrimitiveEvent(DuplicatePrimitiveEvent.DUPLICATE, view.editGUI.primitive as IPrimitive ));
		}
		
		private function onMake( e:Event ):void{
			var createPrimitiveView :CreatePrimitive = e.target as CreatePrimitive;
			dispatch( new CreatePrimitiveEvent(CreatePrimitiveEvent.CREATE, createPrimitiveView.selected as PrimitiveInit ));
		}
		
		private function onStageResize(e:StageResizeEvent):void{
			view.resize();
		}
		
		public function get view():EditView{
			return _view;
		}
	}
}