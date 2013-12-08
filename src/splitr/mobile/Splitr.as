package splitr.mobile {

import feathers.themes.MetalWorksMobileTheme;

import flash.display.BitmapData;

import flash.display.Shape;

import splitr.mobile.view.Header;

import splitr.model.AppModel;

import starling.display.DisplayObject;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.Texture;

public class Splitr extends starling.display.Sprite {

    private var _appModel:AppModel;

    private var _header:Header;

    [Embed(source = "/../assets/fonts/OpenSansBold.fnt", mimeType="application/octet-stream")]
    public static const OpenSansBoldXml:Class;

    [Embed(source = "/../assets/fonts/OpenSansBold.png")]
    public static const OpenSansBoldTexture:Class;

    public function Splitr()
    {
        new MetalWorksMobileTheme();

        this._appModel = AppModel.getInstance();

        var texture:Texture = Texture.fromBitmap(new OpenSansBoldTexture());
        var xml:XML = XML(new OpenSansBoldXml());
        TextField.registerBitmapFont(new BitmapFont(texture, xml));

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

        // Header resize
        if(!_header){
            _header = new Header();
            addChild(_header);
        }
        _header.resizedHandler(stage.stageWidth, 50);


    }

}
}
