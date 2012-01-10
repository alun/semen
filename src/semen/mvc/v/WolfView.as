package semen.mvc.v {
	import flash.display.DisplayObject;
	import semen.mvc.m.WolfModel;
	import semen.staff.RenderEvent;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class WolfView {
		private var _positions:Object;
		
		public function WolfView(positions:Object, model:WolfModel) {
			_positions = positions;
			model.addEventListener(RenderEvent.MODEL_CHANGED, renderView)
		}
		
		private function renderView(e:RenderEvent):void {
			var model:WolfModel = WolfModel(e.currentTarget);
			for (var posName:String in _positions) {
				_positions[posName].visible = model.positions[posName];
			}
		}
		
		
		
	}

}