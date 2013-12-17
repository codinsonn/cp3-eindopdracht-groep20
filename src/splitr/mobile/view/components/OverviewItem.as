package splitr.mobile.view.components {

import splitr.vo.BillVO;

import starling.text.TextField;
import starling.display.Image;
import starling.display.Sprite;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class OverviewItem extends Sprite {

    public static const EDIT_BILL:String = "EDIT_BILL";
    public static const DELETE_BILL:String = "DELETE_BILL";

    private var _billVO:BillVO;

    private var _panel:Image;
    private var _delete:Image;
    private var _edit:Image;
    private var _itemBg:Image;

    private var _billNameField:TextField;
    private var _billTotalField:TextField;

    private var _leftX:uint;
    private var _width:uint;
    private var _billTotal:Number;
    private var _settled:Boolean;

    public function OverviewItem(_w:uint = 480, _billName:String = "Bill Name", _billTotal:Number = 0.00, id:Number = 0, settled:Boolean = false ) {

        _width = _w;
        _leftX = 100;
        _settled = Math.random() >= 0.5;

        // Draw item background
        _itemBg = new Image(Assets.createTextureFromRectShape(_width *.6, 50, 0xf3f3f3));
        _itemBg.x = _leftX;
        addChild(_itemBg);

        _delete = new Image(Assets.getAtlas().getTexture("DeleteIcon"));
        _edit = new Image(Assets.getAtlas().getTexture("EditIcon"));

        createPanel();

        _billNameField = new TextField(180, 30, "0", "OpenSansBold", 18, 0xf3f3f3);
        _billNameField.vAlign = VAlign.CENTER;
        _billNameField.hAlign = HAlign.LEFT;
        _billNameField.fontName = "OpenSansBold";
        _billNameField.text = _billName.toString();
        _billNameField.x = _leftX;
        _billNameField.y = _panel.height/2 - _billNameField.height/2;
        addChild(_billNameField);

        _billTotalField = new TextField(100, 30, "0", "OpenSansBold", 18, 0xf3f3f3);
        _billTotalField.vAlign = VAlign.CENTER;
        _billTotalField.hAlign = HAlign.RIGHT;
        _billTotalField.fontName = "OpenSansBold";
        _billTotalField.text = "€ " + _billTotal.toString();
        _billTotalField.y = _panel.height/2 - _billNameField.height/2;
        _billTotalField.x = _billNameField.x + _billNameField.width - 5;
        addChild(_billTotalField);

        _delete.x = 5;
        _delete.y = (_panel.y + _panel.height/2) - _delete.height/2;
        _delete.alpha = 0;
        addChild(_delete);

        _edit.x = _width - _edit.width - 5;
        _edit.y = (_panel.y + _panel.height/2) -    _edit.height/2;
        _edit.alpha = 0;
        addChild(_edit);

    }

    private function createPanel():void {
        if(_panel){
            removeChild(_panel);
        }

        var color:uint;
        if(_settled == false){
            color = 0xF34A53;
        }else{
            color = 0xAAC789;
        }
        _panel = new Image(Assets.createTextureFromRectShape(_width * .6, 50, color));
        _panel.x = _width/2 - _panel.width/2;
        addChildAt(_panel, 1);
    }

    public function setElementsX(objectPosition:Number):void {
        _billNameField.x = _leftX + objectPosition;
        _panel.x = _billNameField.x - 4;
        _billTotalField.x = _billNameField.width + _leftX + objectPosition -5;
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
        _billTotalField.x = _billNameField.x + _billNameField.width - 5;
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
