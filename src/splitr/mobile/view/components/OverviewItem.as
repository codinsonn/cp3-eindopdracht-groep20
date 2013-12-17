package splitr.mobile.view.components {

import flash.display.BitmapData;
import flash.display.Shape;
import flash.events.Event;

import splitr.vo.BillVO;

import starling.text.TextField;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class OverviewItem extends Sprite {

    public static const EDIT_BILL:String = "EDIT_BILL";
    public static const DELETE_BILL:String = "DELETE_BILL";

    private var _billVO:BillVO;

    private var _panel:Image;
    private var _delete:Image;
    private var _edit:Image;
    private var _optionSize:uint;
    private var _itemBg:Image;

    private var _billNameField:TextField;
    private var _billTotalField:TextField;

    private var _leftX:uint;
    private var _width:uint;
    private var _billTotal:Number;
    private var _settled:Boolean;

    public function OverviewItem(_w:uint = 480, _billName:String = "Bill Name", _billTotal:Number = 0.00, id:Number = 0, optionSize:uint = 25, settled:Boolean = false ) {

        _optionSize = optionSize;
        _width = _w;
        _leftX = 100;
        _settled = Math.random() >= 0.5; //DEMO SETTLED

        // Draw item background
        _itemBg = new Image(createTextureFromRectShape(_width *.6, 50, 0xf3f3f3));
        _itemBg.x = _leftX;
        addChild(_itemBg);

        _delete = new Image(Assets.getAtlas().getTexture("DeleteIcon"));
        _edit = new Image(Assets.getAtlas().getTexture("EditIcon"));

        createPanel();

        _billNameField = new TextField(180, 30, "0", "OpenSansBold", 17, 0xf3f3f3);
        _billNameField.autoScale = false;
        _billNameField.vAlign = VAlign.CENTER;
        _billNameField.hAlign = HAlign.LEFT;
        _billNameField.border = false;
        _billNameField.fontName = "OpenSansBold";
        _billNameField.text = _billName.toString();
        _billNameField.x = _leftX;
        _billNameField.y = _panel.height/2 - _billNameField.height/2;
        addChild(_billNameField);

        _billTotalField = new TextField(80, 30, "0", "OpenSansBold", 17, 0xf3f3f3);
        _billTotalField.autoScale = false;
        _billTotalField.vAlign = VAlign.CENTER;
        _billTotalField.hAlign = HAlign.RIGHT;
        _billTotalField.border = false;
        _billTotalField.fontName = "OpenSansBold";
        _billTotalField.text = "€ " + _billTotal.toString();
        _billTotalField.y = _panel.height/2 - _billNameField.height/2;
        _billTotalField.x = _billNameField.x + _billNameField.width + 20;
        addChild(_billTotalField);

        addChild(_delete);
        addChild(_edit);

        _delete.x = 0;
        _delete.y = (_panel.y + _panel.height/2) - _delete.height/2;
        _delete.alpha = 0;
        _edit.x = _width - _edit.width;
        _edit.y = (_panel.y + _panel.height/2) -    _edit.height/2;
        _edit.alpha = 0;

    }

    private function createPanel():void {
        if(_panel){
            removeChild(_panel);
        }

        var color:uint;
        if(_settled == false){
            color = 0xfe625d;
        }else{
            color = 0x46d7c6;
        }
        _panel = new Image(createTextureFromRectShape(_width * .6, 50, color));
        _panel.x = _width/2 - _panel.width/2;
        addChildAt(_panel, 1);
    }

    private function createTextureFromRectShape(w:uint = 480, h:uint = 50, color:uint = 0xf3f3f3):Texture{
        var shape:Shape = new Shape();
        shape.graphics.beginFill(color);
        shape.graphics.drawRect(0, 0, w, 50);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(w, 50, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        return texture;
    }

    public function setElementsX(objectPosition:Number):void {
        _billNameField.x = _leftX + objectPosition;
        _panel.x = _billNameField.x - 4;
        _billTotalField.x = 20 + _billNameField.width + _leftX + objectPosition;
        if(_billNameField.x > _leftX){
            _edit.alpha = objectPosition/70;
        }else if(_billNameField.x < _leftX){
            _delete.alpha = (objectPosition*-1)/70;;
        }
    }

    public function release():void {
        if(_billNameField.x > (_leftX + 50)){
            dispatchEventWith("EDIT_BILL", false);
        }else if(_billNameField.x < (_leftX - 50)){
            dispatchEventWith("DELETE_BILL", false);
        }
        resetElementsX();
    }

    private function resetElementsX():void {
        _billNameField.x = _leftX;
        _panel.x = _leftX - 4;
        _billTotalField.x = _billNameField.x + _billNameField.width + 20;
        _delete.alpha = 0;
        _edit.alpha = 0;
    }

    public function get settled():Boolean {
        return _settled;
    }

    public function get billVO():BillVO {
        return _billVO;
    }

    public function set billVO(value:BillVO):void {
        if(_billVO != value){
            _billVO = value;

            _settled = _billVO.settledState;
            _billNameField.text = _billVO.billTitle;
            _billTotal = _billVO.billTotal;
            _billTotalField.text = "€ " + _billTotal.toString();

            createPanel();
        }
    }
}
}
