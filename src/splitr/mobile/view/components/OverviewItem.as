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
    private var _position:Point;

    private var _billNameField:TextField;
    private var _billTotalField:TextField;


    public function OverviewItem(_w:uint = 400, _billName:String = "rekening naam", _billTotal:uint = 0, id:Number =0, optionSize:uint = 25 ) {

        _optionSize = optionSize;

        var circleShape:Shape = new Shape();
        circleShape.graphics.beginFill(0x00ff00);
        circleShape.graphics.drawCircle(_optionSize,_optionSize,_optionSize);
        circleShape.graphics.endFill();
        var circleShapeData:BitmapData = new BitmapData(_optionSize*2, _optionSize*2, true, 0);
        circleShapeData.draw(circleShape);
        var circleShapetexture:Texture = Texture.fromBitmapData(circleShapeData);

        var shape:Shape = new Shape();
        shape.graphics.beginFill(0xff0000);
        shape.graphics.drawRect(0, 0, _w, 50);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(_w, 50, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);


        _panel = new Image(texture);
        addChild(_panel);
        _position = new Point();

        _billNameField = new TextField(120, 30, "0", "OpenSansBold", 27, 0x000000);
        _billNameField.autoScale = true;
        _billNameField.vAlign = VAlign.CENTER;
        _billNameField.border = true;
        _billNameField.fontName = "OpenSansBold";
        _billNameField.text = _billName.toString();
        _billNameField.x = 10;
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

        _delete = new Image(circleShapetexture);
        _edit = new Image(circleShapetexture);
        addChild(_delete);
        addChild(_edit);
        _delete.x = _panel.x - _delete.width - 5;
        _delete.y = (_panel.y + _panel.height/2) - _optionSize;
        _edit.x = _panel.width;
        _edit.y = (_panel.y + _panel.height/2) - _optionSize;

        resizedHandler();

    }


    public function resizedHandler():void {
        trace("resize [OverViewItem]");
    }

    public function scaleOption():void {
        trace("scaleOption");
    }
}
}
