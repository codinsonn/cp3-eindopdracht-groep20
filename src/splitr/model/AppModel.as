package splitr.model {

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import splitr.vo.BillVO;
import splitr.vo.PersonVO;

public class AppModel extends EventDispatcher {

    /* ----- Public Variables ------------------------------------------------------------------------------------------ */

    public static const PEOPLE_CHANGED:String = "PEOPLE_CHANGED";
    public static const BILLS_CHANGED:String = "BILLS_CHANGED";

    public static const CURRENT_BILL_TOTAL_CHANGED:String = "CURRENT_BILL_TOTAL_CHANGED";
    public static const CURRENT_BILL_PEOPLE_CHANGED:String = "CURRENT_BILL_PEOPLE_CHANGED";

    public static const PAGE_CHANGED:String = "PAGE_CHANGED";

    private var _createNewPage:Boolean = false;

    private var _bills:Vector.<BillVO>;

    private var _currentBill:uint;
    private var _currentPerson:uint;

    private var _previousPage:String;
    private var _currentPage:String;

    private var _jsonFile:File;
    private var _jsonStream:FileStream;

    private static var instance:AppModel;

    public static function getInstance():AppModel {
        if (instance == null) {
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    /* ----- AppModel Constructor -------------------------------------------------------------------------------------- */

    public function AppModel(e:Enforcer) {
        if (e == null) {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        _bills = new Vector.<BillVO>();

        _jsonFile = File.applicationStorageDirectory.resolvePath("bills.json");
        _jsonStream = new FileStream();
    }

    /* ----- Bills / Data ---------------------------------------------------------------------------------------------- */

    public function load():void{
        var bills:Vector.<BillVO> = new Vector.<BillVO>();

        if(_jsonFile.exists == false){
            trace("[AppModel]", "bills.json nonexistant");
            save();
        }

        _jsonStream.open(_jsonFile, FileMode.READ);
        var jsonString:String = _jsonStream.readMultiByte(_jsonStream.bytesAvailable, "utf-8");
        trace("[JSON]: ",jsonString);
        _jsonStream.close();

        var billsCollection:Object = JSON.parse(jsonString);
        for each(var bill:Object in billsCollection){
            var billVO:BillVO = new BillVO();
            billVO.billId = bill.billId;
            billVO.billType = bill.billType;
            billVO.billTitle = bill.billTitle;
            billVO.billTotal = bill.billTotal;
            for each(var person:Object in bill.billGroup){
                var personVO:PersonVO = new PersonVO();
                personVO.personName = person.personName;
                personVO.personShare = person.personShare;
                billVO.billGroup.push(personVO);
            }
            billVO.photoReference = bill.photoReference;
            billVO.settledState = bill.settledState;
            bills.push(billVO);
        }

        this.bills = bills;
    }

    public function setIds():void{
        for(var i:uint = 0; i < _bills.length; i++){
            _bills[i].billId = i;
        }
        save();
    }

    public function save():void {
        trace("[AppModel]", "Saving json file.", JSON.stringify(_bills, null, 4));
        _jsonStream.open(_jsonFile, FileMode.WRITE);

        _jsonStream.writeUTFBytes(JSON.stringify(_bills, null, 4));

        _jsonStream.close();
    }

    /* ----- Getters / Setters ----------------------------------------------------------------------------------------- */

    public function get bills():Vector.<BillVO> {
        return _bills;
    }

    public function set bills(value:Vector.<BillVO>):void {
        if(value != _bills){
            _bills = value;
            dispatchEvent(new Event("BILLS_CHANGED"));
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

    public function get previousPage():String {
        return _previousPage;
    }

    public function get createNewPage():Boolean {
        return _createNewPage;
    }

    public function set createNewPage(value:Boolean):void {
        if(value != _createNewPage){
            _createNewPage = value;
        }
    }
}
}
internal class Enforcer{}