package semen.mvc.v {
	import flash.display.DisplayObjectContainer;
	import semen.mvc.m.ChickModel;
	import semen.staff.RenderEvent;
	/**
	 * ...
	 * @author Ilja Mickodin mka BuKT
	 */
	public class ChickView {
		private var _movie:DisplayObjectContainer;
		
		public function ChickView(movie:DisplayObjectContainer, model:ChickModel) {
			_movie = movie;
			model.addEventListener(RenderEvent.MODEL_CHANGED, renderView);
		}
		
		private function renderView(e:RenderEvent):void {
			var model:ChickModel = ChickModel(e.currentTarget);
			for (var i:int = 0; i < 4; i++) {
				_movie['egg_' + i].visible = model.places[i];
				_movie['fall_' + i].visible = model.fall[i];
			}
		}
		
	}

}