package splitr.mobile.view.pages {

import flash.display.BitmapData;
import flash.display.Shape;

import splitr.model.AppModel;

import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

public class Page extends Sprite {

    private var _pageBg:Image;

    public function Page() {

    }

    public function setPageSize(w:uint = 480, h:uint = 800){
        var shape:Shape = new Shape();
        shape.graphics.beginFill(0xFFFFFF);
        shape.graphics.drawRect(0, 0, w, h);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(w, h, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        _pageBg = new Image(texture);
        _pageBg.x = _pageBg.y = 0;
        addChild(_pageBg);
    }

}
}
