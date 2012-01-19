package semen.mvc.c {
    import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import semen.staff.Config;
    import semen.staff.GlobalDispatcher;

    /**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	
	public class SoundController {
		private static var _isSoundOn:Boolean = true;
		private static var _soundsChannels:Array = new Array();
		private static var _priorities:Array = ['step', 'catch', 'miss'];
		private static var _current:String = '';
		private static var _soundTransform:SoundTransform = new SoundTransform(Config.soundVolume);
        private static var _musicTransform:SoundTransform = new SoundTransform(Config.musicVolume);
        private static var _musicPlayheadPosition:Number = 0;
        private static var _musicChannel:SoundChannel;
        private static var _music:Sound;

        // static initializers
        {
            GlobalDispatcher.instance.addEventListener(GlobalDispatcher.PAUSE, pauseMusic);
            GlobalDispatcher.instance.addEventListener(GlobalDispatcher.UNPAUSE, playMusic);
        }

		private static var _soundsLibrary:Object = {
			'step': Class(StepSound), 
			'miss': Class(MissSound),
			'catch':Class(CatchSound)
		}
		
		static public function initMusic():void {
			_music = new Sound(new URLRequest(Config.backgroundMusicLink), new SoundLoaderContext(500));
            _musicPlayheadPosition = 0;
            playMusic();
        }
		
		static public function get isSoundOn():Boolean {
			return _isSoundOn;
		}
		
		static public function playSound(type:String):void {
			if (_soundsLibrary[type] && _isSoundOn && isPriority(type)) {
				_current = type;
				var sound:Sound = Sound(new _soundsLibrary[type]());
				var soundChannel:SoundChannel = sound.play(0, 0, _soundTransform);
				processChannel(soundChannel);
			}		
		}

        static public function stopMusic():void {
            _musicChannel.stop();
            _musicPlayheadPosition = 0;
        }

        static private function pauseMusic(e:Event = null):void {
            _musicPlayheadPosition = _musicChannel.position;
            _musicChannel.stop();
        }

        static private function playMusic(e:Event = null):void {
            if (_musicChannel) {
                _musicChannel.stop();
            }
            _musicChannel = _music.play(_musicPlayheadPosition, int.MAX_VALUE, _musicTransform);
        }
		
		static private function isPriority(type:String):Boolean {
			return (_priorities.indexOf(type) > _priorities.indexOf(_current));
		}
		
		static private function processChannel(soundChannel:SoundChannel):void {
			soundChannel.addEventListener(Event.SOUND_COMPLETE, killSoundChannel);
			_soundsChannels.push(soundChannel);
		}
		
		static private function killSoundChannel(e:Event):void {
			e.currentTarget.removeEventListener(e.type, killSoundChannel);
			var soundChannel:SoundChannel = SoundChannel(e.currentTarget);
			if (soundChannel) {
				soundChannel.stop();
				_soundsChannels.splice(_soundsChannels.indexOf(soundChannel), 1);
				_current = '';
			}
		}
		
		static private function switchMute():void {
			_isSoundOn = !_isSoundOn;
			if (!_isSoundOn) {
				if (!_music) {
					initMusic();
				}
				_musicChannel.stop();
			} else {
				_musicChannel = _music.play(_musicChannel.position, Number.POSITIVE_INFINITY, _soundTransform);
			}
		}
	}
}