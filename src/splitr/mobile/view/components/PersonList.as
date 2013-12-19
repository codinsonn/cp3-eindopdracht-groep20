/**
 * Created with IntelliJ IDEA.
 * User: Panzerfaust
 * Date: 18/12/13
 * Time: 15:44
 * To change this template use File | Settings | File Templates.
 */
package splitr.mobile.view.components {
import feathers.controls.Button;
import feathers.controls.ScrollContainer;

import splitr.model.AppModel;
import splitr.model.services.calculatorService;
import splitr.vo.PersonVO;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class PersonList extends Sprite{

    private var _listContainer:ScrollContainer;
    private var _appModel:AppModel;
    private var _personItem:PersonItem;
    private var _plus:Button;
    private var i:uint;
    private var _w:uint;
    private var _h:uint;
    private var calcService:calculatorService;

    private var _startDragX:Number;
    private var _startPanelX:Number;

    public function PersonList(w:uint,h:uint) {

        _appModel = AppModel.getInstance();

        _w = w;
        _h = h;

        _plus = new Button();
        _plus.width = 200;
        _plus.height = 50;
        _plus.label  = "+";
        _plus.x = w/2 - _plus.width/2;
        _plus.defaultIcon = new Image(Assets.getAtlas().getTexture("PersonIcon"));
        _plus.label = "add new person";
        _plus.addEventListener(Event.TRIGGERED, triggeredHandler);
        _plus.addEventListener(Event.TRIGGERED, testHandler);
        addChild(_plus);

        _listContainer = new ScrollContainer();
        _listContainer.width = _w;
        _listContainer.height = _h;
        _listContainer.y = (_plus.y + _plus.height) + 20;
        addChild(_listContainer);

        fillList();

    }

    private function testHandler(event:Event):void {
        trace("TESTHANDLER");
    }

    private function fillList():void{
        calcService = new calculatorService();
        i = 0;
        if(_listContainer){
            removeChild(_listContainer);
        }
        _listContainer = new ScrollContainer();
        _listContainer.width = _w;
        _listContainer.height = _h;
        _listContainer.y = (_plus.y + _plus.height) + 20;

        addChild(_listContainer);

        for each(var person:PersonVO in _appModel.bills[_appModel.currentBill].billGroup){
            if(_appModel.currentPage == "EqualSplit"){
                _appModel.bills[_appModel.currentBill].billGroup[i].personId = i;

                var personItem:PersonItem = new PersonItem(480, person.personName, calcService.shareList[i], i);
            }else{
                var personItem:PersonItem = new PersonItem(480, person.personName, calcService.shareList[i], i);
            }
            _listContainer.addChild(personItem);
            if(_appModel.currentPage == "PercentualSplit" && i != 0){
                personItem.y = (personItem.height + 5)*i;
            }else{
                personItem.y = (personItem.height)*i;
            }
            personItem.addEventListener(TouchEvent.TOUCH, touchHandler);
            personItem.addEventListener(PersonItem.DELETE_PERSON, removePersonHandler);
            i++;
        }
    }

    private function removePersonHandler(e:starling.events.Event):void {
        var person:PersonItem = e.currentTarget as PersonItem;
            var person:PersonItem = e.currentTarget as PersonItem;
            _appModel.bills[_appModel.currentBill].billGroup.splice(person.id, 1);
            _appModel.setIds();
            fillList();
    }

    private function triggeredHandler(event:Event):void {
        var newPerson:PersonVO = new PersonVO();

        _appModel.bills[_appModel.currentBill].billGroup.push(newPerson);
        _appModel.save();
        fillList();
    }

    private function touchHandler(e:TouchEvent):void {
        var touchedObject:PersonItem = e.currentTarget as PersonItem;
        var elementsX:Number = new Number();
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase) {
                case TouchPhase.BEGAN:
                    _startDragX = touch.globalX;
                    _startPanelX = touchedObject.x;
                    break;
                case TouchPhase.MOVED:
                    var diffX:Number = touch.globalX - _startDragX;
                    elementsX = (_startPanelX + diffX)/4;
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
