package splitr.mobile.view {

import feathers.controls.Button;

import splitr.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;

public class Footer extends Sprite {

    private var _appModel:AppModel;

    private var _footerButtons:Array;

    //BUTTONS

    private var _overview:Button;
    private var _createNew:Button;

    public function Footer()
    {

        this._appModel = AppModel.getInstance();

        _footerButtons = new Array();
        _overview = new Button();
        _createNew = new Button();

        _overview.label = "Overview";
        _createNew.label= "New Bill";

        //_overview.defaultIcon = new Image( ICOONMAKEN );
        //_overview.iconPosition = Button.HORIZONTAL_ALIGN_CENTER;

        _overview.isSelected = true;
        _overview.isEnabled = false;

        _footerButtons.push(_overview);
        _footerButtons.push(_createNew);

        resizedHandler();
    }

    public function resizedHandler(w:uint = 50, gap:uint = 10):void {
         var xPos:uint = 0;
        for each (var button in _footerButtons){
            addChild(button);
            button.x = xPos;
            button.width = w;
            button.height = w;
            button.isToggle = true;
            xPos += w+gap;

            _overview.addEventListener( Event.TRIGGERED, clickHandler );
            _createNew.addEventListener( Event.TRIGGERED, clickHandler );
        }
    }

    private function clickHandler(e:Event):void {

        if( e.currentTarget == _overview){
            _appModel.currentPage = "Overview";
            _createNew.isSelected = false;
            _createNew.isEnabled = true;
            _overview.isEnabled = false;
            trace("current page = ", _appModel.currentPage);
        }
        if( e.currentTarget == _createNew){
            _appModel.currentPage = "CreateNew";
            _overview.isSelected = false;
            _createNew.isEnabled = false;
            _overview.isEnabled = true;
            trace("current page = ", _appModel.currentPage);
        }

    }
}
}
