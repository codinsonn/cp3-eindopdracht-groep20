package {
import feathers.controls.TextInput;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.utils.Dictionary;

import starling.text.BitmapFont;
import starling.text.TextField;

import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

public class Assets {

    /* ---- Font embedding ------------------------------------- */
    [Embed(source = "/../assets/fonts/OpenSansBold.fnt", mimeType="application/octet-stream")]
    public static const OpenSansBoldXml:Class;

    [Embed(source = "/../assets/fonts/OpenSansBold.png")]
    public static const OpenSansBoldTexture:Class;

    // Dictionary & Atlas to check/pass textures
    private static var splitrTextures:Dictionary = new Dictionary();
    private static var splitrTextureAtlas:TextureAtlas;

    // Spritesheet embedding
    [Embed(source="/../assets/custom/SplitrSpritesheet.png")]
    public static const SplitrSpritesheet:Class;

    [Embed(source="/../assets/custom/SplitrSpritesheet.xml", mimeType="application/octet-stream")]
    public static const SplitrSpritesheetXML:Class;

    public function Assets(){
        var texture:Texture = Texture.fromBitmap(new OpenSansBoldTexture());
        var xml:XML = XML(new OpenSansBoldXml());
        TextField.registerBitmapFont(new BitmapFont(texture, xml));
    }

    public static function getAtlas():TextureAtlas
    {
        // Create new TextureAtlas if it does not yet exist
        if(splitrTextureAtlas == null){
            var texture:Texture = getTexture("SplitrSpritesheet");
            var xml:XML = XML(new SplitrSpritesheetXML());

            splitrTextureAtlas = new TextureAtlas(texture, xml);
        }

        // Return the TextureAtlas
        return splitrTextureAtlas;
    }

    public static function getTexture(name:String):Texture
    {
        // Create new empty texture if texture does not exist
        if(splitrTextures[name] == undefined){
            var bitmap:Bitmap = new Assets[name]();
            splitrTextures[name] = Texture.fromBitmap(bitmap);
            trace(splitrTextures[name]);
        }

        // Use the splitrTextures dictionary to check whether a variable with this name exists and return it
        return splitrTextures[name];
    }

    public static function createTextureFromRectShape(w:uint = 480, h:uint = 50, color:uint = 0xf3f3f3):Texture{
        var shape:Shape = new Shape();
        shape.graphics.beginFill(color);
        shape.graphics.drawRect(0, 0, w, 50);
        shape.graphics.endFill();
        var shapeData:BitmapData = new BitmapData(w, 50, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        return texture;
    }

}
}
