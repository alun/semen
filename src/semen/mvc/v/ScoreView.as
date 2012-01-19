package semen.mvc.v {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import semen.mvc.m.ScoreModel;
	import semen.staff.Config;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class ScoreView {
		private var _scores:Scores;
		private var _lifes:MovieClip;
		private var _halfLifeTimer:Timer;
		private var _halfLife:DisplayObject;
		
		public function ScoreView(scores:Scores, lifes:MovieClip, model:ScoreModel) {
			_scores = scores;
			_lifes = lifes;
			_halfLifeTimer = new Timer(Config.halfLifeInterval);
			model.addEventListener(RenderEvent.MODEL_CHANGED, renderView);
			_halfLifeTimer.addEventListener(TimerEvent.TIMER, processHalfLife);
			_halfLifeTimer.start();
			for (var i:int = 0; i < 4; i++) {
				var place:TextField = _scores['score_' + i];
				place.selectable = false;
			}
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
			_halfLife = null;
			for (var i:int = 0; i < 4; i++) {
				if  (fails - i <= 0) {
					_lifes['life_' + i].visible = false;
				} else if (fails - i >= 1) {
					_lifes['life_' + i].visible = true;	
				} else {
					_halfLife = _lifes['life_' + i];
				}
			}
		}
		
		private function processHalfLife(e:TimerEvent):void {
			if (_halfLife) {
				_halfLife.visible = !_halfLife.visible;
			}
		}
	}
}