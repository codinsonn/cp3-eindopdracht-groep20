package splitr.mobile.view.pages {

import starling.display.Button;
import starling.display.Image;
import starling.text.TextField;

public class BillSplitPage extends Page {

    private var _billIcon:Image;
    private var _txtBillTitle:TextField;
    private var _txtBillTotal:TextField;
    private var _photoRefButton:Button;

    private var _billTotal:Number = 0.00;

    public function BillSplitPage(){

        _billIcon = new Image(Assets.getTexture("SplitrBillIcon"));
        _billIcon.x = 85;
        _billIcon.y = 50;
        addChild(_billIcon);

        _txtBillTitle = new TextField(180, 30, "0", "OpenSansBold", 24, 0x33423e);
        _txtBillTitle.fontName = "OpenSansBold";
        _txtBillTitle.text = "Add Title";
        _txtBillTitle.x = _billIcon.x + _billIcon.width + 10;
        _txtBillTitle.y = 60;
        addChild(_txtBillTitle);

        _txtBillTotal = new TextField(180, 30, "0", "OpenSansBold", 19, 0x33423e);
        _txtBillTotal.fontName = "OpenSansBold";
        _txtBillTotal.text = _billTotal.toString() + " EUR";
        _txtBillTotal.x = _txtBillTitle.x;
        _txtBillTotal.y = 80;
        addChild(_txtBillTitle);

        _photoRefButton = new Button(Assets.getTexture("SplitrPhotoRefButton"));
        _photoRefButton.x = this.width - _photoRefButton.width - 20;
        _photoRefButton.y = 115;
        addChild(_photoRefButton);

    }

}
}
