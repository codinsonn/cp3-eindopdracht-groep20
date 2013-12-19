package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageOrientation;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import splitr.mobile.SplitrApp;

import starling.core.Starling;
import starling.events.Event;

[SWF(frameRate=60)]
public class SplitrMobile extends Sprite {

    private var _starling:Starling;

    public function SplitrMobile()
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        _starling = new Starling(SplitrApp, stage);
        _starling.antiAliasing = 1;
        _starling.start();

        stage.addEventListener(flash.events.Event.RESIZE, resizedHandler);
    }

    private function resizedHandler(e:flash.events.Event):void {
        _starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _starling.stage.stageWidth = stage.stageWidth;
        _starling.stage.stageHeight = stage.stageHeight;
        _starling.stage.dispatchEvent(new starling.events.Event(starling.events.Event.RESIZE));
    }

}
}
