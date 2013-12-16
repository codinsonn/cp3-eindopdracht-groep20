package splitr.mobile.view.pages {

import feathers.controls.PanelScreen;

import splitr.model.AppModel;

import starling.display.Button;

import starling.display.DisplayObject;
import starling.events.Event;

public class PhotoRefPage extends PanelScreen {

    private var _appModel:AppModel;
    private var _headerBackButton:Button;

    public function PhotoRefPage() {

        _appModel = AppModel.getInstance();

        this.headerProperties.title = "ADD PHOTO REFERENCE";

        _headerBackButton = new Button(Assets.getAtlas().getTexture("HeaderPrevButton"));
        _headerBackButton.addEventListener(Event.TRIGGERED, backButtonTriggeredHandler);
        headerProperties.leftItems = new <DisplayObject>[_headerBackButton];

    }

    private function backButtonTriggeredHandler(e:Event):void {
        _appModel.currentPage = _appModel.previousPage;
    }

}
}
