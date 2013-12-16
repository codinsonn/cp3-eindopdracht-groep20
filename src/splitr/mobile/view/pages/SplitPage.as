package splitr.mobile.view.pages {

import feathers.controls.PanelScreen;

import splitr.mobile.view.components.AmountEditor;
import splitr.mobile.view.components.NumStepper;
import splitr.mobile.view.components.TextfieldToggler;

import starling.display.Button;
import starling.display.Image;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class SplitPage extends PanelScreen {

    private var _billIcon:Image;
    private var _txtBillTitle:TextfieldToggler;
    private var _txtBillTotal:TextField;
    private var _photoRefButton:Button;
    private var _lblEditTotal:TextField;
    private var _editTotal:AmountEditor;
    private var _lblNumPeople:TextField;
    private var _setNumPeople:NumStepper;

    private var _billTotal:Number = 0.00;

    public function SplitPage(w:uint = 480) {

        _billIcon = new Image(Assets.getAtlas().getTexture("BillIcon"));
        _billIcon.x = 40;
        _billIcon.y = 35;
        addChild(_billIcon);

        _txtBillTitle = new TextfieldToggler(180, 60, 21, "OpenSansBold", "Add title", 0x3FC6F5, "My Awesome Bill");
        _txtBillTitle.y = 30;
        addChild(_txtBillTitle);

        _txtBillTotal = new TextField(180, 28, "0", "OpenSansBold", 19, 0x3FC6F5);
        _txtBillTotal.fontName = "OpenSansBold";
        _txtBillTotal.hAlign = HAlign.LEFT;
        _txtBillTotal.vAlign = VAlign.CENTER;
        _txtBillTotal.y = 75;
        addChild(_txtBillTotal);

        _photoRefButton = new Button(Assets.getAtlas().getTexture("PhotoRefButton"));
        _photoRefButton.y = 50;
        _photoRefButton.addEventListener(TouchEvent.TOUCH, photoRefButtonTouched);
        addChild(_photoRefButton);

        _lblEditTotal = new TextField(180, 30, "0", "OpenSansBold", 24, 0x3FC6F5);
        _lblEditTotal.fontName = "OpenSansBold";
        _lblEditTotal.text = "Edit total:";
        _lblEditTotal.hAlign = HAlign.LEFT;
        _lblEditTotal.vAlign = VAlign.CENTER;
        _lblEditTotal.x = 40;
        _lblEditTotal.y = 140;
        addChild(_lblEditTotal);

        _editTotal = new AmountEditor();
        _editTotal.y = 135;
        _editTotal.addEventListener(AmountEditor.ADD_AMOUNT, addToTotalHandler);
        _editTotal.addEventListener(AmountEditor.SUBTRACT_AMOUNT, subtractFromTotalHandler);
        addChild(_editTotal);

        _lblNumPeople = new TextField(180, 30, "0", "OpenSansBold", 24, 0x3FC6F5);
        _lblNumPeople.fontName = "OpenSansBold";
        _lblNumPeople.text = "Num people:";
        _lblNumPeople.hAlign = HAlign.LEFT;
        _lblNumPeople.vAlign = VAlign.CENTER;
        _lblNumPeople.x = 40;
        _lblNumPeople.y = 210;
        addChild(_lblNumPeople);

        _setNumPeople = new NumStepper(2);
        _setNumPeople.y = 213;
        _setNumPeople.addEventListener(Event.CHANGE, numPeopleChangedHandler);
        addChild(_setNumPeople);

        _txtBillTitle.x = _txtBillTotal.x = _billIcon.x + _billIcon.width + 10;
        _photoRefButton.x = w - _photoRefButton.width - 40;
        _editTotal.x = w - _editTotal.width - 40;
        _setNumPeople.x = w - _setNumPeople.width - 40;

        billTotalChangedHandler();

    }

    private function numPeopleChangedHandler(e:Event):void {

    }

    private function subtractFromTotalHandler(e:Event):void {
        trace("[Splitr]", "Amount subtracted from total: ", _editTotal.amount);
        if(_billTotal - _editTotal.amount >= 0.00){
            _billTotal -= _editTotal.amount;
        }else{
            _billTotal = 0.00;
        }

        billTotalChangedHandler();
    }

    private function addToTotalHandler(e:Event):void {
        trace("[Splitr]", "Amount added to total: ", _editTotal.amount);
        _billTotal += _editTotal.amount;

        billTotalChangedHandler();
    }

    private function billTotalChangedHandler(e:Event = null):void{
        _txtBillTotal.text = _billTotal.toString() + " EUR";
        _editTotal.amount = 0.00;
    }

    private function photoRefButtonTouched(e:TouchEvent):void {

    }

}
}
