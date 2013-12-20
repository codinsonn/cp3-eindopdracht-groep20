package splitr.mobile.view.components {

import feathers.controls.Slider;
import feathers.controls.TextInput;

import flash.events.Event;

import splitr.model.AppModel;
import splitr.model.services.CalculatorService;

import splitr.vo.BillVO;

import starling.display.DisplayObject;
import starling.events.Event;

import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

import starling.text.TextField;
import starling.display.Image;
import starling.display.Sprite;
import starling.utils.HAlign;

public class PersonItem extends Sprite {

    private var _appModel:AppModel;

    public static const DELETE_PERSON:String = "DELETE_PERSON";
    public static const SETTLE_PERSON:String = "SETTLE_PERSON";
    public static const NAME_CHANGED:String = "NAME_CHANGED";

    private var _panel:Image;
    private var _delete:Image;
    private var _settleIcon:Image;
    private var _itemBg:Image;

    private var _personNameField:TextfieldToggler;
    private var _personNameShare:Number;

    private var _leftX:uint;
    private var _width:uint;

    private var _editableShare:TextfieldToggler;
    private var _equalShare:TextField;
    private var _share:Number;
    private var _shareSlider:Slider;
    private var _calcService:CalculatorService;
    private var _sliderMaxVal:uint;
    private var _h:uint;
    private var _id:uint;
    private var _shareAmount:Number;
    private var _sliderTriggered:Boolean = false;
    private var _settledChanged:Boolean = true;

    private var _settled:Boolean;

    public function PersonItem(_w:uint = 480, _PersonName:String = "Hans", _PersonShare:Number = 0.00, id:uint = 0,settled:Boolean = false) {
        _calcService = CalculatorService.getInstance();
        _calcService.addEventListener(CalculatorService.SLIDERS_RECALCULATED, sliderRecalcHandler);

        _personNameShare = _PersonShare;
        this._appModel = AppModel.getInstance();
        _settled = settled;
        _width = _w;
        _leftX = 100;
        _h = 50;
        _id = id;

        // Draw item background
        _itemBg = new Image(Assets.createTextureFromRectShape(_width *.6, 50, 0xf3f3f3));
        _itemBg.x = _leftX;
        addChild(_itemBg);

        _delete = new Image(Assets.getAtlas().getTexture("DeleteIcon"));
        _settleIcon = new Image(Assets.getAtlas().getTexture("SettleIcon"));
        _settledChanged = true;
        view();

        _personNameField = new TextfieldToggler(150, 40, 18, "PF Ronda Seven", _PersonName , 0xF3F3F3, "My Awesome Person");
        _personNameField.y = _panel.height/2 - _personNameField.height/2;
        _personNameField.x = _itemBg.x + 10;
        _personNameField.maxChars = 15;
        _personNameField.addEventListener(starling.events.Event.CHANGE, nameChangedHandler);

        textOrInput();

        _delete.x = 5;
        _delete.y = (_panel.y + _panel.height/2) - _delete.height/2;
        _delete.alpha = 0;
        addChild(_delete);
    }

    private function sliderRecalcHandler(e:flash.events.Event):void {
        trace("[sliderRecalcHandler]", "SliderShare:", _appModel.bills[_appModel.currentBill].billGroup[_id].personShare);
        buildSlider();
        _shareSlider.value = _appModel.bills[_appModel.currentBill].billGroup[_id].personShare;
    }

    private function view():void {
        if(_settledChanged == true){
            if(_panel){
                removeChildAt(1);
            }

            if(_settleIcon){
                removeChild(_settleIcon);
            }

            var color:uint;
            if(_settled == false){
                color = 0xF34A53;
                _settleIcon = new Image(Assets.getAtlas().getTexture("SettleIcon"));
            }else{
                color = 0xAAC789;
                _settleIcon = new Image(Assets.getAtlas().getTexture("UnsettleIcon"));
            }

            _panel = new Image(Assets.createTextureFromRectShape(_width * .6, 50, color));
            _panel.x = _width/2 - _panel.width/2;
            addChildAt(_panel, 1);

            _settleIcon.x = _width - _settleIcon.width - 5;
            _settleIcon.y = (_panel.y + _panel.height/2) - _delete.height/2;
            _settleIcon.alpha = 0;
            addChild(_settleIcon);

            _settledChanged = false;
        }
    }
    private function nameChangedHandler(e:starling.events.Event):void {
        dispatchEvent(new starling.events.Event("NAME_CHANGED"));
    }

    private function textOrInput():void {
        addChild(_personNameField);
        switch (_appModel.currentPage){
            case "EqualSplit":
                    _shareAmount = _personNameShare;
                    buildEqual();
                break;
            case "PercentualSplit":
                    _shareAmount = Number(_appModel.bills[_appModel.currentBill].billGroup[_id].personShare.toFixed(2).toString());
                    buildSlider();
                    buildEqual();
                break;
            case "AbsoluteSplit":
                    _shareAmount = _personNameShare;
                    buildAbsolute();
                break;
        }
    }

    private function buildSlider():void {
        _shareSlider = new Slider();
        _shareSlider.liveDragging = true;
        _shareSlider.minimum = 0;
        _shareSlider.maximum = 100;
        _shareSlider.value = _personNameShare;
        _shareSlider.height = _h;
        _shareSlider.width = _panel.width;
        _shareSlider.y = (_panel.y+_panel.height);
        _shareSlider.x = _panel.x;
        _shareSlider.addEventListener(TouchEvent.TOUCH, sliderTriggeredHanler);
        addChild(_shareSlider);
    }

    private function sliderTriggeredHanler(e:TouchEvent):void {
        var slider:Slider = e.currentTarget as Slider;
        var touch:Touch = e.getTouch(slider);
        if(touch != null) {
            switch(touch.phase){
                case TouchPhase.MOVED:
                    _sliderTriggered = true;
                    _calcService.recalculateByPage(slider.value, _id);
                    drawShares();
                    break;
                case TouchPhase.ENDED:
                    _calcService.recalculateByPage(slider.value, _id);
                    _appModel.save();
                    drawShares();
                    _sliderTriggered = false;
                    break;
            }
        }
    }

    private function buildEqual():void {
        _equalShare = new TextField(180, 30, "0", "OpenSansBold", 18, 0xF3F3F3);
        _equalShare.y = _panel.height/2 - _equalShare.height/2;
        _equalShare.x = (_panel.width + _panel.x) - (_equalShare.width + 10);
        _equalShare.hAlign = HAlign.RIGHT;
        addChild(_equalShare);
        drawShares();
    }

    public function drawShares():void{
        var shareString:String;
        if(_appModel.currentPage == "PercentualSplit"){
            shareString = "(" + _shareSlider.value.toFixed(2).toString() + "%) € " + Number(Number(_shareSlider.value)/100 * _appModel.bills[_appModel.currentBill].billTotal).toFixed(2).toString();
        }else{
            shareString = "€ " + _shareAmount.toFixed(2).toString();
        }

        if(_appModel.currentPage == "AbsoluteSplit"){
            _editableShare.text = shareString;
        }else{
            _equalShare.text = shareString;
        }

    }

    private function buildAbsolute():void {
        _editableShare = new TextfieldToggler(150, 40, 20, "OpenSansBold", "0" , 0xF3F3F3, "My Awesome Person");
        _editableShare.y = _panel.height/2 - _editableShare.height/2;
        _editableShare.x = (_panel.width + _panel.x) - (_editableShare.width + 10);
        _editableShare.text = "€ " + _shareAmount.toString();
        _editableShare.textHAlignRight = true;
        _editableShare.inputRestrict = "0-9\.";
        _editableShare.isNumberInput = true;
        _editableShare.addEventListener(starling.events.Event.CHANGE, shareChangedHandler);
        addChild(_editableShare);
    }

    private function shareChangedHandler(e:starling.events.Event):void {
        _share = Number(_editableShare.text);
        dispatchEvent(new starling.events.Event(starling.events.Event.CHANGE));
        drawShares();
    }

    public function setElementsX(objectPosition:Number):void {

        if(_sliderTriggered == false){
            _personNameField.x = ( _itemBg.x + 10) + objectPosition;
            _panel.x = (_personNameField.x-10) - 4;

            if(_equalShare){
            _equalShare.x =(_panel.x + _panel.width) - (_equalShare.width +10);
            }else if(_editableShare){
                _editableShare.x = (_panel.width + _panel.x) - (_editableShare.width + 10);
            }

            if(_shareSlider){
                _shareSlider.x = _panel.x;
            }

            if(_personNameField.x > _leftX){
                _settleIcon.alpha = (objectPosition*1)/70;
            }else if(_personNameField.x < _leftX){
                _delete.alpha = (objectPosition*-1)/70;
            }
        }
    }

    public function release():void {
        if(_personNameField.x < 50){
            dispatchEventWith("DELETE_PERSON", false);
        }else if(_personNameField.x > 50 + _leftX){
            dispatchEventWith("SETTLE_PERSON", false);
        }
        resetElementsX();
    }

    private function resetElementsX():void {
        _personNameField.x = _itemBg.x + 10;
        _panel.x = _width/2 - _panel.width/2;
        if(_equalShare){
            removeChild(_equalShare);
            addChild(_equalShare);
            _equalShare.x = (_panel.width + _panel.x) - (_equalShare.width + 10);
        } else if(_editableShare){
            _editableShare.x = (_panel.width + _panel.x) - (_editableShare.width + 10);
        }

        if(_shareSlider){
            _shareSlider.x = _panel.x;
        }

        _delete.alpha = 0;
        _settleIcon.alpha = 0;
    }

    public function get id():uint {
        return _id;
    }

    public function get share():Number {
        return _share;
    }

    public function get personNameField():TextfieldToggler {
        return _personNameField;
    }

    public function set sliderMaxVal(value:uint):void {
        _sliderMaxVal = value;
    }
}
}
