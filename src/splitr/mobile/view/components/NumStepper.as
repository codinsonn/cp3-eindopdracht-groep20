package splitr.mobile.view.components {

import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

public class NumStepper extends Sprite {

    private var _subtractButton:Button;
    private var _txtAmount:TextField;
    private var _addButton:Button;

    private var _amount:uint;

    public function NumStepper(amount:uint = 1){
        _amount = amount;

        _subtractButton = new Button(Assets.getAtlas().getTexture("PrevButtonIcon"));
        _subtractButton.x = 0;
        _subtractButton.addEventListener(TouchEvent.TOUCH, subtractTouchedHandler);
        addChild(_subtractButton);

        _txtAmount = new TextField(50, 30, "0", "OpenSansBold", 24, 0x3FC6F5);
        _txtAmount.fontName = "OpenSansBold";
        _txtAmount.text = _amount.toString();
        _txtAmount.touchable = true;
        _txtAmount.x = _subtractButton.width;
        _txtAmount.addEventListener(TouchEvent.TOUCH, txtNumberTouchedHandler);
        addChild(_txtAmount);

        _addButton = new Button(Assets.getAtlas().getTexture("NextButtonIcon"));
        _addButton.x = _txtAmount.x + _txtAmount.width;
        _addButton.y = _subtractButton.y = _txtAmount.y = 0;
        _addButton.addEventListener(TouchEvent.TOUCH, addTouchedHandler);
        addChild(_addButton);
    }

    private function subtractTouchedHandler(e:TouchEvent):void {
        var touchedObject:DisplayObject = e.currentTarget as DisplayObject;
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase){
                case TouchPhase.ENDED:
                    if(_amount > 1){
                        _amount--;
                        _txtAmount.text = _amount.toString();
                        dispatchEvent(new Event(Event.CHANGE));
                    }
                    break;
            }
        }
    }

    private function txtNumberTouchedHandler(e:TouchEvent):void {

    }

    private function addTouchedHandler(e:TouchEvent):void {
        var touchedObject:DisplayObject = e.currentTarget as DisplayObject;
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase){
                case TouchPhase.ENDED:
                    _amount++;
                    _txtAmount.text = _amount.toString();
                    dispatchEvent(new Event(Event.CHANGE));
                    break;
            }
        }
    }

}
}
