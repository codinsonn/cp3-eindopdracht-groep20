package splitr.mobile.view.pages {

import feathers.controls.PanelScreen;

import flash.events.Event;

import splitr.mobile.view.components.AmountEditor;
import splitr.mobile.view.components.PersonList;
import splitr.mobile.view.components.TextfieldToggler;
import splitr.model.AppModel;
import splitr.model.services.CalculatorService;
import splitr.vo.BillVO;

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
    private var _editTotal:AmountEditor;
    private var calcService:CalculatorService;

    private var _personList:PersonList;

    public function SplitPage(w:uint = 480) {

        _appModel = AppModel.getInstance();
        calcService = CalculatorService.getInstance();
        this._horizontalScrollPolicy = SCROLL_POLICY_OFF;
        calcService.addEventListener(CalculatorService.NEW_TOTAL, newTotalHandler);

        if(_appModel.createNewPage == true){
            var _billId:uint = _appModel.bills.length;
            _appModel.currentBill = _billId;
            _appModel.bills[_appModel.currentBill] = new BillVO();
            _appModel.bills[_appModel.currentBill].billId = _billId;
            _appModel.createNewPage = false;
        }

        _headerBackButton = new Button(Assets.getAtlas().getTexture("HeaderPrevButton"));
        _headerBackButton.addEventListener(starling.events.Event.TRIGGERED, backButtonTriggeredHandler);
        headerProperties.leftItems = new <DisplayObject>[_headerBackButton];

        switch (_appModel.currentPage){
            case "EqualSplit":
                _appModel.bills[_appModel.currentBill].billType = "Equal";
                this.headerProperties.title = "SPLIT EQUAL";
                _billIcon = new Image(Assets.getAtlas().getTexture("EqualBillIcon"));
                break;
            case "PercentualSplit":
                _appModel.bills[_appModel.currentBill].billType = "Percentual";
                this.headerProperties.title = "SPLIT PERCENTUAL";
                _billIcon = new Image(Assets.getAtlas().getTexture("PercentualBillIcon"));
                break;
            case "AbsoluteSplit":
                _appModel.bills[_appModel.currentBill].billType = "Absolute";
                this.headerProperties.title = "SPLIT ABSOLUTE";
                _billIcon = new Image(Assets.getAtlas().getTexture("AbsoluteBillIcon"));
                break;
        }
        _billIcon.x = 40;
        _billIcon.y = 35;
        addChild(_billIcon);

        _txtBillTitle = new TextfieldToggler(200, 50, 20, "PF Ronda Seven", _appModel.bills[_appModel.currentBill].billTitle, 0x3FC6F5, "My Awesome Bill");
        _txtBillTitle.y = 30;
        _txtBillTitle.maxChars = 20;
        _txtBillTitle.addEventListener(starling.events.Event.CHANGE, billTitleChangedHandler);
        addChild(_txtBillTitle);

        _txtBillTotal = new TextField(180, 28, "0", "PF Ronda Seven", 17, 0x3FC6F5);
        _txtBillTotal.fontName = "PF Ronda Seven";
        _txtBillTotal.hAlign = HAlign.LEFT;
        _txtBillTotal.vAlign = VAlign.CENTER;
        _txtBillTotal.y = 75;
        addChild(_txtBillTotal);

        _photoRefButton = new Button(Assets.getAtlas().getTexture("PhotoRefButton"));
        _photoRefButton.y = 50;
        _photoRefButton.addEventListener(starling.events.Event.TRIGGERED, photoRefButtonTriggered);
        addChild(_photoRefButton);

        if(_appModel.currentPage != "AbsoluteSplit"){
            var lblEditTotal:TextField = new TextField(180, 50, "0", "OpenSansBold", 20, 0x46D7C6);
            lblEditTotal.text = "ADD TO TOTAL";
            lblEditTotal.hAlign = HAlign.LEFT;
            lblEditTotal.x = 40;
            lblEditTotal.y = 135;
            addChild(lblEditTotal);

            _editTotal = new AmountEditor();
            _editTotal.y = 135;
            _editTotal.addEventListener(AmountEditor.ADD_AMOUNT, addToTotalHandler);
            _editTotal.addEventListener(AmountEditor.SUBTRACT_AMOUNT, subtractFromTotalHandler);
            addChild(_editTotal);
            _editTotal.x = w - _editTotal.width - 40;

            _personList = new PersonList(480, 400);
            _personList.y = 210;
        }else{
            _personList = new PersonList(480, 480);
            _personList.y = 130;
        }
        addChild(_personList);

        _txtBillTitle.x = _txtBillTotal.x = _billIcon.x + _billIcon.width + 10;
        _photoRefButton.x = w - _photoRefButton.width - 40;

        billTotalChangedHandler();
    }

    private function newTotalHandler(event:flash.events.Event):void {
        trace("newTotalHandler");
        billTotalChangedHandler();
    }


    private function billTitleChangedHandler(e:starling.events.Event):void {
        _appModel.bills[_appModel.currentBill].billTitle = _txtBillTitle.text;
    }

    private function backButtonTriggeredHandler(e:starling.events.Event):void {
        _appModel.save();
        _appModel.currentPage = "Overview";
    }

    private function subtractFromTotalHandler(e:starling.events.Event):void {
        if(_appModel.bills[_appModel.currentBill].billTotal - _editTotal.amount >= 0.00){
            _appModel.bills[_appModel.currentBill].billTotal -= _editTotal.amount;
        }else{
            _appModel.bills[_appModel.currentBill].billTotal = 0.00;
        }

        billTotalChangedHandler();
    }

    private function addToTotalHandler(e:starling.events.Event):void {
        _appModel.bills[_appModel.currentBill].billTotal += _editTotal.amount;

        billTotalChangedHandler();
    }

    private function billTotalChangedHandler(e:starling.events.Event = null):void{
        calcService.methodByPage();
        calcService.refreshList();
        _txtBillTotal.text = _appModel.bills[_appModel.currentBill].billTotal.toString() + " EUR";
        if(_editTotal){
        _editTotal.amount = 0.00;
        }
    }

    private function photoRefButtonTriggered(e:starling.events.Event):void {
        _appModel.currentPage = "PhotoReference";
    }

}
}
