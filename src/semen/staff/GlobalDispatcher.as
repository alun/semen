package semen.staff 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class GlobalDispatcher extends EventDispatcher {
		static public const UNPAUSE:String = "unpause";
		static public const PAUSE:String = "pause";
		static private var _instance:GlobalDispatcher;
		private var _isPaused:Boolean = false;
		
		
		public static function get instance():GlobalDispatcher {
			if (!_instance) { _instance = new GlobalDispatcher() }
			return _instance;
		}
		
		public function get isPaused():Boolean {
			return _isPaused;
		}
		
		public function GlobalDispatcher() {
			
		}
		
		public function pause():void {
			_isPaused = true;
			dispatchEvent(new Event(GlobalDispatcher.PAUSE));
		}
		
		private function unPause():void {
			_isPaused = false;
			dispatchEvent(new Event(GlobalDispatcher.UNPAUSE));
		}
		
		public function changePauseMode():void {
			if (isPaused) {
				unPause();
			} else {
				pause();
			}
		}

	}
}