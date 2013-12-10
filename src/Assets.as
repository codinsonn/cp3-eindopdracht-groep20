package {
import flash.display.Bitmap;
import flash.utils.Dictionary;

import starling.textures.Texture;

public class Assets {

    [Embed(source="assets/graphics/SplitrHeaderBackButton.png")]
    public static const SplitrHeaderBackButton:Class;

    [Embed(source="assets/graphics/SplitrItemIcon.png")]
    public static const SplitrItemIcon:Class;

    [Embed(source="assets/graphics/SplitrItemIconSelected.png")]
    public static const SplitrItemIconSelected:Class;

    private static var splitrTextures:Dictionary = new Dictionary();

    public static function getTexture(name:String):Texture
    {
        // Create new empty texture if texture does not exist
        if(splitrTextures[name] == undefined){
            var bitmap:Bitmap = new Assets[name]();
            splitrTextures[name] = Texture.fromBitmap(bitmap);
        }

        // Use the splitrTextures dictionary to check whether a variable with this name exists and return it
        return splitrTextures[name];
    }

}
}
