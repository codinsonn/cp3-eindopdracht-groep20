package {
import flash.display.Bitmap;
import flash.utils.Dictionary;

import starling.textures.Texture;

public class Assets {

    /* ---- Header icons/buttons ------------------------------------- */
    [Embed(source="assets/graphics/SplitrHeaderBackButton.png")]
    public static const SplitrHeaderBackButton:Class;

    /* ---- Content/Bill icons/buttons ------------------------------------- */
    [Embed(source="assets/graphics/SplitrItemIcon.png")]
    public static const SplitrItemIcon:Class;

    [Embed(source="assets/graphics/SplitrItemIconSelected.png")]
    public static const SplitrItemIconSelected:Class;

    [Embed(source="assets/graphics/SplitrPeopleIcon.png")]
    public static const SplitrPeopleIcon:Class;

    [Embed(source="assets/graphics/SplitrPeopleIconSelected.png")]
    public static const SplitrPeopleIconSelected:Class;

    [Embed(source="assets/graphics/SplitrBillIcon.png")]
    public static const SplitrBillIcon:Class;

    [Embed(source="assets/graphics/SplitrPhotoRefButton.png")]
    public static const SplitrPhotoRefButton:Class;

    [Embed(source="assets/graphics/SplitrAddButton.png")]
    public static const SplitrAddButton:Class;

    [Embed(source="assets/graphics/SplitrInputBoxBg.png")]
    public static const SplitrInputBoxBg:Class;

    [Embed(source="assets/graphics/SplitrSubtractButton.png")]
    public static const SplitrSubtractButton:Class;

    [Embed(source="assets/graphics/SplitrNumTogglerSubtractButton.png")]
    public static const SplitrNumTogglerSubtractButton:Class;

    [Embed(source="assets/graphics/SplitrNumTogglerAddButton.png")]
    public static const SplitrNumTogglerAddButton:Class;

    // Dictionary to check/pass textures
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
