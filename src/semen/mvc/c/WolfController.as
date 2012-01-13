package semen.mvc.c {
	import semen.mvc.m.WolfModel;
	import semen.mvc.v.WolfView;
	import semen.staff.RenderEvent;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class WolfController {
		private var _model:WolfModel;
		private var _view:WolfView;
		
		public function WolfController(views:Object) {
			_model = new WolfModel();
			_view = new WolfView(views, _model);
			flushAll();
		}
		
		public function getReady():void {
			_model.dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function flushAll():void {
			_model.flushAll();
		}
		
		public function set position(value:String):void {
			_model.changePosition(value);
		}
		
		public function get position():String {
			return _model.position;
		}
	}
}