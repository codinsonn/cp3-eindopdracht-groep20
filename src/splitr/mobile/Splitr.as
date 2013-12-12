package splitr.mobile {

import feathers.themes.MetalWorksMobileTheme;

import flash.events.Event;

import splitr.mobile.view.Footer;
import splitr.mobile.view.Header;
import splitr.mobile.view.components.OverviewItem;
import splitr.mobile.view.pages.EqualBillsplitPage;
import splitr.mobile.view.pages.OverviewPage;
import splitr.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;

public class Splitr extends starling.display.Sprite {

    private var _appModel:AppModel;

    private var _header:Header;

    private var _footer:Footer;

    private var _overviewItem:OverviewItem;

    private var _pages:Array;

    public function Splitr()
    {
        new MetalWorksMobileTheme();

        this._appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

        _pages = new Array();

        var _overviewPage:OverviewPage = new OverviewPage();
        _overviewPage.x = _overviewPage.y = 0;
        addChild(_overviewPage);
        _pages.push(_overviewPage);

        var _equalBillsplit:EqualBillsplitPage = new EqualBillsplitPage();
        _equalBillsplit.x = _equalBillsplit.y = 0;
        addChild(_equalBillsplit);
        _pages.push(_equalBillsplit);

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function pageChangedHandler(e:flash.events.Event):void {
        trace("[Splitr]","Page changed:", _appModel.currentPage);
    }

    private function addedToStageHandler(e:starling.events.Event):void {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
        stage.addEventListener(starling.events.Event.RESIZE, resizedHandler);

        layout();
    }

    private function resizedHandler(e:starling.events.Event):void {
        layout();
    }

    private function layout():void {
        trace("[Starling] Resize:", stage.stageWidth, stage.stageHeight);

        // Header resize
        if(!_header){
            _header = new Header();
            addChild(_header);
        }
        _header.resizedHandler(stage.stageWidth, 50);

        // Resize/update all pages
        for(var i:uint = 0; i < _pages.length; i++){
            _pages[i].resizedHandler(stage.stageWidth, stage.stageHeight);
        }

        // Footer resize
        var buttonSize:uint = 60;
        var buttongap:uint = 10;
        if(!_footer){
            _footer = new Footer();
            addChild(_footer);
        }
        _footer.resizedHandler(buttonSize, buttongap);
        _footer.y = stage.stageHeight - (buttonSize + 10);
        _footer.x = stage.stageWidth/2 - _footer.width/2;

}
}
}
