package splitr.mobile.view.pages {

import starling.display.Image;
import starling.text.TextField;

public class BillSplitPage extends Page {

    private var _BillIcon:Image;
    private var _txtBillTitle:TextField;

    public function BillSplitPage(){

        _BillIcon = new Image(Assets.getTexture("SplitrBillIcon"));
        _BillIcon.x = 85;
        _BillIcon.y = 50;
        addChild(_BillIcon);

        _txtBillTitle = new TextField(180, 30, "0", "OpenSansBold", 24, 0x33423e);
        _txtBillTitle.fontName = "OpenSansBold";
        _txtBillTitle.text = "Add Title";
        _txtBillTitle.x = _BillIcon.x + _BillIcon.width + 10;
        _txtBillTitle.y = 60;
        addChild(_txtBillTitle);



    }

}
}
