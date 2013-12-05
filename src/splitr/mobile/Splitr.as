package splitr.mobile {

import feathers.themes.MetalWorksMobileTheme;

import splitr.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;

public class Splitr extends Sprite {

    private var _appModel:AppModel;

    public function Splitr()
    {
        new MetalWorksMobileTheme();

        this._appModel = AppModel.getInstance();

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        stage.addEventListener(Event.RESIZE, resizedHandler);
        layout();
    }

    private function resizedHandler(e:Event):void {
        layout();
    }

    private function layout():void {
        trace("[Starling] Resize:", stage.stageWidth, stage.stageHeight);
    }

}
}
