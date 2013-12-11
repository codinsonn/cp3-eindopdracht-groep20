package splitr.mobile.view {

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.text.TextField;

public class NumToggler extends Sprite {

    private var _subtractButton:Button;
    private var _txtNumber:TextField;
    private var _addButton:Button;

    private var _number:uint;

    public function NumToggler(num:uint = 1){
        _number = num;

        _subtractButton = new Button(Assets.getTexture("SplitrNumTogglerSubtractButton"));
        _subtractButton.x = 0;
        _subtractButton.addEventListener(TouchEvent.TOUCH, subtractTouchedHandler);
        addChild(_subtractButton);

        _txtNumber = new TextField(50, 50, "0", "OpenSansBold", 24, 0x33423e);
        _txtNumber.fontName = "OpenSansBold";
        _txtNumber.text = _number.toString();
        _txtNumber.x = _subtractButton.width;
        _txtNumber.addEventListener(TouchEvent.TOUCH, txtNumberTouchedHandler);
        addChild(_txtNumber);

        _addButton = new Button(Assets.getTexture("SplitrNumTogglerAddButton"));
        _addButton.x = _txtNumber.x + _txtNumber.width;
        _addButton.y = _subtractButton.y = _txtNumber.y = 0;
        _addButton.addEventListener(TouchEvent.TOUCH, addTouchedHandler);
        addChild(_addButton);
    }

    private function subtractTouchedHandler(e:TouchEvent):void {
        dispatchEvent(new Event(Event.CHANGE));

    }

    private function txtNumberTouchedHandler(e:TouchEvent):void {

    }

    private function addTouchedHandler(e:TouchEvent):void {
        dispatchEvent(new Event(Event.CHANGE));

    }

}
}
