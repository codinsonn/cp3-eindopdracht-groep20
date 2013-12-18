package splitr.mobile.view.components {

import feathers.controls.Slider;
import feathers.controls.TextInput;

import splitr.model.AppModel;

import splitr.vo.BillVO;

import starling.events.EventDispatcher;

import starling.text.TextField;
import starling.display.Image;
import starling.display.Sprite;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class PersonItem extends Sprite {

    private var _appModel:AppModel;

    public static const EDIT_PERSON:String = "EDIT_PERSON";
    public static const DELETE_PERSON:String = "DELETE_PERSON";

    private var _billVO:BillVO;

    private var _panel:Image;
    private var _delete:Image;
    private var _edit:Image;
    private var _itemBg:Image;

    private var _personNameField:TextfieldToggler;
    private var _personNameShare:uint;

    private var _leftX:uint;
    private var _width:uint;

    private var _editableShare:TextfieldToggler;
    private var _equalShare:TextField;

    private var _shareSlider:Slider;
    private var _h:uint;

    public function PersonItem(_w:uint = 480, _PersonName:String = "Hans", _PersonShare:Number = 0.00) {

        this._appModel = AppModel.getInstance();
        _personNameShare = _PersonShare;

        _width = _w;
        _leftX = 100;
        _h = 50;

        // Draw item background
        _itemBg = new Image(Assets.createTextureFromRectShape(_width *.6, 50, 0xf3f3f3));
        _itemBg.x = _leftX;
        addChild(_itemBg);

        _delete = new Image(Assets.getAtlas().getTexture("DeleteIcon"));
        _edit = new Image(Assets.getAtlas().getTexture("SettleIcon"));

        createPanel();

        _personNameField = new TextfieldToggler(150, 40, 20, "PF Ronda Seven", _PersonName , 0x3FC6F5, "My Awesome Person");
        _personNameField.y = _panel.height/2 - _personNameField.height/2;
        _personNameField.x = _itemBg.x + 10;


        //SLIDER, STATIC, NOG IETRS

        textOrInput();

        _delete.x = 5;
        _delete.y = (_panel.y + _panel.height/2) - _delete.height/2;
        _delete.alpha = 0;
        addChild(_delete);

        _edit.x = _width - _edit.width - 5;
        _edit.y = (_panel.y + _panel.height/2) -    _edit.height/2;
        _edit.alpha = 0;
        addChild(_edit);

    }

    private function textOrInput():void {
        addChild(_personNameField);
        switch (_appModel.currentPage){
            case "EqualSplit":
                    buildEqual();
                break;
            case "PercentualSplit":
                    trace("PROCENTUEEL,SLIDER");

                    buildEqual();
                    buildSlider();
                break;
            case "AbsoluteSplit":
                    buildAbsolute();
                break;
        }
    }

    private function buildSlider():void {

        trace("SLIDER");
        _shareSlider = new Slider();
        _shareSlider.minimum = 0;
        _shareSlider.maximum = 100;
        _shareSlider.value = 50;
        _shareSlider.height = _h;
        _shareSlider.width = _panel.width;
        _shareSlider.y = (_panel.y+_panel.height);
        _shareSlider.x = _panel.x;

        addChild(_shareSlider);
    }

    private function buildEqual():void {
        trace("EQUAL");
        _equalShare = new TextField(180, 30, "0", "OpenSansBold", 18, 0xf3f3f3);
        _equalShare.y = _panel.height/2 - _equalShare.height/2;
        _equalShare.x = (_panel.width + _panel.x) - (_equalShare.width + 10);
        _equalShare.text = "€ " + _personNameShare.toString();
        _equalShare.hAlign = HAlign.RIGHT;
        addChild(_equalShare);
    }

    private function buildAbsolute():void {
        trace("ABSOLUTE");
        _editableShare = new TextfieldToggler(150, 40, 20, "PF Ronda Seven", "0" , 0x3FC6F5, "My Awesome Person");
        _editableShare.y = _panel.height/2 - _editableShare.height/2;
        _editableShare.x = (_panel.width + _panel.x) - (_editableShare.width + 10);
        _editableShare.text = "€ " + _personNameShare.toString();
        _editableShare.textHAlignRight = true;
        addChild(_editableShare);
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
        _personNameField.x = _leftX + objectPosition;
        _panel.x = _personNameField.x - 4;
        _personNameField.x = _personNameField.width + _leftX + objectPosition -5;
        if(_personNameField.x > _leftX){
            _edit.alpha = objectPosition/70;
        }else if(_personNameField.x < _leftX){
            _delete.alpha = (objectPosition*-1)/70;;
        }
    }

    public function release():void {
        if(_personNameField.x > (_leftX + 50)){
            dispatchEventWith("EDIT_PERSON", false);
            textOrInput();
        }else if(_personNameField.x < (_leftX - 50)){
            dispatchEventWith("DELETE_PERSON", false);
        }
        resetElementsX();
    }

    private function resetElementsX():void {
        _personNameField.x = _leftX;
        _panel.x = _leftX - 4;
        _personNameField.x = _personNameField.x + _personNameField.width - 5;
        _delete.alpha = 0;
        _edit.alpha = 0;
    }

    public function get billVO():BillVO {
        return _billVO;
    }

    public function set billVO(value:BillVO):void {
        if(_billVO != value){
            _billVO = value;
            createPanel();
        }
    }
}
}
