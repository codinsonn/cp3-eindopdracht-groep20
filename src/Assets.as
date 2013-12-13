package {
import flash.display.Bitmap;
import flash.utils.Dictionary;

import starling.text.BitmapFont;
import starling.text.TextField;

import starling.textures.Texture;
import starling.textures.TextureAtlas;

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

}
}
