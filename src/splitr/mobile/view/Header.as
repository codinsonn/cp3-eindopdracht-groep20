package splitr.mobile.view {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;

import splitr.model.AppModel;

import starling.display.DisplayObject;
import starling.display.Image;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class Header extends Sprite {

    private var _appModel:AppModel;

    private var _titleString:String;
    private var _bgColor:uint;
    private var _titleColor:uint;

    private var _txtTitle:TextField;
    private var _headerBg:DisplayObject;
    private var _headerPrevPageButton:DisplayObject;

    [Embed(source="/../assets/custom/SplitrSpreadsheet.xml", mimeType="application/octet-stream")]
    public static const SplitrSpreadSheetXML:Class;

    [Embed(source="/../assets/custom/SplitrSpreadsheet.png", mimeType="application/octet-stream")]
    public static const SplitrSpreadSheetTexture:Class;

    public function Header(title:String = "Splitr", bgColor:uint = 0x638179, titleColor:uint = 0x33423e)
    {
        this._appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

        _titleString = title;
        _bgColor = bgColor;
        _titleColor = titleColor;

        resizedHandler();
    }

    private function pageChangedHandler(e:Event = null):void {

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
        addChild(_headerBg);

        // Add title textfield if not existing already
        if(_txtTitle){
            removeChild(_txtTitle);
        }

        // Settings and adding of Textfield for 'Splitr' Title
        _txtTitle = new TextField(120, 36, "0", "OpenSansBold", 27, _titleColor);
        _txtTitle.fontName = "OpenSansBold";
        _txtTitle.text = _titleString;
        _txtTitle.x = w/2 - _txtTitle.width/2;
        _txtTitle.y = 6;
        addChild(_txtTitle);

        // Add previous page icon if not on overview page
        if(AppModel.currentPage != "Overview"){
            if(!_headerPrevPageButton){
                //var bitmap:Bitmap = Texture.fromBitmap()
            }
            _headerPrevPageButton.x = 30;
            _headerPrevPageButton.y = 25;
        }

    }

}
}
