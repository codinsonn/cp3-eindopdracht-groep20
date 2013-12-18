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
import splitr.vo.PersonVO;

import starling.display.Sprite;
import starling.events.Event;

public class PersonList extends Sprite{

    private var _listContainer:ScrollContainer;
    private var _appModel:AppModel;
    private var _personItem:PersonItem;
    private var _plus:Button;
    private var i:uint;

    public function PersonList(w:uint,h:uint) {

        _appModel = AppModel.getInstance();

        _plus = new Button();
        _plus.width = 40;
        _plus.height = 40;
        _plus.label  = "+";
        _plus.addEventListener(Event.TRIGGERED, triggeredHandler);
        addChild(_plus);

        _listContainer = new ScrollContainer();
        _listContainer.width = w;
        _listContainer.height = h;
        _listContainer.y = (_plus.y + _plus.height) + 20;
        addChild(_listContainer);

        for each(var person:PersonVO in _appModel.bills[_appModel.currentBill].billGroup){
            i++;
            var personItem:PersonItem = new PersonItem(480, person.personName, person.personShare);
            _listContainer.addChild(personItem);
            personItem.y = personItem.height*i;
        }

    }

    private function triggeredHandler(event:Event):void {
        i++;
       _personItem = new PersonItem();
        _listContainer.addChild(_personItem);
        _personItem.y = _personItem.height*i;
    }
}
}
