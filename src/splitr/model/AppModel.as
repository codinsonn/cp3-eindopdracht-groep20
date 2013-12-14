package splitr.model {

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class AppModel extends EventDispatcher {

    /* ----- Public Variables ------------------------------------------------------------------------------------------ */

    public static const PEOPLE_CHANGED:String = "PEOPLE_CHANGED";
    public static const BILLS_CHANGED:String = "BILLS_CHANGED";

    public static const CURRENT_PERSON_CHANGED:String = "CURRENT_PERSON_CHANGED";
    public static const CURRENT_BILL_CHANGED:String = "CURRENT_BILL_CHANGED";

    public static const PAGE_CHANGED:String = "PAGE_CHANGED";

    private var _people:Array;
    private var _bills:Array;

    private var _currentBill:uint;
    private var _currentPerson:uint;

    private var _previousPage:String;
    private var _currentPage:String;

    private static var instance:AppModel;

    public static function getInstance():AppModel {
        if (instance == null) {
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    /* ----- AppModel Constructor + Functions -------------------------------------------------------------------------- */

    public function AppModel(e:Enforcer) {
        if (e == null) {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }
        _bills = [];
        _people = [];
    }

    /* ----- Getters / Setters ----------------------------------------------------------------------------------------- */

    public function get people():Array {
        return _people;
    }

    public function set people(value:Array):void {
        if(value != _people){
            _people = value;
        }
    }

    public function get bills():Array {
        return _bills;
    }

    public function set bills(value:Array):void {
        if(value != _bills){
            _bills = value;
        }
    }

    public function get currentBill():uint {
        return _currentBill;
    }

    public function set currentBill(value:uint):void {
        if(value != _currentBill){
            _currentBill = value;
        }
    }

    public function get currentPerson():uint {
        return _currentPerson;
    }

    public function set currentPerson(value:uint):void {
        if(value != _currentPerson){
            _currentPerson = value;
        }
    }

    public function pageSwitch():void{
        switch(_currentPage){
            case "Overview":
                trace("Overview");
                break;
            case "CreateNew":
                trace("CreateNew");
                break;
        }
    }

    public function get currentPage():String {
        return _currentPage;
    }

    public function set currentPage(value:String) {
        if(value != _currentPage){
            _previousPage = _currentPage;
            _currentPage = value;
            dispatchEvent(new Event("PAGE_CHANGED"));
        }
    }
}
}
internal class Enforcer{}