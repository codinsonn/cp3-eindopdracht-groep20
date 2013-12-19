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

        createPanel();

        _personNameField = new TextfieldToggler(150, 40, 20, "PF Ronda Seven", _PersonName , 0xF3F3F3, "My Awesome Person");
        _personNameField.y = _panel.height/2 - _personNameField.height/2;
        _personNameField.x = _itemBg.x + 10;

        //SLIDER, STATIC, NOG IETRS

        textOrInput();

        _delete.x = 5;
        _delete.y = (_panel.y + _panel.height/2) - _delete.height/2;
        _delete.alpha = 0;
        addChild(_delete);


    }

    private function textOrInput():void {
        trace("TEXTORINPIUT");
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
        _equalShare = new TextField(180, 30, "0", "OpenSansBold", 18, 0xF3F3F3);
        _equalShare.y = _panel.height/2 - _equalShare.height/2;
        _equalShare.x = (_panel.width + _panel.x) - (_equalShare.width + 10);
        _equalShare.text = "€ " + _personNameShare.toString();
        _equalShare.hAlign = HAlign.RIGHT;
        addChild(_equalShare);
    }

    private function buildAbsolute():void {
        trace("ABSOLUTE");
        _editableShare = new TextfieldToggler(150, 40, 20, "OpenSansBold", "0" , 0xF3F3F3, "My Awesome Person");
        _editableShare.y = _panel.height/2 - _editableShare.height/2;
        _editableShare.x = (_panel.width + _panel.x) - (_editableShare.width + 10);
        _editableShare.text = "€ " + _personNameShare.toString();
        _editableShare.textHAlignRight = true;
        _editableShare.inputRestrict = "0-9\.";
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

        _personNameField.x = ( _itemBg.x + 10) + objectPosition;
        _panel.x = (_personNameField.x-10) - 4;

        if(_equalShare){
        _equalShare.x =(_panel.x + _panel.width) - (_equalShare.width +10) +5;
        }else if(_editableShare){
            _editableShare.x = (_panel.width + _panel.x) - (_editableShare.width + 10);
        }
        if(_personNameField.x > _leftX){

        }else if(_personNameField.x < _leftX){
            _delete.alpha = (objectPosition*-1)/70;;
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
        _delete.alpha = 0;
    }
}
}
