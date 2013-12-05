package splitr.mobile {

import feathers.themes.MetalWorksMobileTheme;

import flash.display.BitmapData;

import flash.display.Shape;

import splitr.model.AppModel;

import starling.display.DisplayObject;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class Splitr extends starling.display.Sprite {

    private var _appModel:AppModel;

    private var _header:DisplayObject;

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

        var shape:Shape = new Shape();
        shape.graphics.beginFill(0xff0000);
        shape.graphics.drawRect(0, 0, stage.stageWidth, 50);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(stage.stageWidth, 50, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        _header = new Image(texture);
        _header.x = _header.y = 0;
        addChild(_header);
    }

}
}
