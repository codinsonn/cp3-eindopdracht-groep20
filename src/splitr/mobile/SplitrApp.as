package splitr.mobile {

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
import feathers.themes.MinimalMobileTheme;

import flash.events.Event;

import splitr.mobile.view.pages.OverviewPage;
import splitr.mobile.view.pages.PhotoRefPage;
import splitr.mobile.view.pages.SplitPage;

import splitr.model.AppModel;

public class SplitrApp extends ScreenNavigator {

    private static const OVERVIEWPAGE:String = "overviewPage";
    private static const SPLITPAGE:String = "splitPage";
    private static const PHOTOREFPAGE:String = "photoRefPage";

    private var _appModel:AppModel;
    private var screenTransitionManager:ScreenSlidingStackTransitionManager;

    public function SplitrApp()
    {
        // Initialize the theme
        new MinimalMobileTheme();

        // Get (singleton) Appmodel instance
        this._appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

        // Add the overview panelscreen/homepage to our ScreenNavigator
        addScreen(OVERVIEWPAGE, new ScreenNavigatorItem(OverviewPage, {

        }));

        // Add the split panelscreen/page to our ScreenNavigator
        addScreen(SPLITPAGE, new ScreenNavigatorItem(SplitPage, {
            complete: OVERVIEWPAGE
        }));

        // Add the photo reference panelscreen/page to our ScreenNavigator
        addScreen(PHOTOREFPAGE, new ScreenNavigatorItem(PhotoRefPage, {
            complete: SPLITPAGE
        }));

        // Transition settings
        screenTransitionManager = new ScreenSlidingStackTransitionManager(this);
        screenTransitionManager.duration = .3;

        // Initialize the home (overview) screen via the appModel
        _appModel.currentPage = "Overview";

    }

    private function pageChangedHandler(e:flash.events.Event):void {
        trace("[Splitr]","Page changed:", _appModel.currentPage);

        switch (_appModel.currentPage){
            case "EqualSplit":
            case "PercentualSplit":
            case "AbsoluteSplit":
                this.showScreen(SPLITPAGE);
                break;
            case "PhotoReference":
                this.showScreen(PHOTOREFPAGE);
                break;
            case "Overview":
            default:
                this.showScreen(OVERVIEWPAGE);
                break;
        }
    }

}
}
