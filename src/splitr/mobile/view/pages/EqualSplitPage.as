package splitr.mobile.view.pages {

import splitr.model.AppModel;

public class EqualSplitPage extends SplitPage {

    private var _appModel:AppModel;

    public function EqualSplitPage() {

        _appModel = AppModel.getInstance();
        _appModel.bills[_appModel.currentBill].billType = "Equal";

        this.headerProperties.title = "SPLIT EQUAL";

        

    }

}
}
