/**
 * Created with IntelliJ IDEA.
 * User: Panzerfaust
 * Date: 19/12/13
 * Time: 13:44
 * To change this template use File | Settings | File Templates.
 */
package splitr.model.services {
import flash.events.EventDispatcher;

import splitr.model.AppModel;

public class calculatorService extends EventDispatcher{
    private var _appModel:AppModel;
    private var _shareList:Array;
    public function calculatorService() {
        trace("CALCSERVICE");
        _appModel = AppModel.getInstance();
        methodByPage();
    }

    private function methodByPage():void {
        switch(_appModel.currentPage) {
            case "EqualSplit":
                    equalSplit();
                break;
            case "PercentualSplit":
                    percentualSplit();
                break;
            case "AbsoluteSplit":
                    absoluteSplit();
                break;
        }
    }

    private function equalSplit():void {
        _shareList = new Array();
        var share:uint = (_appModel.bills[_appModel.currentBill].billTotal / _appModel.bills[_appModel.currentBill].billGroup.length);
        var i:Number = 0;
        while (i < _appModel.bills[_appModel.currentBill].billGroup.length){
            _shareList.push(share);
            i++;
        }
    }

    private function percentualSplit():void {
        _shareList = new Array();
        var i:Number = 0;
        while (i < _appModel.bills[_appModel.currentBill].billGroup.length){
            var share:uint =
            _shareList.push(_appModel.bills[_appModel.currentBill].billGroup[i].personShare);
            i++;
        }
    }

    private function absoluteSplit():void {
        trace("HIER IN?");
        _shareList = new Array();
        var i:Number = 0;
        while (i < _appModel.bills[_appModel.currentBill].billGroup.length){
            _shareList.push(_appModel.bills[_appModel.currentBill].billGroup[i].personShare);
            i++;
        }
    }

    public function get shareList():Array {
        return _shareList;
    }
}
}
