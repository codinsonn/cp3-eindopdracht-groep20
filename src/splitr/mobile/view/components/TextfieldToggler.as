package splitr.mobile.view.components {

import feathers.controls.TextInput;
import feathers.events.FeathersEventType;

import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class TextfieldToggler extends Sprite {

    private var _text:String;
    private var _placeholder:String;

    private var _textAlignCenter:Boolean = false;
    private var _showBorder:Boolean = false;
    private var _inputRestrict:String;
    private var _maxChars:uint;

    private var _label:TextField;
    private var _input:TextInput;

    public function TextfieldToggler(w:uint = 180, h:uint = 60, fontSize:uint = 18, fontName:String = "OpenSansBold", placeholder:String = "Touch to edit", fontColor:uint = 0x00000, typicalText:String = "My awesome input"){
        this._placeholder = placeholder;

        _label = new TextField(w, h, "0", fontName, fontSize, fontColor);
        _label.fontName = fontName;
        _label.text = _placeholder;
        _label.hAlign = HAlign.LEFT;
        _label.vAlign = VAlign.CENTER;
        _label.x = _label.y = 0;
        _label.addEventListener(TouchEvent.TOUCH, labelTouchedHandler);
        addChild(_label);

        _input = new TextInput();
        _input.typicalText = typicalText;
        _input.visible = false;
        _input.width = w;
        _input.x = _input.y = 0;
        addChild(_input);

    }

    private function labelTouchedHandler(e:TouchEvent):void {
        _label.removeEventListener(TouchEvent.TOUCH, labelTouchedHandler);
        _input.visible = true;
        _input.addEventListener(FeathersEventType.ENTER, enterKeyDownHandler);
        _input.addEventListener(FeathersEventType.FOCUS_OUT, focusOutHandler);
        _input.setFocus();
    }

    private function focusOutHandler(e:Event):void {
        updateLabel();
    }

    private function enterKeyDownHandler(e:Event):void {
        updateLabel();
    }

    private function updateLabel():void{
        _input.visible = false;
        _input.removeEventListener(FeathersEventType.ENTER, enterKeyDownHandler);
        _input.removeEventListener(FeathersEventType.FOCUS_OUT, focusOutHandler);

        if(_input.text != ""){
            _text = _input.text;
        }else{
            _text = _placeholder;
        }
        _label.text = _text;
        dispatchEvent(new Event(Event.CHANGE));

        _input.visible = false;
        _label.addEventListener(TouchEvent.TOUCH, labelTouchedHandler);
    }

    public function get text():String {
        return _text;
    }

    public function set textAlignCenter(value:Boolean):void {
        if(value != _textAlignCenter){
            _textAlignCenter = value;
            if(_textAlignCenter == true){
                _label.hAlign = HAlign.CENTER;
            }
        }

    }

    public function set showBorder(value:Boolean):void {
        if(value != _showBorder){
            _showBorder = value;
            _label.border = _showBorder;
        }
    }

    public function set inputRestrict(value:String):void {
        _inputRestrict = value;
        _input.restrict = _inputRestrict;
    }

    public function set maxChars(value:uint):void {
        _maxChars = value;
        _input.maxChars = _maxChars;
    }

    public function set text(value:String):void {
        if(value != _text){
            _text = value;
            _label.text = _text;
        }
    }
}
}
