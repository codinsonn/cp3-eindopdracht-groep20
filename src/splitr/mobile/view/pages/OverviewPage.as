package splitr.mobile.view.pages {

import feathers.controls.PanelScreen;
import feathers.controls.ScrollContainer;
import feathers.controls.ToggleSwitch;

import splitr.mobile.view.components.OverviewItem;

import splitr.model.AppModel;

import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class OverviewPage extends PanelScreen {

    private var _appModel:AppModel;

    private var _width:uint;

    private var _startDragX:Number;
    private var _startPanelX:Number;
    private var _billList:ScrollContainer;
    private var _bills:Array;
    private var _listOption:ToggleSwitch;

    public function OverviewPage(w:uint = 480) {

        this._appModel = AppModel.getInstance();
        //_appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

        this._width = w;

        // Set header title
        this.headerProperties.title = "SPLITR";

        _listOption = new ToggleSwitch();
        _listOption.x = _width/2 - _listOption.width/2;
        _listOption.y = 110;
        _listOption.isSelected = true;
        _listOption.width = 100;
        _listOption.addEventListener(Event.CHANGE, optionHandler);
        addChild(_listOption);

        createList();

    }

    private function optionHandler(e:Event):void {
        if(_listOption.isSelected == true){
            createList("Settled");
        }else{
            createList("Unsettled");
        }
    }

    private function createList(billsToShow:String = "All"):void {
        if(_billList){
            removeChild(_billList);
        }

        _billList = new ScrollContainer();
        addChild(_billList);

        _billList.width = 480;
        _billList.height = 500;
        _billList.y = 200;

        _bills = new Array();

        //for each(var bill in _appModel.bills){
        for (var i:Number=0; i<20; i++){
            // DEMOLOOP
            var overviewItem:OverviewItem = new OverviewItem(_width);

            switch(billsToShow)
            {
                case "Settled":
                    if(overviewItem.settled == false){
                        //trace("SETTLED:", overviewItem.settled);
                        _billList.addChild(overviewItem);
                        overviewItem.resizedHandler();
                        overviewItem.addEventListener(TouchEvent.TOUCH, touchHandler);
                        overviewItem.addEventListener(OverviewItem.EDIT_BILL, editBillHandler);
                        overviewItem.addEventListener(OverviewItem.DELETE_BILL, deleteBillHandler);
                        _bills.push(overviewItem);
                        overviewItem.y = overviewItem.height * _bills.length;
                    }
                    break;
                case "Unsettled":
                    if(overviewItem.settled == true){
                        //trace("UNSETTLED:", overviewItem.settled);
                        _billList.addChild(overviewItem);
                        overviewItem.resizedHandler();
                        overviewItem.addEventListener(TouchEvent.TOUCH, touchHandler);
                        _bills.push(overviewItem);
                        overviewItem.y = overviewItem.height * _bills.length;
                    }
                    break;
                case "All":
                default:
                    _billList.addChild(overviewItem);
                    overviewItem.resizedHandler();
                    overviewItem.addEventListener(TouchEvent.TOUCH, touchHandler);
                    _bills.push(overviewItem);
                    overviewItem.y = overviewItem.height * _bills.length;
                    break;
            }
        }
    }

    private function deleteBillHandler(e:Event):void {
        var bill:OverviewItem = e.currentTarget as OverviewItem;
        trace("[Overview]", "Delete Bill:", bill);
    }

    private function editBillHandler(e:Event):void {
        var bill:OverviewItem = e.currentTarget as OverviewItem;
        trace("[Overview]", "Edit Bill:", bill);
    }

    private function touchHandler(event:TouchEvent):void {
        var touchedObject:OverviewItem = event.currentTarget as OverviewItem;
        var elementsX:Number = new Number();
        var touch:Touch = event.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase) {
                case TouchPhase.BEGAN:
                    _startDragX = touch.globalX;
                    _startPanelX = touchedObject.x;
                    break;
                case TouchPhase.MOVED:
                    var diffX:Number = touch.globalX - _startDragX;
                    elementsX = (_startPanelX + diffX)/5;
                    touchedObject.setElementsX(elementsX);
                    break;
                case TouchPhase.ENDED:
                    touchedObject.release();
                    break;
            }
        }
    }

}
}
