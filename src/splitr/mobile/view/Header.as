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
import starling.events.ResizeEvent;
import starling.textures.Texture;

public class Header extends Sprite {

    private var _appModel:AppModel;

    private var _pageTitle:String;

    private var _headerBg:DisplayObject;

    public function Header(pageTitle:String = "Splitr")
    {
        this._appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

        _pageTitle = pageTitle;

        resizedHandler();
    }

    private function pageChangedHandler(e:AppModel):void {
        _pageTitle = AppModel.currentPage;
    }

    public function resizedHandler(e:ResizeEvent = null, w:uint = 480, h:uint = 50):void{

        if(_headerBg){
            removeChild(_headerBg);
        }

        var shape:Shape = new Shape();
        shape.graphics.beginFill(0xff0000);
        shape.graphics.drawRect(0, 0, w, h);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(w, h, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        _headerBg = new Image(texture);
        _headerBg.x = _headerBg.y = 0;
        addChild(_headerBg);

    }

}
}
