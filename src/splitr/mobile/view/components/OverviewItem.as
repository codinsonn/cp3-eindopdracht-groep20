/**
 * Created with IntelliJ IDEA.
 * User: Panzerfaust
 * Date: 12/12/13
 * Time: 14:21
 * To change this template use File | Settings | File Templates.
 */
package splitr.mobile.view.components {
import feathers.controls.Slider;

import starling.events.Event;

import starling.display.Sprite;

public class OverviewItem extends Sprite {

    private var slider:Slider;

    public function OverviewItem() {
        var slider = new Slider();
        slider.minimum = 0;
        slider.maximum = 100;
        slider.value = 50;

        addChild(slider);
        slider.addEventListener(Event.TRIGGERED, triggeredHandler);

        slider.step = 1;
        slider.page = 10;
        slider.width = 100;
        slider.height = 50;

        resizedHandler();
    }

    public function resizedHandler():void {
        trace("resizkkje");

    }

    private function triggeredHandler(event:Event):void {
        trace("test");
    }
}
}
