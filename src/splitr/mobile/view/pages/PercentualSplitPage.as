package splitr.mobile.view.pages {

import splitr.model.AppModel;

public class PercentualSplitPage extends SplitPage {

    private var _appModel:AppModel;

    public function PercentualSplitPage() {

        _appModel = AppModel.getInstance();

        this.headerProperties.title = "SPLIT PERCENTUAL";



    }

}
}
