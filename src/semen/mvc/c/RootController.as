package semen.mvc.c {
	import flash.events.Event;
	import semen.staff.ButtonEvent;
	import semen.staff.Config;
	import semen.staff.EggEvent;
	import semen.staff.GameEvent;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import semen.staff.GlobalDispatcher;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class RootController {
		private var _gameField:GameField;
		private var sides:Array = ['ul', 'dl', 'ur', 'dr'];
		private var chickControllers:Array = [];
		private var buttonsController:ButtonsController;
		private var wolfController:WolfController;
		private var _newEggsTimer:Timer;
		private var chicksArray:Array = [];
		private var scoreController:ScoreController;
		private var hareController:HareController;
		private var _flashGameFieldTimer:Timer;
		private var _controls:Controls;
		
		public function RootController(gameField:GameField, controls:Controls) {
			_gameField = gameField;
			_controls = controls;
			initControllers();
			initNewEggsTimer();
			initInPauseTimer();
		}
		
		/******************************************************************************************************/
		
		/**
		 * Controllers creating block
		 */
		
		private function initControllers():void {
			initChicksControllers();
			initWolfController();
			initButtonController();
			initHareController();
			initScoreController();
		}
		
		 private function initChicksControllers():void {
			chicksArray = new Array();
			for each(var prefix:String in sides) {
				var chickView:MovieClip = MovieClip(_gameField[prefix + "Chick"]);
				if (chickView) {
					chickControllers[prefix] = new ChickController(chickView);
					chicksArray.push(chickControllers[prefix]);
					chickControllers[prefix].addEventListener(EggEvent.EGG_FALL, checkPoint);
				}
			}
		}
		
		private function initWolfController():void {
			var views:Object = { };
			for each (var prefix:String in sides) {
				var wolfView:MovieClip = MovieClip(_gameField[prefix + "Wolf"]);
				if (wolfView) {
					views[prefix] = wolfView;
				}
			}
			wolfController = new WolfController(views);
		}
		
		private function initButtonController():void {
			var buttons:Object = { };
			for each(var prefix:String in sides) {
				var button:MovieClip = MovieClip(_controls[prefix + "Button"]);
				buttons[prefix] = button;
			}
			buttons['pp'] = MovieClip(_controls["ppButton"]);
			buttons['ng'] = MovieClip(_controls["ngButton"]);
			buttonsController = new ButtonsController(buttons, wolfController);
			buttonsController.addEventListener(ButtonEvent.NEW_GAME, newGameListener);
		}
		
		private function initHareController():void {
			hareController = new HareController(_gameField.hare);
		}
		
		private function initScoreController():void {
			scoreController = new ScoreController(_gameField.scores, _gameField.lifes);
			scoreController.addEventListener(GameEvent.GAME_OVER, gameOver);
			scoreController.addEventListener(GameEvent.SPEED_UP, speedUp);
		}
		/******************************************************************************************************/
		
		/**
		 * General timer creating
		 */
		private function initNewEggsTimer():void {
			_newEggsTimer = new Timer(Config.newEggsFrequency, 0);
			_newEggsTimer.addEventListener(TimerEvent.TIMER, addEgg);
			GlobalDispatcher.instance.addEventListener(GlobalDispatcher.PAUSE, pauseTimer);
			GlobalDispatcher.instance.addEventListener(GlobalDispatcher.UNPAUSE, unPauseTimer);
		}
		/******************************************************************************************************/
		
		/**
		 * Timer, that flashing gameField at pauseTime
		 */
		private function initInPauseTimer():void {
			_flashGameFieldTimer = new Timer(Config.pausedScreenFlashingInterval);
			_flashGameFieldTimer.addEventListener(TimerEvent.TIMER, flashGameField);
		}
		
		/******************************************************************************************************/
		
		/**
		 * Pause listeners
		 */
		
		private function unPauseTimer(e:Event):void {
			_newEggsTimer.start();
			_flashGameFieldTimer.stop();
			_flashGameFieldTimer.reset();
			_gameField.visible = true;
		}
		
		private function pauseTimer(e:Event):void {
			_newEggsTimer.stop();
			_flashGameFieldTimer.start();
		}
		
		private function flashGameField(e:TimerEvent):void {
			_gameField.visible = !_gameField.visible;
		}
		
		/******************************************************************************************************/
		
		/**
		 * Last preparations and start-game block
		 * */
		
		private function flushAll(fullClean:Boolean = true):void {
			for each (var cc:ChickController in chickControllers ) {
				cc.flushAll();
			} 
			buttonsController.flushAll();
			hareController.flushAll();

            if (fullClean) {
                scoreController.flushAll();
                wolfController.flushAll();
            }
			
			buttonsController.removeEventListener(ButtonEvent.PAUSE, changePauseMode);
			_newEggsTimer.stop();
			_newEggsTimer.reset();
			_newEggsTimer.delay = Config.newEggsFrequency;
		}
		
		private function startGame():void {
			for each (var cc:ChickController in chickControllers ) {
				cc.getReady();
				cc.start();
			} 
			// Start itself
			if (GlobalDispatcher.instance.isPaused) {
				GlobalDispatcher.instance.changePauseMode();
			}
			buttonsController.addEventListener(ButtonEvent.PAUSE, changePauseMode);
			//hareController.start();
			_newEggsTimer.start();
		}
		
		/******************************************************************************************************/
		
		/**
		 * Ingame timer event: egg is ready to fall down. Handlers.
		 */
		
		private function checkPoint(e:EggEvent):void {
			var prefix:String = wolfController.position;
			if (ChickController(e.currentTarget) == chickControllers[prefix]) {
				winPoint();
			} else {
				ChickController(e.currentTarget).fall();
				losePoint();
			}
		}
		
		private function winPoint():void {
			scoreController.addPoint();
		}
		
		private function losePoint():void {
			scoreController.removeLife(hareController.harePresent);
			hareController.start();
		}
		
		/******************************************************************************************************/
		
		/**
		 * Ingame timer event: time to create new egg
		 */
			
		 private function addEgg(e:TimerEvent, tries:int = 0):void {
			var i:int = int(Math.random() * 4);
			if (!ChickController(chicksArray[i]).addEgg()) {
				if (tries > Config.maximumTriesToAddEgg) {
					return; //Stack overflow trap
				}
				addEgg(e, tries + 1);
			} else {
				return;
			}
		}
		 
		 /******************************************************************************************************/
		 
		 /**
		  * Ingame event: user is too lucky. Time to complicate gameplay
		  */
		private function speedUp(e:GameEvent):void {
			ChickController.speedUp();
			_newEggsTimer.delay /= 1 + Config.newEggsMultiplier;
		}
		
		/******************************************************************************************************/
		
		 /**
		  * Ingame event: too many fails. Game is over. Check, if user in top100 and reset game
		  */
		  
		private function gameOver(e:GameEvent):void {
            flushAll(false);
			checkResults();
		}
		
		private function stopAll():void {
			//for each (var cc:ChickController in chickControllers ) {
				//cc.stopAll();
			//} 
			//buttonsController.stopAll();
			//wolfController.stopAll();
			//scoreController.stopAll();
			//hareController.stopAll();
			_newEggsTimer.stop();
			_newEggsTimer.reset();
			_newEggsTimer.delay = Config.newEggsFrequency;
		}
		
		private function checkResults():void {
			//TODO: Тут будет запрос на сервер
		}
		
		/******************************************************************************************************/
		/**
		  * User event: User wants new game.
		  */
		private function newGameListener(e:ButtonEvent):void {
			flushAll();
			startGame();
		}
		/******************************************************************************************************/
		/**
		  * User event: User wants pause game.
		  */
		private function changePauseMode(e:ButtonEvent):void {
			GlobalDispatcher.instance.changePauseMode();
		}
		
		
		/******************************************************************************************************/
	}
}