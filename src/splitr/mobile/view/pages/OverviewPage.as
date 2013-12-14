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
    private var _overviewItem:OverviewItem;
    private var _startDragX:Number;
    private var _startPanelX:Number;
    private var _w:uint;
    private var _billList:ScrollContainer;
    private var _listOption:ToggleSwitch;

    public function OverviewPage(w) {
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
        if(!_billList){
            _billList = new ScrollContainer();
            addChild(_billList);
        }else{
            removeChild(_billList);
            addChild(_billList);
        }

        _billList.width = 480;
        _billList.height = 500;
        _billList.y = 200;

        //for each(var bill in _appModel.bills){
        for (var i:Number=0; i<20;){
            // DEMOLOOP
            _overviewItem = new OverviewItem(_w);
            _overviewItem.resizedHandler();
            _overviewItem.addEventListener(TouchEvent.TOUCH, touchHandler);


            switch(show)
            {
                case "all":
                        trace("ALL");
                        _billList.addChild(_overviewItem);
                        _overviewItem.y = _overviewItem.height*i;
                    break;
                case "settledOn":

                    if(_overviewItem.settled == true){
                        trace("SETTLED: ", _overviewItem.settled);
                    _billList.addChild(_overviewItem);
                    _overviewItem.y = _overviewItem.height*i;
                    }
                    break;
                case "settledOff":

                    if(_overviewItem.settled == false){
                        trace("SETTLED: ", _overviewItem.settled);
                    _billList.addChild(_overviewItem);
                    _overviewItem.y = _overviewItem.height*i;
                    }
                    break;
            }

            i++
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

}
}
