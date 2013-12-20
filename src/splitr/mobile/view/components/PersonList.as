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

import flash.events.Event;

import splitr.model.AppModel;
import splitr.model.services.CalculatorService;
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

    private var _plus:Button;
    private var i:uint;
    private var _w:uint;
    private var _h:uint;
    private var calcService:CalculatorService;

    private var personsList:Array;

    private var _startDragX:Number;
    private var _startPanelX:Number;

    public function PersonList(w:uint,h:uint) {

        _appModel = AppModel.getInstance();
        calcService = CalculatorService.getInstance();
        calcService.addEventListener(CalculatorService.REFRESH_LIST, refreshHandler);
        personsList = new Array();
        _w = w;
        _h = h;

        _plus = new Button();
        _plus.width = 200;
        _plus.height = 50;
        _plus.label  = "+";
        _plus.x = w/2 - _plus.width/2;
        _plus.defaultIcon = new Image(Assets.getAtlas().getTexture("PersonIcon"));
        _plus.label = "add person";
        _plus.addEventListener(starling.events.Event.TRIGGERED, triggeredHandler);
        addChild(_plus);

        _listContainer = new ScrollContainer();
        _listContainer.width = _w;
        _listContainer.height = _h;
        _listContainer.y = (_plus.y + _plus.height) + 20;
        addChild(_listContainer);

        fillList();

    }

    private function refreshHandler(event:flash.events.Event):void {
        fillList();
    }

    private function fillList():void{
        i = 0;

        calcService.methodByPage();

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

                var personItem:PersonItem = new PersonItem(480, person.personName, calcService.shareList[i], i, _appModel.bills[_appModel.currentBill].billGroup[i].settledState);
            }else{
                var personItem:PersonItem = new PersonItem(480, person.personName, calcService.shareList[i], i,  _appModel.bills[_appModel.currentBill].billGroup[i].settledState);
                personItem.addEventListener(starling.events.Event.CHANGE, valueChangeHandler);
            }
            _listContainer.addChild(personItem);
            if(_appModel.currentPage == "PercentualSplit" && i != 0){
                personItem.y = (personItem.height + 5)*i;
            }else{
                personItem.y = (personItem.height)*i;
            }
            personItem.addEventListener(TouchEvent.TOUCH, touchHandler);
            personItem.addEventListener(PersonItem.DELETE_PERSON, removePersonHandler);
            personItem.addEventListener(PersonItem.SETTLE_PERSON, settlePersonHandler);
            personItem.addEventListener(PersonItem.NAME_CHANGED, nameChangedHandler);
            i++;
        }
    }

    private function settlePersonHandler(e:starling.events.Event):void {
        var person:PersonItem = e.currentTarget as PersonItem;
        _appModel.bills[_appModel.currentBill].billGroup[person.id].settledState = !_appModel.bills[_appModel.currentBill].billGroup[person.id].settledState;
        checkSettledStates();
        _appModel.save();
        _appModel.load();
        fillList();
    }

    private function checkSettledStates():void{
        var settledState:Boolean = true;
        for(var i:uint = 0; i < _appModel.bills[_appModel.currentBill].billGroup.length; i++){
            if(_appModel.bills[_appModel.currentBill].billGroup[i].settledState == false){
                settledState = false;
            }
        }
        _appModel.bills[_appModel.currentBill].settledState = settledState;
    }

    private function nameChangedHandler(e:starling.events.Event):void {
        trace("nameChangedHandler");
        var person:PersonItem = e.currentTarget as PersonItem;
        _appModel.bills[_appModel.currentBill].billGroup[person.id].personName = person.personNameField.text;
        _appModel.save();
        _appModel.load();
    }

    private function valueChangeHandler(e:starling.events.Event):void {
        var personItem:PersonItem = e.currentTarget as PersonItem;
        calcService.recalculateByPage(personItem.share, personItem.id);
        fillList();
    }

    private function removePersonHandler(e:starling.events.Event):void {
        var person:PersonItem = e.currentTarget as PersonItem;
            calcService.recalculateByPage(0, person.id);
            _appModel.bills[_appModel.currentBill].billGroup.splice(person.id, 1);
            _appModel.setIds();
            checkSettledStates();
            fillList();
    }

    private function triggeredHandler(e:starling.events.Event):void {
        var newPerson:PersonVO = new PersonVO();

        _appModel.bills[_appModel.currentBill].billGroup.push(newPerson);
        _appModel.save();
        checkSettledStates();
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
