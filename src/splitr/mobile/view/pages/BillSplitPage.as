package splitr.mobile.view.pages {

import splitr.mobile.view.components.AmountAdder;
import splitr.mobile.view.components.AmountToggler;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.events.ResizeEvent;
import starling.events.TouchEvent;
import starling.text.TextField;

public class BillSplitPage extends Page {

    private var _billIcon:Image;
    private var _txtBillTitle:TextField;
    private var _txtBillTotal:TextField;
    private var _photoRefButton:Button;
    private var _lblEditTotal:TextField;
    private var _addToTotal:AmountAdder;
    private var _lblNumPeople:TextField;
    private var _setNumPeople:AmountToggler;

    private var _billTotal:Number = 0.00;

    public function BillSplitPage(){

        _billIcon = new Image(Assets.getTexture("SplitrBillIcon"));
        _billIcon.x = 40;
        _billIcon.y = 85;
        addChild(_billIcon);

        _txtBillTitle = new TextField(180, 30, "0", "OpenSansBold", 24, 0x33423e);
        _txtBillTitle.fontName = "OpenSansBold";
        _txtBillTitle.text = "Add Title";
        _txtBillTitle.y = 60;
        addChild(_txtBillTitle);

        _txtBillTotal = new TextField(180, 30, "0", "OpenSansBold", 19, 0x33423e);
        _txtBillTotal.fontName = "OpenSansBold";
        _txtBillTotal.text = _billTotal.toString() + " EUR";
        _txtBillTotal.y = 80;
        addChild(_txtBillTitle);

        _photoRefButton = new Button(Assets.getTexture("SplitrPhotoRefButton"));
        _photoRefButton.y = 115;
        _photoRefButton.addEventListener(TouchEvent.TOUCH, photoRefButtonTouched);
        addChild(_photoRefButton);

        _lblEditTotal = new TextField(180, 30, "0", "OpenSansBold", 24, 0x33423e);
        _lblEditTotal.fontName = "OpenSansBold";
        _lblEditTotal.text = "Edit total:";
        _lblEditTotal.x = 40;
        _lblEditTotal.y = 190;
        addChild(_lblEditTotal);

        _addToTotal = new AmountAdder();
        _addToTotal.y = 190;
        _addToTotal.addEventListener(AmountAdder.ADD_AMOUNT, addToTotalHandler);
        _addToTotal.addEventListener(AmountAdder.SUBTRACT_AMOUNT, subtractFromTotalHandler);
        addChild(_addToTotal);

        _lblNumPeople = new TextField(180, 30, "0", "OpenSansBold", 24, 0x33423e);
        _lblNumPeople.fontName = "OpenSansBold";
        _lblNumPeople.text = "Num people:";
        _lblNumPeople.x = 40;
        _lblNumPeople.y = 260;
        addChild(_lblNumPeople);

        _setNumPeople = new AmountToggler(2);
        _setNumPeople.y = 260;
        _setNumPeople.addEventListener(Event.CHANGE, numPeopleChangedHandler);
        addChild(_setNumPeople);

        headerResizedHandler();

    }

    private function numPeopleChangedHandler(e:Event):void {

    }

    private function subtractFromTotalHandler(e:AmountAdder):void {

    }

    private function addToTotalHandler(e:Event):void {

    }

    private function photoRefButtonTouched(e:TouchEvent):void {

    }

    public function headerResizedHandler(w:uint = 480, h:uint = 800):void{

        this.setPageSize(w, h);

        // Apply appropriate positioning
        _txtBillTitle.x = _billIcon.x + _billIcon.width + 10;
        _txtBillTotal.x = _txtBillTitle.x;
        _photoRefButton.x = w - _photoRefButton.width - 40;
        _addToTotal.x = w - _addToTotal.width - 40;
        _setNumPeople.x = w - _addToTotal.width - 40;

    }

}
}
