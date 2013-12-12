package splitr.mobile {

import feathers.themes.MetalWorksMobileTheme;

import splitr.mobile.view.AmountAdder;
import splitr.mobile.view.FooterNav;

import splitr.mobile.view.Header;
import splitr.mobile.view.AmountToggler;

import splitr.model.AppModel;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.BitmapFont;
import starling.text.TextField;
import starling.textures.Texture;

public class Splitr extends starling.display.Sprite {

    private var _appModel:AppModel;

    private var _header:Header;
    private var _footerNav:FooterNav;

    public function Splitr()
    {
        new MetalWorksMobileTheme();

        this._appModel = AppModel.getInstance();

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        stage.addEventListener(Event.RESIZE, resizedHandler);
        layout();
    }

    private function resizedHandler(e:Event):void {
        layout();
    }

    private function layout():void {
        trace("[Starling] Resize:", stage.stageWidth, stage.stageHeight);

        // Header resize
        if(!_header){
            _header = new Header();
            addChild(_header);
        }
        _header.resizedHandler(stage.stageWidth, 50);

        // FooterNav
        var buttonSize:uint = 60;
        var buttongap:uint = 10;

        if(!_footerNav){
            _footerNav = new FooterNav();
            addChild(_footerNav);
        }
        _footerNav.resizedHandler(buttonSize, buttongap);
        _footerNav.y = stage.stageHeight - (buttonSize + 10);
        _footerNav.x = stage.stageWidth/2 - _footerNav.width/2;


        // Amount Adder test
        var _amountAdder:AmountAdder = new AmountAdder();
        _amountAdder.x = stage.stageWidth / 2 - _amountAdder.width / 2;
        _amountAdder.y = stage.stageHeight /2 - _amountAdder.height / 2;
        _amountAdder.addEventListener(AmountAdder.ADD_AMOUNT, addAmountHandler);
        _amountAdder.addEventListener(AmountAdder.SUBTRACT_AMOUNT, subtractAmountHandler);
        addChild(_amountAdder);
    }

    private function subtractAmountHandler(e:Event):void {
        var target:AmountAdder = e.currentTarget as AmountAdder;
        trace("Amount subtracted:", target.amount);
    }

    private function addAmountHandler(e:Event):void {
        var target:AmountAdder = e.currentTarget as AmountAdder;
        trace("Amount added:", target.amount);
    }

}
}
