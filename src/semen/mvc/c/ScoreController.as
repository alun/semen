package semen.mvc.c {
	import semen.staff.Config;
	import semen.staff.GameEvent;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import semen.mvc.m.ScoreModel;
	import semen.mvc.v.ScoreView;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class ScoreController extends EventDispatcher {
		private var _model:ScoreModel;
		private var _view:ScoreView;
		
		public function ScoreController(scores:Scores, lifes:MovieClip) {
			_model = new ScoreModel();
			_view = new ScoreView(scores, lifes, _model);
		}
		
		public function removeLife(_isHare:Boolean):void {
			_model.removeLife(_isHare);
			if (_model.fails >= Config.maxFailsPerGame) {
				dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
			}
		}
		
		public function addPoint():void {
			_model.addPoint();
 			if (Config.flushFailsScores.indexOf(String(_model.scores)) > -1) {
				_model.flushFails();
			}
			if (_model.scores % Config.pointsToSpeedUp == 0) {
				dispatchEvent(new GameEvent(GameEvent.SPEED_UP));
			}
		}
		
		public function getReady():void {
			_model.dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function flushAll():void {
			_model.flushAll();
		}
		
	}

}