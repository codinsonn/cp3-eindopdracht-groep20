package splitr.mobile.view.components {

import splitr.vo.BillVO;

import starling.text.TextField;
import starling.display.Image;
import starling.display.Sprite;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class OverviewItem extends Sprite {

    public static const EDIT_SETTLED:String = "EDIT_SETTLED";
    public static const DELETE_BILL:String = "DELETE_BILL";

    private var _billVO:BillVO;

    private var _panel:Image;
    private var _deleteButton:Image;
    private var _editSettled:Image;
    private var _itemBg:Image;

    private var _billNameField:TextField;
    private var _billTotalField:TextField;

    private var _leftX:uint;
    private var _width:uint;
    private var _billTotal:Number;
    private var _settled:Boolean;
    private var _settledChanged:Boolean = false;

    public function OverviewItem(_w:uint = 480, _billName:String = "Bill Name", _billTotal:Number = 0.00, id:Number = 0, settled:Boolean = false ) {

        _width = _w;
        _leftX = 100;
        _settled = Math.random() >= 0.5;

        // Draw item background
        _itemBg = new Image(Assets.createTextureFromRectShape(_width *.6, 50, 0xf3f3f3));
        _itemBg.x = _leftX;
        addChild(_itemBg);

        _billNameField = new TextField(180, 30, "0", "OpenSansBold", 18, 0xf3f3f3);
        _billNameField.vAlign = VAlign.CENTER;
        _billNameField.hAlign = HAlign.LEFT;
        _billNameField.fontName = "OpenSansBold";
        _billNameField.text = _billName.toString();
        _billNameField.x = _leftX;
        addChild(_billNameField);

        _billTotalField = new TextField(100, 30, "0", "OpenSansBold", 18, 0xf3f3f3);
        _billTotalField.vAlign = VAlign.CENTER;
        _billTotalField.hAlign = HAlign.RIGHT;
        _billTotalField.fontName = "OpenSansBold";
        _billTotalField.text = "€ " + _billTotal.toString();
        _billTotalField.x = _billNameField.x + _billNameField.width - 5;
        addChild(_billTotalField);

        _deleteButton = new Image(Assets.getAtlas().getTexture("DeleteIcon"));
        _deleteButton.x = 5;
        _deleteButton.alpha = 0;
        addChild(_deleteButton);

        _settledChanged = true;
        view();
    }

    private function view():void {
        if(_settledChanged == true){
            if(_panel){
                removeChildAt(1);
            }

            if(_editSettled){
                removeChild(_editSettled);
            }

            var color:uint;
            if(_settled == false){
                color = 0xF34A53;
                _editSettled = new Image(Assets.getAtlas().getTexture("SettleIcon"));
            }else{
                color = 0xAAC789;
                _editSettled = new Image(Assets.getAtlas().getTexture("UnsettleIcon"));
            }

            _panel = new Image(Assets.createTextureFromRectShape(_width * .6, 50, color));
            _panel.x = _width/2 - _panel.width/2;
            addChildAt(_panel, 1);

            _editSettled.x = _width - _editSettled.width - 5;
            _editSettled.y = (_panel.y + _panel.height/2) -    _editSettled.height/2;
            _editSettled.alpha = 0;
            addChild(_editSettled);

            _billNameField.y = _panel.height/2 - _billNameField.height/2;
            _billTotalField.y = _panel.height/2 - _billNameField.height/2;
            _deleteButton.y = (_panel.y + _panel.height/2) - _deleteButton.height/2;

            _settledChanged = false;
        }
    }

    public function setElementsX(objectPosition:Number):void {
        _billNameField.x = _leftX + objectPosition;
        _panel.x = _billNameField.x - 4;
        _billTotalField.x = _billNameField.width + _leftX + objectPosition -5;
        if(_billNameField.x > _leftX){
            _editSettled.alpha = objectPosition/70;
        }else if(_billNameField.x < _leftX){
            _deleteButton.alpha = (objectPosition*-1)/70;;
        }
    }

    public function release():void {
        if(_billNameField.x > (_leftX + 50)){
            dispatchEventWith("EDIT_SETTLED", false);
        }else if(_billNameField.x < (_leftX - 50)){
            dispatchEventWith("DELETE_BILL", false);
        }
        resetElementsX();
    }

    private function resetElementsX():void {
        _billNameField.x = _leftX;
        _panel.x = _leftX - 4;
        _billTotalField.x = _billNameField.x + _billNameField.width - 5;
        _deleteButton.alpha = 0;
        _editSettled.alpha = 0;
    }

    public function get settled():Boolean {
        return _settled;
    }

    public function get billVO():BillVO {
        return _billVO;
    }

    public function set billVO(value:BillVO):void {
        _billVO = value;

        _settled = _billVO.settledState;
        _billNameField.text = _billVO.billTitle;
        _billTotal = _billVO.billTotal;
        _billTotalField.text = "€ " + _billTotal.toString();

        _settledChanged = true;
        view();
    }
}
}
