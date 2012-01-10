package semen.mvc.v {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import semen.mvc.m.ScoreModel;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class ScoreView {
		private var _scores:Scores;
		private var _lifes:MovieClip;
		
		public function ScoreView(scores:Scores, lifes:MovieClip, model:ScoreModel) {
			_scores = scores;
			_lifes = lifes;
			
			model.addEventListener(RenderEvent.MODEL_CHANGED, renderView);
		}
		
		private function renderView(e:RenderEvent):void {
			var model:ScoreModel = ScoreModel(e.currentTarget);
			renderScore(model.scores);
			renderLifes(model.fails);
		}
		
		private function renderScore(scores:Number):void {
			for (var i:int = 0; i < 4; i++) {
				var place:TextField = _scores['score_' + i];
				var value:int = scores % 10;
				place.text = String(value);
				scores /= 10;
			}
		}
		
		private function renderLifes(fails:Number):void {
			for (var i:int = 0; i < 4; i++) {
				_lifes['life_' + i].alpha = (fails - i);
			}
		}
		
	}

}