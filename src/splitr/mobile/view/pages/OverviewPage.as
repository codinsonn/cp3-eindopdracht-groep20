package splitr.mobile.view.pages {

import splitr.mobile.view.components.OverviewItem;
import splitr.model.AppModel;

import starling.display.DisplayObject;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class OverviewPage extends Page {

    private var _appModel:AppModel;
    private var _overviewItem:OverviewItem;
    private var _startDragX:Number;
    private var _startPanelX:Number;
    private var _w:uint;


    public function OverviewPage(w:uint = 480) {
        _w = w;
        _appModel = AppModel.getInstance();
        _appModel.currentPage = "Overview";

        if(!_overviewItem){
            _overviewItem = new OverviewItem(_w);
           this.addChild(_overviewItem);
        }
        _overviewItem.resizedHandler();
        _overviewItem.y = 200;
        _overviewItem.addEventListener(TouchEvent.TOUCH, touchHandler);
    }

    private function touchHandler(event:TouchEvent):void {

        var touchedObject:DisplayObject = event.currentTarget as DisplayObject;
        var touch:Touch = event.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase) {
                case TouchPhase.BEGAN:

                    trace("started");
                    //save de global X
                    _startDragX = touch.globalX;
                    _startPanelX = _overviewItem.x;
                    break;
                case TouchPhase.MOVED:
                    var diffX:Number = touch.globalX - _startDragX;
                    _overviewItem.x = (_startPanelX + diffX)/3;
                    _overviewItem.scaleOption;
                    trace("moved");
                    break;
                case TouchPhase.ENDED:
                    trace("ended");
                    //TWEENTERUG
                    _overviewItem.x = 0;
                    break;
            }
        }
    }

    public function resizedHandler(w:uint = 480, h:uint = 800):void{

        this.setPageSize(w, h);



    }

}
}
