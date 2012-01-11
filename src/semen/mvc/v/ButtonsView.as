package semen.mvc.v {
	import semen.staff.ButtonEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import semen.mvc.m.ButtonsModel;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class ButtonsView extends EventDispatcher {
		private var _movies:Object;
		private var _keysidesTranslation:Object = {
			65 : 'ul',
			90 : 'dl',
			75 : 'ur',
			77 : 'dr',
			78 : 'ng',
			80 : 'pp'
		}
		
		public function ButtonsView(buttonsViews:Object, model:ButtonsModel) {
			_movies = buttonsViews;
			model.addEventListener(RenderEvent.MODEL_CHANGED, renderView);
			initClickListeners();
		}
		
		private function renderView(e:RenderEvent):void {
			var model:ButtonsModel = ButtonsModel(e.currentTarget);
			
			for (var side:String in _movies) {
				var button:MovieClip = _movies[side];
				button.gotoAndStop(model.states[side]);
			}
		}
		
		private function initClickListeners():void {
			var side:String;
			for (side in _movies) {
				_movies[side].side = side;
				_movies[side].addEventListener(MouseEvent.MOUSE_DOWN, clickListener);
				_movies[side].stop();
			}
			_movies[side].stage.addEventListener(KeyboardEvent.KEY_DOWN, keyListener);
			_movies[side].stage.addEventListener(KeyboardEvent.KEY_UP, keyListener);
		}
		
		private function keyListener(e:KeyboardEvent):void {
			var event:ButtonEvent = new ButtonEvent((e.type == KeyboardEvent.KEY_UP) ? ButtonEvent.DEACTIVATED : ButtonEvent.CLICKED);
			event.side = _keysidesTranslation[e.keyCode];
			if (event.side) {
				dispatchEvent(event);
			}
		}
		
		private function clickListener(e:MouseEvent):void {
			var button:MovieClip = MovieClip(e.currentTarget);
			var event:ButtonEvent = new ButtonEvent(ButtonEvent.CLICKED);
			event.side = button.side;
			dispatchEvent(event);
			button.stage.addEventListener(MouseEvent.MOUSE_UP, deactivateButton);
		}
		
		private function deactivateButton(e:MouseEvent):void {
			Stage(e.currentTarget).removeEventListener(e.type, deactivateButton);
			dispatchEvent(new ButtonEvent(ButtonEvent.DEACTIVATED));
		}
		
	}

}