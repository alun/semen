package semen.mvc.c {
	import semen.staff.ButtonEvent;
	import semen.staff.Config;
	import semen.staff.EggEvent;
	import semen.staff.GameEvent;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
		
		public function RootController(gameField:GameField) {
			_gameField = gameField;
			initControllers();
			initNewEggsTimer();
			startGame();
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
				var button:MovieClip = MovieClip(_gameField[prefix + "Button"]);
				buttons[prefix] = button;
			}
			buttonsController = new ButtonsController(buttons, wolfController);
		}
		
		private function initHareController():void {
			hareController = new HareController(_gameField.hare)
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
		}
		
		/******************************************************************************************************/
		
		/**
		 * Last preparations and start-game block
		 * */
		
		private function startGame():void {
			for each (var cc:ChickController in chickControllers ) {
				cc.getReady();
				cc.start();
			} 
			buttonsController.getReady();
			wolfController.getReady();
			scoreController.getReady();
			hareController.getReady();
			// Start itself
			hareController.start();
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
				losePoint();
			}
		}
		
		private function winPoint():void {
			scoreController.addPoint();
		}
		
		private function losePoint():void {
			scoreController.removeLife(hareController.harePresent);
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
			}
		}
		 
		 /******************************************************************************************************/
		 
		 /**
		  * Ingame event: user is too lucky. Time to complicate gameplay
		  */
		private function speedUp(e:GameEvent):void {
			for each (var cc:ChickController in chickControllers ) {
				cc.speedUp();
			} 
			_newEggsTimer.delay /= 1 + Config.newEggsMultiplier;
		}
		
		/******************************************************************************************************/
		
		 /**
		  * Ingame event: too many fails. Game is over. Check, if user in top100 and reset game
		  */
		  
		private function gameOver(e:GameEvent):void {
			checkResults();
			stopAll();
		}
		
		private function stopAll():void {
			for each (var cc:ChickController in chickControllers ) {
				cc.stopAll();
			} 
			buttonsController.stopAll();
			wolfController.stopAll();
			scoreController.stopAll();
			hareController.stopAll();
			_newEggsTimer.stop();
			_newEggsTimer.reset();
			_newEggsTimer.delay = Config.newEggsFrequency;
		}
		
		private function checkResults():void {
			//TODO: Тут будет запрос на сервер
		}
		
		/******************************************************************************************************/
	}
}