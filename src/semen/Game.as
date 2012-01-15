package semen{
	import semen.staff.Config;
	import semen.mvc.c.RootController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	
	public class Game extends Background {
        private static const ALLOWED_HOSTS:Array = ["localhost", "katlex.com"];
		private var counter:Number = 0;
		private var _defaultConfigPath:String ="./config.xml";
		
		public function Game():void {
            var url:String = loaderInfo.url, host:String;
            url = url.replace("http://", "");
            host = url.substring(0, url.indexOf("/"));

            if (ALLOWED_HOSTS.indexOf(host) != -1) {
                if (stage) init();
                else addEventListener(Event.ADDED_TO_STAGE, init);
            }
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Config.loadConfig(_defaultConfigPath, startNew);
		}

		private function startNew():void {
			addChild(new Background());
			addChild(new AlphaLayer()).alpha = Config.placeHoldersAlpha;
			new RootController(GameField(addChild(new GameField())), Controls(addChild(new Controls())));
		}
	}
}