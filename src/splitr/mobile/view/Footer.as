/**
 * Created with IntelliJ IDEA.
 * User: Panzerfaust
 * Date: 11/12/13
 * Time: 14:53
 * To change this template use File | Settings | File Templates.
 */
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

        _overview.label = "overzicht";
        _createNew.label= "nieuw";

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

    private function clickHandler(event:Event):void {
        trace("geklikt", event.currentTarget);

        if( event.currentTarget == _overview){
            AppModel.currentPage = "overview";
            _createNew.isSelected = false;
            _createNew.isEnabled = true;
            _overview.isEnabled = false;
            trace("current page = ", AppModel.currentPage);
        }
        if( event.currentTarget == _createNew){
            AppModel.currentPage = "createnew";
            _overview.isSelected = false;
            _createNew.isEnabled = false;
            _overview.isEnabled = true;
            trace("current page = ", AppModel.currentPage);
        }


    }
}
}
