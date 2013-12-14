package splitr.mobile.view.pages {

import feathers.controls.Radio;
import feathers.controls.ScrollContainer;
import feathers.controls.ToggleSwitch;
import feathers.core.ToggleGroup;

import splitr.mobile.view.components.OverviewItem;
import splitr.model.AppModel;

import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class OverviewPage extends Page {

    private var _appModel:AppModel;
    // private var _overviewItem:OverviewItem;
    private var _startDragX:Number;
    private var _startPanelX:Number;
    private var _w:uint;
    private var _billList:ScrollContainer;
    private var _bills:Array;
    private var _listOption:ToggleSwitch;

    public function OverviewPage(w:uint = 480) {
        _w = w;
        _appModel = AppModel.getInstance();
        _appModel.currentPage = "overview";

        _listOption = new ToggleSwitch();
        _listOption.isSelected = true;
        addChild(_listOption);
        _listOption.y = 110;
        _listOption.isSelected = true;
        _listOption.width = 100;
        _listOption.addEventListener( Event.CHANGE, optionHandler );

        createList("all");

    }

    private function createList(show:String):void {
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
            var overviewItem:OverviewItem = new OverviewItem(_w);

            switch(show)
            {
                case "all":
                    trace("[OverviewPage]", "----------- ", show, " ----------------");
                    _billList.addChild(overviewItem);
                    overviewItem.resizedHandler();
                    overviewItem.addEventListener(TouchEvent.TOUCH, touchHandler);
                    _bills.push(overviewItem);
                    overviewItem.y = overviewItem.height * _bills.length;
                    break;
                case "settledOn":
                    trace("[OverviewPage]", "----------- ", show, " ----------------");
                    if(overviewItem.settled == false){
                        trace("SETTLED:", overviewItem.settled);
                        _billList.addChild(overviewItem);
                        overviewItem.resizedHandler();
                        overviewItem.addEventListener(TouchEvent.TOUCH, touchHandler);
                        _bills.push(overviewItem);
                        overviewItem.y = overviewItem.height * _bills.length;
                    }
                    break;
                case "settledOff":
                    trace("[OverviewPage]", "----------- ", show, " ----------------");
                    if(overviewItem.settled == true){
                        trace("UNSETTLED:", overviewItem.settled);
                        _billList.addChild(overviewItem);
                        overviewItem.resizedHandler();
                        overviewItem.addEventListener(TouchEvent.TOUCH, touchHandler);
                        _bills.push(overviewItem);
                        overviewItem.y = overviewItem.height * _bills.length;
                    }
                    break;
            }
        }
    }

    private function optionHandler(event:Event):void {
        if(_listOption.isSelected == true){
            createList("settledOn");
        }else{
            createList("settledOff");
        }
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

    public function resizedHandler(w:uint = 480, h:uint = 800):void{

        this.setPageSize(w, h);

    }

}
}
