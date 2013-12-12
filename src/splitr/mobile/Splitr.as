package splitr.mobile {

import feathers.themes.MetalWorksMobileTheme;

import splitr.mobile.view.Footer;
import splitr.mobile.view.Header;
import splitr.mobile.view.components.OverviewItem;
import splitr.mobile.view.pages.OverviewPage;
import splitr.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;

public class Splitr extends starling.display.Sprite {

    private var _appModel:AppModel;

    private var _header:Header;

    private var _footerNav:Footer;

    private var _overviewItem:OverviewItem;

    private var _pages:Array;

    public function Splitr()
    {
        new MetalWorksMobileTheme();

        this._appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

        _pages = new Array();

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function pageChangedHandler(e:Event):void {
        trace("[Splitr]","Page changed:", AppModel.currentPage);
    }

    private function addedToStageHandler(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        stage.addEventListener(Event.RESIZE, resizedHandler);

        var _overviewPage:OverviewPage = new OverviewPage();
        _overviewPage.x = _overviewPage.y = 0;
        addChild(_overviewPage);
        _pages.push(_overviewPage);
        trace(_pages.length);

        layout();
    }

    private function resizedHandler(e:Event):void {
        layout();
    }

    private function layout():void {
        trace("[Starling] Resize:", stage.stageWidth, stage.stageHeight);

        // Resize all pages
        for(var i:uint = 0; i < _pages.length; i++){
            trace("Resizing page:", i);
            _pages[i].setPageSize(stage.stageWidth, stage.stageHeight);
        }

        // Header resize
        if(!_header){
            _header = new Header();
            addChild(_header);
        }
        _header.resizedHandler(stage.stageWidth, 50);

        // FooterNav
        var buttonSize:uint = 60;
        var buttongap:uint = 10;

        if(!_footerNav){
            _footerNav = new Footer();
            addChild(_footerNav);
        }
        _footerNav.resizedHandler(buttonSize, buttongap);
        _footerNav.y = stage.stageHeight - (buttonSize + 10);
        _footerNav.x = stage.stageWidth/2 - _footerNav.width/2;

        // Overviewtijdelijk
        _overviewItem = new OverviewItem();
        if(!_overviewItem){
            _overviewItem = new OverviewItem();
            addChild(_overviewItem);
        }
        _overviewItem.resizedHandler();
        _overviewItem.x = stage.stageWidth/2;
        _overviewItem.y = 100;
}
}
}
