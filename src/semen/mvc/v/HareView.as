package semen.mvc.v {
	import flash.display.DisplayObject;
	import semen.mvc.m.HareModel;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class HareView {
		private var _movie:DisplayObject;
		
		public function HareView(movie:DisplayObject, model:HareModel) {
			_movie = movie
			model.addEventListener(RenderEvent.MODEL_CHANGED, renderView);
		}
		
		private function renderView(e:RenderEvent):void {
			_movie.visible = HareModel(e.currentTarget).isVisible;
		}
		
	}

}