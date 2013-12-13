package splitr.mobile.view {

import flash.display.BitmapData;
import flash.display.Shape;
import flash.events.Event;

import splitr.model.AppModel;

import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

public class Header extends Sprite {

    private var _appModel:AppModel;

    public static const RETURN_TO_OVERVIEW:String = "RETURN_TO_OVERVIEW";

    private var _titleString:String;
    private var _bgColor:uint;
    private var _titleColor:uint;

    private var _txtTitle:TextField;
    private var _headerBg:Image;
    private var _headerPrevPageButton:Button;

    public function Header(title:String = "SPLITR", bgColor:uint = 0x638179, titleColor:uint = 0x33423e)
    {
        this._appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

        _titleString = title;
        _bgColor = bgColor;
        _titleColor = titleColor;

        _txtTitle = new TextField(120, 36, "0", "OpenSansBold", 27, _titleColor);
        _txtTitle.fontName = "OpenSansBold";
        _txtTitle.text = _titleString;
        _txtTitle.y = 6;
        addChild(_txtTitle);

        _headerPrevPageButton = new Button(Assets.getAtlas().getTexture("HeaderPrevButton"));
        _headerPrevPageButton.x = 10;
        _headerPrevPageButton.y = (50 - _headerPrevPageButton.height)/2;
        _headerPrevPageButton.addEventListener(TouchEvent.TOUCH, prevPageButtonTouchedHandler);
        addChild(_headerPrevPageButton);

        resizedHandler();
    }

    private function pageChangedHandler(e:flash.events.Event):void {
        if(_appModel.currentPage != "Overview"){
            _headerPrevPageButton.visible = true;
            _headerPrevPageButton.enabled = true;
        }else{
            _headerPrevPageButton.visible = false;
            _headerPrevPageButton.enabled = false;
        }
    }

    public function resizedHandler(w:uint = 480, h:uint = 50):void{

        // Remove the header background if it already exists
        if(_headerBg){
            removeChild(_headerBg);
        }

        // Draw a new shape (to be converted to a texture) to set as new background
        var shape:Shape = new Shape();
        shape.graphics.beginFill(_bgColor);
        shape.graphics.drawRect(0, 0, w, h);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(w, h, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        // Create new image from shape texture to serve as new background
        _headerBg = new Image(texture);
        _headerBg.x = _headerBg.y = 0;
        addChildAt(_headerBg, 0);

        // Replacing of Textfield for 'Splitr' Title
        _txtTitle.x = w/2 - _txtTitle.width/2;

    }

    private function prevPageButtonTouchedHandler(e:TouchEvent):void {
        var touchedObject:DisplayObject = e.currentTarget as DisplayObject;
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase){
                case TouchPhase.ENDED:
                    _appModel.currentPage = "Overview";
                    break;
            }
        }
    }

}
}
