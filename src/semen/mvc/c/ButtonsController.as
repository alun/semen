package semen.mvc.c { 

	import semen.staff.ButtonEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import semen.mvc.m.ButtonsModel;
	import semen.mvc.v.ButtonsView;
	import semen.staff.RenderEvent;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	
	public class ButtonsController extends EventDispatcher{
		private var _model:ButtonsModel;
		private var _view:ButtonsView;
		private var _controlledObject:WolfController;
		
		public function ButtonsController(buttonsViews:Object, controlledObject:WolfController) {
			_controlledObject = controlledObject;
			_model = new ButtonsModel();
			_view = new ButtonsView(buttonsViews, _model);
			_view.addEventListener(ButtonEvent.CLICKED, buttonClickedListener);
			_view.addEventListener(ButtonEvent.DEACTIVATED, buttonDeactivateListener);
		}
		
		public function getReady():void {
			_model.dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function stopAll():void {
			
		}
		
		private function buttonDeactivateListener(e:ButtonEvent):void {
			_model.up(e.side);
		}
		
		private function buttonClickedListener(e:ButtonEvent):void {
			_model.down(e.side);
			_controlledObject.position = e.side;
		}
		
		private function initListeners(e:Event = null):void {
			//addEventListener(MouseEvent.MOUSE_DOWN, down);
			//stage.addEventListener(MouseEvent.MOUSE_UP, up);
		}
	}
}