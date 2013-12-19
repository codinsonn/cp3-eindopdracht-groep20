package splitr.mobile.view.components {

import feathers.controls.Slider;
import feathers.controls.TextInput;

import splitr.model.AppModel;

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
    public static const NAME_CHANGED:String = "NAME_CHANGED";

    private var _panel:Image;
    private var _delete:Image;
    private var _itemBg:Image;

    private var _personNameField:TextfieldToggler;
    private var _personNameShare:uint;

    private var _leftX:uint;
    private var _width:uint;

    private var _editableShare:TextfieldToggler;
    private var _equalShare:TextField;
    private var _share:Number;
    private var _shareSlider:Slider;
    private var _h:uint;
    private var _id:uint;
    private var _shareAmount:uint;
    private var _sliderTriggered:Boolean = false;

    public function PersonItem(_w:uint = 480, _PersonName:String = "Hans", _PersonShare:Number = 0.00, id:uint = 0) {
        _personNameShare = _PersonShare;
        this._appModel = AppModel.getInstance();

        _width = _w;
        _leftX = 100;
        _h = 50;
        _id = id;

        // Draw item background
        _itemBg = new Image(Assets.createTextureFromRectShape(_width *.6, 50, 0xf3f3f3));
        _itemBg.x = _leftX;
        addChild(_itemBg);

        _delete = new Image(Assets.getAtlas().getTexture("DeleteIcon"));

        createPanel();

        _personNameField = new TextfieldToggler(150, 40, 20, "PF Ronda Seven", _PersonName , 0xF3F3F3, "My Awesome Person");
        _personNameField.y = _panel.height/2 - _personNameField.height/2;
        _personNameField.x = _itemBg.x + 10;
        _personNameField.addEventListener(Event.CHANGE, nameChangedHandler);

        textOrInput();

        _delete.x = 5;
        _delete.y = (_panel.y + _panel.height/2) - _delete.height/2;
        _delete.alpha = 0;
        addChild(_delete);
    }

    private function nameChangedHandler(event:Event):void {
        dispatchEvent(new Event("NAME_CHANGED"));
    }
    private function textOrInput():void {
        addChild(_personNameField);
        switch (_appModel.currentPage){
            case "EqualSplit":
                    _shareAmount = _personNameShare;
                    buildEqual();
                break;
            case "PercentualSplit":
                    _shareAmount = (_personNameShare/100)*_appModel.bills[_appModel.currentBill].billTotal;
                    trace("_shareAmount = ",_shareAmount);
                    buildEqual();
                    buildSlider();
                break;
            case "AbsoluteSplit":
                    _shareAmount = _personNameShare;
                    buildAbsolute();
                break;
        }
    }

    private function buildSlider():void {

        trace("SLIDER");
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
        var touchedObject:DisplayObject = e.currentTarget as DisplayObject;
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase){
                case TouchPhase.MOVED:
                       _sliderTriggered = true;
                    break;
                case TouchPhase.ENDED:
                    _sliderTriggered = false;
                    break;
            }
        }
    }

    private function buildEqual():void {
        _equalShare = new TextField(180, 30, "0", "OpenSansBold", 18, 0xF3F3F3);
        _equalShare.y = _panel.height/2 - _equalShare.height/2;
        _equalShare.x = (_panel.width + _panel.x) - (_equalShare.width + 10);
        _equalShare.text = "€ " + _shareAmount.toString();
        _equalShare.hAlign = HAlign.RIGHT;
        addChild(_equalShare);
    }

    private function buildAbsolute():void {
        trace("ABSOLUTE");
        _editableShare = new TextfieldToggler(150, 40, 20, "OpenSansBold", "0" , 0xF3F3F3, "My Awesome Person");
        _editableShare.y = _panel.height/2 - _editableShare.height/2;
        _editableShare.x = (_panel.width + _panel.x) - (_editableShare.width + 10);
        _editableShare.text = "€ " + _shareAmount.toString();
        _editableShare.textHAlignRight = true;
        _editableShare.inputRestrict = "0-9\.";
        _editableShare.isNumberInput = true;
        _editableShare.addEventListener(Event.CHANGE, shareChangedHandler);
        addChild(_editableShare);
    }

    private function shareChangedHandler(event:Event):void {
        _share = Number(_editableShare.text);
        dispatchEvent(new Event(Event.CHANGE) );
    }

    private function createPanel():void {
        if(_panel){
            removeChild(_panel);
        }

        var color:uint;
            color = 0xF34A53;
        _panel = new Image(Assets.createTextureFromRectShape(_width * .6, 50, color));
        _panel.x = _width/2 - _panel.width/2;
        addChildAt(_panel, 1);
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

            }else if(_personNameField.x < _leftX){
                _delete.alpha = (objectPosition*-1)/70;;
            }
        }
    }

    public function release():void {
        if(_personNameField.x < 50){
            trace("DELETE PERSON");
            dispatchEventWith("DELETE_PERSON", false);
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
}
}
