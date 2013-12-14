/**
 * Created with IntelliJ IDEA.
 * User: Panzerfaust
 * Date: 12/12/13
 * Time: 14:21
 * To change this template use File | Settings | File Templates.
 */
package splitr.mobile.view.components {

import flash.display.BitmapData;
import flash.display.Shape;
import flash.geom.Point;

import starling.text.TextField;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.utils.VAlign;

public class OverviewItem extends Sprite {

    private var _panel:Image;
    private var _delete:Image;
    private var _edit:Image;
    private var _optionSize:uint;

    private var _billNameField:TextField;
    private var _billTotalField:TextField;

    private var _leftX:uint;
    private var _settled:Boolean;

    public function OverviewItem(_w:uint = 400, _billName:String = "rekening naam", _billTotal:uint = 0, id:Number = 0, optionSize:uint = 25, settled:Boolean = false ) {

        trace("[Overviewitem]")

        _optionSize = optionSize;
        _leftX = 100;
        //_settled = settled;
        _settled = Math.random() >= 0.5;//DEMO SETTLED
        trace("[OverviewItem]", "Settled:", _settled);

        var circleShape:Shape = new Shape();
        circleShape.graphics.beginFill(0x00ff00);
        circleShape.graphics.drawCircle(_optionSize,_optionSize,_optionSize);
        circleShape.graphics.endFill();
        var circleShapeData:BitmapData = new BitmapData(_optionSize*2, _optionSize*2, true, 0);
        circleShapeData.draw(circleShape);
        var circleShapetexture:Texture = Texture.fromBitmapData(circleShapeData);

        var shape:Shape = new Shape();
        if(_settled == false){
            shape.graphics.beginFill(0xff0000);
        }else{
            shape.graphics.beginFill(0x0000ff);
        }
        shape.graphics.drawRect(0, 0, _w, 50);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(_w, 50, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        _delete = new Image(circleShapetexture);
        _edit = new Image(circleShapetexture);

        _panel = new Image(texture);
        addChild(_panel);

        _billNameField = new TextField(120, 30, "0", "OpenSansBold", 27, 0x000000);
        _billNameField.autoScale = true;
        _billNameField.vAlign = VAlign.CENTER;
        _billNameField.border = true;
        _billNameField.fontName = "OpenSansBold";
        _billNameField.text = _billName.toString();
        _billNameField.x = _leftX;
        _billNameField.y = _panel.height/2 - _billNameField.height/2;
        addChild(_billNameField);

        _billTotalField = new TextField(120, 30, "0", "OpenSansBold", 27, 0x000000);
        _billTotalField.autoScale = true;
        _billTotalField.vAlign = VAlign.CENTER;
        _billTotalField.border = true;
        _billTotalField.fontName = "OpenSansBold";
        _billTotalField.text = "€",_billTotal.toString();
        _billTotalField.y = _panel.height/2 - _billNameField.height/2;
        _billTotalField.x = _billNameField.x + _billNameField.width + 10;
        addChild(_billTotalField);

        addChild(_delete);
        addChild(_edit);

        _delete.x = _panel.x;
        _delete.y = (_panel.y + _panel.height/2) - _delete.height/2;
        _delete.alpha = 0;
        _edit.x = _panel.width - _edit.width;
        _edit.y = (_panel.y + _panel.height/2) -    _edit.height/2;
        _edit.alpha = 0
        resizedHandler();

    }

    public function resizedHandler():void {
        trace("resize [OverViewItem]");
    }

    public function setElementsX(objectPosition:Number):void {
        _billNameField.x = _leftX + objectPosition;
        _billTotalField.x = 10 + _billNameField.width + _leftX + objectPosition;
        if(_billNameField.x > _leftX){
            _edit.alpha = objectPosition/70;
        }else if(_billNameField.x < _leftX){
            _delete.alpha = (objectPosition*-1)/70;;
        }
    }

    public function release():void {
        if(_billNameField.x > (_leftX + 50)){
            trace("EDITFUNCTIE HIER");
        }else if(_billNameField.x < (_leftX - 50)){
            trace("DELETEFUNCTIE HIER");
        }

        resetElementsX();

    }

    private function resetElementsX():void {
        _billNameField.x = _leftX;
        _billTotalField.x = _billNameField.x + _billNameField.width + 10;
        _delete.alpha = 0;
        _edit.alpha = 0;
    }

    public function get settled():Boolean {
        return _settled;
    }

    public function set settled(value:Boolean):void {
        //_settled = value;
    }
}
}
