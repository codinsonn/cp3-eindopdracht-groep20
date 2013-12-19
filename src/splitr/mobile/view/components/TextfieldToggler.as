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
    private var _active:Boolean = false;

    private var _textHAlignCenter:Boolean = false;
    private var _textVAlignCenter:Boolean = false;
    private var _textHAlignRight:Boolean = false;

    private var _label:TextField;
    private var _input:TextInput;

    public function TextfieldToggler(w:uint = 180, h:uint = 50, fontSize:uint = 18, fontName:String = "OpenSansBold", placeholder:String = "Touch to edit", fontColor:uint = 0x00000, typicalText:String = "My awesome input"){
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
        var touchedObject:DisplayObject = e.currentTarget as DisplayObject;
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase){
                case TouchPhase.ENDED:
                    this.active = true;
                    break;
            }


        }
    }

    private function focusOutHandler(e:Event):void {
        this.active = false;
    }

    private function enterKeyDownHandler(e:Event):void {
        this.active = false;
    }

    public function get text():String {
        return _text;
    }

    public function set textHAlignCenter(value:Boolean):void {
        if(value != _textHAlignCenter){
            _textHAlignCenter = value;
            if(_textHAlignCenter == true){
                _label.hAlign = HAlign.CENTER;
            }
        }
    }

    public function set textVAlignCenter(value:Boolean):void {
        if(value != _textVAlignCenter){
            _textVAlignCenter = value;
            if(_textVAlignCenter == true){
                _label.vAlign = VAlign.CENTER;
            }
        }
    }

    public function set textHAlignRight(value:Boolean):void {

        if(value != _textHAlignRight){
            _textHAlignRight = value;
            if(_textHAlignRight == true){
                _label.hAlign = HAlign.RIGHT;
            }
        }
    }

    public function set showBorder(value:Boolean):void {
        _label.border = value;
    }

    public function set inputRestrict(value:String):void {
        _input.restrict = value;
    }

    public function set maxChars(value:uint):void {
        _input.maxChars = value;
    }

    public function set text(value:String):void {
        if(value != _text){
            _text = value;
            _label.text = _text;
            _input.text = _text;
        }
    }

    public function get active():Boolean {
        return _active;
    }

    public function set active(value:Boolean):void {
        if(_active != value){
            _active = value;

            if(_active == true){
                _label.removeEventListener(TouchEvent.TOUCH, labelTouchedHandler);
                _input.visible = true;
                _input.addEventListener(FeathersEventType.ENTER, enterKeyDownHandler);
                _input.addEventListener(FeathersEventType.FOCUS_OUT, focusOutHandler);
                _input.setFocus();
            }else{
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
        }
    }


}
}
