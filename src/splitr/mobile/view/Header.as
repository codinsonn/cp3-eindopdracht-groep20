/**
 * Created with IntelliJ IDEA.
 * User: stevensthorr
 * Date: 12/8/13
 * Time: 1:09 PM
 * To change this template use File | Settings | File Templates.
 */
package splitr.mobile.view {

import flash.display.BitmapData;
import flash.display.Shape;

import splitr.model.AppModel;

import starling.display.DisplayObject;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.Texture;

public class Header extends Sprite {

    private var _appModel:AppModel;

    private var _txtTitle:TextField;

    private var _headerBg:DisplayObject;

    public function Header()
    {
        this._appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

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
        shape.graphics.beginFill(0x888888);
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

        // Set and add Textfield for Splitr Title
        _txtTitle = new TextField(120, 35, "0", "Open Sans Bold", 25, 0xFFFFFF);
        _txtTitle.fontName = "OpenSansBold";
        _txtTitle.text = "Splitr";
        _txtTitle.x = w/2 - _txtTitle.width/2;
        _txtTitle.y = 5;
        addChild(_txtTitle);

    }

}
}
