package splitr.mobile.view.components {

import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

public class AmountEditor extends Sprite {

    public static const ADD_AMOUNT:String = "ADD_AMOUNT";
    public static const SUBTRACT_AMOUNT:String = "SUBTRACT_AMOUNT";

    private var _subtractButton:Button;
    private var _textBackground:Image;
    private var _txtAmount:TextfieldToggler;
    private var _addButton:Button;

    private var _amount:Number;

    public function AmountEditor(amount:Number = 0.00)
    {
        _amount = amount;

        _subtractButton = new Button(Assets.getAtlas().getTexture("SubtractButton"));
        _subtractButton.x = 0;
        _subtractButton.addEventListener(TouchEvent.TOUCH, subtractTouchedHandler);
        addChild(_subtractButton);

        _textBackground = new Image(Assets.getAtlas().getTexture("InputFieldBg"));
        _textBackground.width = 110;
        _textBackground.x = _subtractButton.width - 1;
        addChild(_textBackground);

        _txtAmount = new TextfieldToggler(110, 50, 20, "PF Ronda Seven", "0.00", 0x46D7C6, "0.00");
        new TextfieldToggler()
        _txtAmount.x = _subtractButton.width;
        _txtAmount.textHAlignCenter = true;
        _txtAmount.maxChars = 6;
        _txtAmount.inputRestrict = "0-9\.";
        _txtAmount.addEventListener(Event.CHANGE, amountChangedHandler);
        addChild(_txtAmount);

        _addButton = new Button(Assets.getAtlas().getTexture("AddButton"));
        _addButton.x = _txtAmount.x + _txtAmount.width - 2;
        _addButton.y = _subtractButton.y = _textBackground.y = _txtAmount.y = 0;
        _addButton.addEventListener(TouchEvent.TOUCH, addTouchedHandler);
        addChild(_addButton);
    }

    private function amountChangedHandler(e:Event):void {
        var amount:String = Number(_txtAmount.text).toFixed(2);
        this._amount = Number(amount);
        _txtAmount.text = amount;
    }

    private function subtractTouchedHandler(e:TouchEvent):void {
        var touchedObject:DisplayObject = e.currentTarget as DisplayObject;
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase){
                case TouchPhase.ENDED:
                    dispatchEvent(new Event("SUBTRACT_AMOUNT"));
                    break;
            }
        }
    }

    private function addTouchedHandler(e:TouchEvent):void {
        var touchedObject:DisplayObject = e.currentTarget as DisplayObject;
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase){
                case TouchPhase.ENDED:
                    dispatchEvent(new Event("ADD_AMOUNT"));
                    break;
            }
        }
    }

    public function get amount():Number {
        return _amount;
    }

    public function set amount(value:Number):void {
        if(value != _amount){
            _amount = value;
            _txtAmount.text = _amount.toString();
        }
    }
}
}
