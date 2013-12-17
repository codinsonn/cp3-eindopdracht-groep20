package splitr.mobile {

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
import feathers.themes.MinimalMobileTheme;

import flash.events.Event;

import splitr.mobile.view.pages.AbsoluteSplitPage;
import splitr.mobile.view.pages.EqualSplitPage;
import splitr.mobile.view.pages.OverviewPage;
import splitr.mobile.view.pages.PercentualSplitPage;
import splitr.mobile.view.pages.PhotoRefPage;

import splitr.model.AppModel;

public class Splitr extends ScreenNavigator {

    private static const OVERVIEWPAGE:String = "overviewPage";
    private static const EQUALSPLITPAGE:String = "equalSplitPage";
    private static const PERCENTUALSPLITPAGE:String = "percentualSplitPage";
    private static const ABSOLUTESPLITPAGE:String = "absoluteSplitPage";
    private static const PHOTOREFPAGE:String = "photoRefPage";

    private var _appModel:AppModel;
    private var screenTransitionManager:ScreenSlidingStackTransitionManager;

    public function Splitr()
    {
        // Initialize the theme
        new MinimalMobileTheme();

        // Get (singleton) Appmodel instance
        this._appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.PAGE_CHANGED, pageChangedHandler);

        // Add the overview panelscreen/homepage to our ScreenNavigator
        addScreen(OVERVIEWPAGE, new ScreenNavigatorItem(OverviewPage, {
            equalSplitPage: newEqualSplitPageHandler,
            percentualSplitPage: newPercentualSplitPage,
            absoluteSplitPage: newAbsoluteSplitPage
        }));

        // Add the equal split panelscreen/page to our ScreenNavigator
        addScreen(EQUALSPLITPAGE, new ScreenNavigatorItem(EqualSplitPage, {
            complete: OVERVIEWPAGE
        }));

        // Add the percentual split panelscreen/page to our ScreenNavigator
        addScreen(PERCENTUALSPLITPAGE, new ScreenNavigatorItem(PercentualSplitPage, {
            complete: OVERVIEWPAGE
        }));

        // Add the absolute split panelscreen/page to our ScreenNavigator
        addScreen(ABSOLUTESPLITPAGE, new ScreenNavigatorItem(AbsoluteSplitPage, {
            complete: OVERVIEWPAGE
        }));

        // Add the photo reference panelscreen/page to our ScreenNavigator
        addScreen(PHOTOREFPAGE, new ScreenNavigatorItem(PhotoRefPage, {
            // Not sure what to put here
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
                this.showScreen(EQUALSPLITPAGE);
                break;
            case "PercentualSplit":
                this.showScreen(PERCENTUALSPLITPAGE);
                break;
            case "AbsoluteSplit":
                this.showScreen(ABSOLUTESPLITPAGE);
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

    private function newEqualSplitPageHandler():void {
        this.showScreen(EQUALSPLITPAGE);
    }

    private function newPercentualSplitPage():void {
        this.showScreen(PERCENTUALSPLITPAGE);
    }

    private function newAbsoluteSplitPage():void {
        this.showScreen(ABSOLUTESPLITPAGE);
    }

}
}
