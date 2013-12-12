package splitr.mobile.view.pages {

import splitr.model.AppModel;

public class OverviewPage extends Page {

    private var _appModel:AppModel;

    public function OverviewPage() {
        _appModel = AppModel.getInstance();
        _appModel.currentPage = "Overview";

    }

    public function resizedHandler(w:uint = 480, h:uint = 800):void{

        this.setPageSize(w, h);

    }

}
}
