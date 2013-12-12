package splitr.mobile.view.pages {

import splitr.model.AppModel;

public class OverviewPage extends Page {

    private var _appModel:AppModel;

    public function OverviewPage() {
        this._appModel = AppModel.getInstance();
        _appModel.currentPage = "overview";


    }
}
}
