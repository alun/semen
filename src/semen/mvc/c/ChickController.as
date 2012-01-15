package semen.mvc.c {
	import flash.events.Event;
	import semen.staff.Config;
	import semen.staff.EggEvent;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import semen.mvc.m.ChickModel;
	import semen.mvc.v.ChickView;
	import semen.staff.GlobalDispatcher;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Ilja Mickodin mka BuKT
	 */
	public class ChickController extends EventDispatcher {
		private var _model:ChickModel;
		private var _view:ChickView;
		private static var _timer:Timer;
		
		public function ChickController(chickView:MovieClip) {
			_model = new ChickModel();
			_view = new ChickView(chickView, _model);
			if (!_timer) {
				_timer = new Timer(Config.eggsVelocity, 0);
			}
			_timer.addEventListener(TimerEvent.TIMER, moveEggs);
			flushAll();
		}
		
		private function moveEggs(e:TimerEvent):void {
			var places:Array = _model.places;
			var fall:Array = _model.fall;
            var eggFall:Boolean = false;
			for (var i:int = fall.length - 1; i > 0; i--) {
				fall[i] = fall[i - 1];
			} 
			fall[0] = false;
            eggFall = places[places.length - 1];
			for (i = places.length - 1; i > 0; i--) {
				places[i] = places[i - 1];
			} 
			places[0] = false;
			_model.fall = fall;
			_model.places = places;
            if (eggFall) {
                dispatchEvent(new EggEvent(EggEvent.EGG_FALL));
            }
        }
		
		public function fall():void {
			var fall:Array = _model.fall; 
			fall[0] = true;
			_model.fall = fall;
			_model.places = _model.places;
		}
		
		public function addEgg():Boolean {
			var places:Array = _model.places;
			if (places[0]) {
				return false;
			}
			places[0] = true;
			_model.places = places;
			return _model.places[0];
		}
		
		public function start():void {
			_timer.start();
		}
		
		public function getReady():void {
			_model.dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
			GlobalDispatcher.instance.addEventListener(GlobalDispatcher.PAUSE, pauseAll);
			GlobalDispatcher.instance.addEventListener(GlobalDispatcher.UNPAUSE, unpauseAll);
		}
		
		private function unpauseAll(e:Event):void {
			_timer.start();
		}
		
		private function pauseAll(e:Event):void {
			_timer.stop();
		}
		
		public static function speedUp():void {
			_timer.stop();
			_timer.reset();
			_timer.delay /= 1 + Config.eggsVelocityMultiplier;
			_timer.start();
		}
		
		public function flushAll():void {
			_model.flushModel();
			_timer.stop();
			_timer.reset();
			_timer.delay = Config.eggsVelocity;
		}
	}
}