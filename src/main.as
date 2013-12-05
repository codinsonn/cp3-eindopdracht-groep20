package {

import feathers.themes.MetalWorksMobileTheme;

import flash.events.Event;

import splitr.Splitr;

import starling.display.Sprite;
import starling.events.ResizeEvent;

public class main extends Sprite {

    //private var app:Splitr;

    public function main()
    {
        new MetalWorksMobileTheme();

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
        trace("[Resize]", stage.stageWidth, stage.stageHeight);

    }
}
}
