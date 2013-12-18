package splitr.mobile.view.pages {

import feathers.controls.PanelScreen;

import splitr.mobile.view.components.AmountEditor;
import splitr.mobile.view.components.NumStepper;
import splitr.mobile.view.components.PersonList;
import splitr.mobile.view.components.TextfieldToggler;
import splitr.model.AppModel;
import splitr.vo.BillVO;
import splitr.vo.PersonVO;

import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class SplitPage extends PanelScreen {

    private var _appModel:AppModel;
    private var _headerBackButton:Button;

    private var _billIcon:Image;
    private var _txtBillTitle:TextfieldToggler;
    private var _txtBillTotal:TextField;
    private var _photoRefButton:Button;
    private var _lblEditTotal:TextField;
    private var _editTotal:AmountEditor;

    private var _personList:PersonList;

    public function SplitPage(w:uint = 480) {

        _appModel = AppModel.getInstance();

        if(_appModel.createNewPage == true){
            var _billId:uint = _appModel.bills.length;
            _appModel.currentBill = _billId;
            _appModel.bills[_appModel.currentBill] = new BillVO();
            _appModel.bills[_appModel.currentBill].billId = _billId;
            _appModel.createNewPage = false;
        }

        _headerBackButton = new Button(Assets.getAtlas().getTexture("HeaderPrevButton"));
        _headerBackButton.addEventListener(Event.TRIGGERED, backButtonTriggeredHandler);
        headerProperties.leftItems = new <DisplayObject>[_headerBackButton];

        switch (_appModel.currentPage){
            case "EqualSplit":
                _billIcon = new Image(Assets.getAtlas().getTexture("EqualBillIcon"));
                break;
            case "PercentualSplit":
                _billIcon = new Image(Assets.getAtlas().getTexture("PercentualBillIcon"));
                break;
            case "AbsoluteSplit":
                _billIcon = new Image(Assets.getAtlas().getTexture("AbsoluteBillIcon"));
                break;
        }
        _billIcon.x = 40;
        _billIcon.y = 35;
        addChild(_billIcon);

        _txtBillTitle = new TextfieldToggler(200, 50, 20, "PF Ronda Seven", _appModel.bills[_appModel.currentBill].billTitle, 0x3FC6F5, "My Awesome Bill");
        _txtBillTitle.y = 30;
        _txtBillTitle.maxChars = 20;
        _txtBillTitle.addEventListener(Event.CHANGE, billTitleChangedHandler);
        addChild(_txtBillTitle);

        _txtBillTotal = new TextField(180, 28, "0", "PF Ronda Seven", 17, 0x3FC6F5);
        _txtBillTotal.fontName = "PF Ronda Seven";
        _txtBillTotal.hAlign = HAlign.LEFT;
        _txtBillTotal.vAlign = VAlign.CENTER;
        _txtBillTotal.y = 75;
        addChild(_txtBillTotal);

        _photoRefButton = new Button(Assets.getAtlas().getTexture("PhotoRefButton"));
        _photoRefButton.y = 50;
        _photoRefButton.addEventListener(Event.TRIGGERED, photoRefButtonTriggered);
        addChild(_photoRefButton);

        _lblEditTotal = new TextField(180, 30, "0", "OpenSansBold", 24, 0x46D7C6);
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

        _txtBillTitle.x = _txtBillTotal.x = _billIcon.x + _billIcon.width + 10;
        _photoRefButton.x = w - _photoRefButton.width - 40;
        _editTotal.x = w - _editTotal.width - 40;

        _personList = new PersonList(480, 400);
        addChild(_personList);
        _personList.y = 210;

        billTotalChangedHandler();

    }

    private function billTitleChangedHandler(e:Event):void {
        _appModel.bills[_appModel.currentBill].billTitle = _txtBillTitle.text;
    }

    private function backButtonTriggeredHandler(e:Event):void {
        _appModel.save();
        _appModel.currentPage = "Overview";
    }

    private function subtractFromTotalHandler(e:Event):void {
        if(_appModel.bills[_appModel.currentBill].billTotal - _editTotal.amount >= 0.00){
            _appModel.bills[_appModel.currentBill].billTotal -= _editTotal.amount;
        }else{
            _appModel.bills[_appModel.currentBill].billTotal = 0.00;
        }

        billTotalChangedHandler();
    }

    private function addToTotalHandler(e:Event):void {
        _appModel.bills[_appModel.currentBill].billTotal += _editTotal.amount;

        billTotalChangedHandler();
    }

    private function billTotalChangedHandler(e:Event = null):void{
        _txtBillTotal.text = _appModel.bills[_appModel.currentBill].billTotal.toString() + " EUR";
        _editTotal.amount = 0.00;
    }

    private function photoRefButtonTriggered(e:Event):void {
        _appModel.currentPage = "PhotoReference";
    }

}
}
