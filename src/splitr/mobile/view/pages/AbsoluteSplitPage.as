package splitr.mobile.view.pages {

import splitr.model.AppModel;

public class AbsoluteSplitPage extends SplitPage {

    private var _appModel:AppModel;

    public function AbsoluteSplitPage() {

        _appModel = AppModel.getInstance();

        this.headerProperties.title = "SPLIT ABSOLUTE";



    }
}
}
