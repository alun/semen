package semen.mvc.c {
	import flash.media.Sound;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	
	public class SoundController {
		private static var _isSoundOn:Boolean = true;
		private static var _soundsChannels:Array = new Array();
		private static var soundsLibrary:Object = { 
			'step': Class(StepSound), 
			'miss': Class(MissSound),
			'catch':Class(CatchSound)
		}
		
		static public function get isSoundOn():Boolean {
			return _isSoundOn;
		}
		
		static public function playSound(type:String):void {
			if (soundsLibrary[type] && _isSoundOn) {
				var sound:Sound = Sound(new soundsLibrary[type]());
				_soundsChannels.push(sound.play());
			}
		}
	}
}