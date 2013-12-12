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

public class AmountAdder extends Sprite {

    public static const ADD_AMOUNT:String = "ADD_AMOUNT";
    public static const SUBTRACT_AMOUNT:String = "SUBTRACT_AMOUNT";

    private var _subtractButton:Button;
    private var _textBackground:Image;
    private var _txtAmount:TextField;
    private var _addButton:Button;

    private var _amount:Number;

    public function AmountAdder(amount:Number = 0.00)
    {
        _amount = amount;

        _subtractButton = new Button(Assets.getTexture("SplitrSubtractButton"));
        _subtractButton.x = 0;
        _subtractButton.addEventListener(TouchEvent.TOUCH, subtractTouchedHandler);
        addChild(_subtractButton);

        _textBackground = new Image(Assets.getTexture("SplitrInputBoxBg"));
        _textBackground.x = 50;
        addChild(_textBackground);

        _txtAmount = new TextField(80, 50, "0", "OpenSansBold", 24, 0x33423e);
        _txtAmount.fontName = "OpenSansBold";
        _txtAmount.text = _amount.toString();
        _txtAmount.x = 60;
        _txtAmount.addEventListener(TouchEvent.TOUCH, textboxTouchedHandler);
        addChild(_txtAmount);

        _addButton = new Button(Assets.getTexture("SplitrAddButton"));
        _addButton.x = 150;
        _addButton.y = _subtractButton.y = _textBackground.y = _txtAmount.y = 0;
        _addButton.addEventListener(TouchEvent.TOUCH, addTouchedHandler);
        addChild(_addButton);
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

    private function textboxTouchedHandler(e:TouchEvent):void {

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
}
}
