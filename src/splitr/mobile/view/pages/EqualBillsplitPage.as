package splitr.mobile.view.pages {

import splitr.model.AppModel;

import starling.events.ResizeEvent;

public class EqualBillsplitPage extends BillSplitPage {

    private var _appModel:AppModel;

    public function EqualBillsplitPage() {

        this._appModel = AppModel.getInstance();
        _appModel.currentPage = "EqualBillsplit";



    }

    public function resizedHandler(w:uint = 480, h:uint = 800):void{

        this.headerResizedHandler(w, h);

    }

}
}
