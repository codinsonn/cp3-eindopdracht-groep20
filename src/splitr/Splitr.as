package splitr {

import feathers.themes.MetalWorksMobileTheme;

import splitr.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;

public class Splitr extends Sprite {

    private var _appModel:AppModel;

    public function Splitr()
    {
        trace("[Splitr] App initialising.");

        this._appModel = AppModel.getInstance();

    }

}
}
