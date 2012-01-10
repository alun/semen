package semen.mvc.c {
	import semen.staff.Config;
	import semen.staff.EggEvent;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import semen.mvc.m.ChickModel;
	import semen.mvc.v.ChickView;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Ilja Mickodin mka BuKT
	 */
	public class ChickController extends EventDispatcher {
		private var _model:ChickModel;
		private var _view:ChickView;
		private var _timer:Timer;
		private var counter:Number = 0;
		
		public function ChickController(chickView:MovieClip) {
			_model = new ChickModel();
			_view = new ChickView(chickView, _model);
			_timer = new Timer(Config.eggsVelocity, 0);
			_timer.addEventListener(TimerEvent.TIMER, moveEggs);
		}
		
		public function moveEggs(e:TimerEvent):void {
			var places:Array = _model.places;
			if (places[places.length - 1]) {
				dispatchEvent(new EggEvent(EggEvent.EGG_FALL));
			}
			for (var i:int = places.length - 1; i > 0; i--) {
				places[i] = places[i - 1];
			} 
			places[0] = false;
			_model.places = places;
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
		}
		
		public function stopAll():void {
			_timer.stop();
			_timer.reset();
			_timer.delay = Config.eggsVelocity;
		}
		
		public function speedUp():void {
			_timer.delay /= 1 + Config.eggsVelocityMultiplier;
		}
		
	}
}