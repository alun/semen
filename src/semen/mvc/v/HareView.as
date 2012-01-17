package semen.mvc.v {
	import flash.display.MovieClip;
	import semen.mvc.m.HareModel;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class HareView {
		private var _movie:MovieClip;
		
		public function HareView(movie:MovieClip, model:HareModel) {
			_movie = movie
			model.addEventListener(RenderEvent.MODEL_CHANGED, renderView);
		}
		
		public function changeHareState():void {
			_movie.play();
		}
		
		private function renderView(e:RenderEvent):void {
			_movie.visible = HareModel(e.currentTarget).isVisible;
		}
		
	}

}