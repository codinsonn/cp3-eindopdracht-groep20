package splitr.model {

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class AppModel extends EventDispatcher {

    /* ----- Public Variables ------------------------------------------------------------------------------------------ */

    public static const PEOPLE_CHANGED:String = "PEOPLE_CHANGED";
    public static const BILLS_CHANGED:String = "BILLS_CHANGED";

    public static const CURRENT_PERSON_CHANGED:String = "CURRENT_PERSON_CHANGED";
    public static const CURRENT_BILL_CHANGED:String = "CURRENT_BILL_CHANGED";

    public static const PAGE_CHANGED:String = "PAGE_CHANGED";

    private static var _people:Array;
    private static var _bills:Array;

    private static var _currentBill:uint;
    private static var _currentPerson:uint;

    private static var _currentPage:String;

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

    public static function get people():Array {
        return _people;
    }

    public static function set people(value:Array):void {
        if(value != _people){
            _people = value;
        }
    }

    public static function get bills():Array {
        return _bills;
    }

    public static function set bills(value:Array):void {
        if(value != _bills){
            _bills = value;
        }
    }

    public static function get currentBill():uint {
        return _currentBill;
    }

    public static function set currentBill(value:uint):void {
        if(value != _currentBill){
            _currentBill = value;
        }
    }

    public static function get currentPerson():uint {
        return _currentPerson;
    }

    public static function set currentPerson(value:uint):void {
        if(value != _currentPerson){
            _currentPerson = value;
        }
    }

    public static function get currentPage():String {
        return _currentPage;
    }

    public static function set currentPage(value:String):void {
        if(value != _currentPage){
            _currentPage = value;
        }
    }
}
}
internal class Enforcer{}