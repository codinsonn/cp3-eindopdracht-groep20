package splitr.mobile.view.components {

import flash.display.BitmapData;
import flash.display.Shape;
import flash.events.Event;

import starling.text.TextField;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class OverviewItem extends Sprite {

    public static const EDIT_BILL:String = "EDIT_BILL";
    public static const DELETE_BILL:String = "DELETE_BILL";

    private var _panel:Image;
    private var _delete:Image;
    private var _edit:Image;
    private var _optionSize:uint;
    private var _itemBg:Image;

    private var _billNameField:TextField;
    private var _billTotalField:TextField;

    private var _leftX:uint;
    private var _settled:Boolean;

    public function OverviewItem(_w:uint = 480, _billName:String = "Bill Name", _billTotal:Number = 0.00, id:Number = 0, optionSize:uint = 25, settled:Boolean = false ) {

        trace("[Overviewitem]")

        _optionSize = optionSize;
        _leftX = 100;
        _settled = Math.random() >= 0.5; //DEMO SETTLED

        // Draw item background
        var bgShape:Shape = new Shape();
        bgShape.graphics.beginFill(0xf3f3f3);
        bgShape.graphics.drawRect(0, 0, _w, 50);
        bgShape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(_w * .6, 50, true, 0);
        shapeData.draw(bgShape);
        var texture:Texture = Texture.fromBitmapData(shapeData);
        _itemBg = new Image(texture);
        _itemBg.x = _leftX;
        addChild(_itemBg);

        var shape:Shape = new Shape();
        if(_settled == false){
            shape.graphics.beginFill(0xfe625d);
        }else{
            shape.graphics.beginFill(0x46d7c6);
        }
        shape.graphics.drawRect(0, 0, _w * .6, 50);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(_w * .6, 50, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        _delete = new Image(Assets.getAtlas().getTexture("DeleteIcon"));
        _edit = new Image(Assets.getAtlas().getTexture("EditIcon"));

        _panel = new Image(texture);
        _panel.x = _w/2 - _panel.width/2;
        addChild(_panel);

        _billNameField = new TextField(120, 30, "0", "OpenSansBold", 27, 0x000000);
        _billNameField.autoScale = true;
        _billNameField.vAlign = VAlign.CENTER;
        _billNameField.hAlign = HAlign.LEFT;
        _billNameField.border = false;
        _billNameField.fontName = "OpenSansBold";
        _billNameField.text = _billName.toString();
        _billNameField.x = _leftX;
        _billNameField.y = _panel.height/2 - _billNameField.height/2;
        addChild(_billNameField);

        _billTotalField = new TextField(120, 30, "0", "OpenSansBold", 27, 0x000000);
        _billTotalField.autoScale = true;
        _billTotalField.vAlign = VAlign.CENTER;
        _billTotalField.hAlign = HAlign.RIGHT;
        _billTotalField.border = false;
        _billTotalField.fontName = "OpenSansBold";
        _billTotalField.text = "€ " + _billTotal.toString();
        _billTotalField.y = _panel.height/2 - _billNameField.height/2;
        _billTotalField.x = _billNameField.x + _billNameField.width + 10;
        addChild(_billTotalField);

        addChild(_delete);
        addChild(_edit);

        _delete.x = 0;
        _delete.y = (_panel.y + _panel.height/2) - _delete.height/2;
        _delete.alpha = 0;
        _edit.x = _w - _edit.width;
        _edit.y = (_panel.y + _panel.height/2) -    _edit.height/2;
        _edit.alpha = 0
        resizedHandler();

    }

    public function resizedHandler():void {
        trace("resize [OverViewItem]");
    }

    public function setElementsX(objectPosition:Number):void {
        _billNameField.x = _leftX + objectPosition;
        _panel.x = _billNameField.x - 4;
        _billTotalField.x = 10 + _billNameField.width + _leftX + objectPosition;
        if(_billNameField.x > _leftX){
            _edit.alpha = objectPosition/70;
        }else if(_billNameField.x < _leftX){
            _delete.alpha = (objectPosition*-1)/70;;
        }
    }

    public function release():void {
        if(_billNameField.x > (_leftX + 50)){
            // Edit funtie
            trace("EDIT");
            dispatchEventWith("EDIT_BILL", false);
        }else if(_billNameField.x < (_leftX - 50)){
            // Delete functie
            trace("DELETE");
            dispatchEventWith("DELETE_BILL", false);
        }
        resetElementsX();
    }

    private function resetElementsX():void {
        _billNameField.x = _leftX;
        _panel.x = _leftX - 4;
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
