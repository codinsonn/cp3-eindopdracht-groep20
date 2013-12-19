package splitr.mobile.view.pages {

import com.adobe.images.JPGEncoder;

import feathers.controls.Button;

import feathers.controls.PanelScreen;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import splitr.model.AppModel;

import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Image;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.camera.StarlingCamera;
import starling.textures.Texture;

public class PhotoRefPage extends PanelScreen {

    private var _appModel:AppModel;
    private var _headerBackButton:starling.display.Button;

    private var _camView:StarlingCamera;
    private var _stageRect:Rectangle;
    private var _takePhoto:starling.display.Button;

    private var _photoRef:Image;
    private var _takeNewPhoto:feathers.controls.Button;
    private var _fileStream:FileStream;

    public function PhotoRefPage() {

        _appModel = AppModel.getInstance();

        this.headerProperties.title = "ADD PHOTO REFERENCE";

        _headerBackButton = new starling.display.Button(Assets.getAtlas().getTexture("HeaderPrevButton"));
        _headerBackButton.addEventListener(starling.events.Event.TRIGGERED, backButtonTriggeredHandler);
        headerProperties.leftItems = new <DisplayObject>[_headerBackButton];

        _stageRect = new Rectangle(0, 0, 480, ((480 * 16) / 9) * 0.6);
        _fileStream = new FileStream();

        checkPhotoReference();

    }

    private function checkPhotoReference():void{
        if(_camView){
            _camView.shutdown();
            removeChild(_camView);
            removeChild(_takePhoto);
        }

        if(_photoRef){
            removeChild(_photoRef);
            removeChild(_takeNewPhoto);
        }

        if(_appModel.bills[_appModel.currentBill].photoReference == "null"){
            initCam();
        }else{
            initPhotoRef();
        }
    }

    private function initPhotoRef():void {
        var photoRefFile:File = File.applicationStorageDirectory.resolvePath("imgRef/" + _appModel.bills[_appModel.currentBill].photoReference);
        var photoRefByteArray:ByteArray = new ByteArray();

        if(photoRefFile.exists){
            _fileStream.open(photoRefFile, FileMode.READ);
            _fileStream.readBytes(photoRefByteArray);
            _fileStream.close();

            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, loadCompleteHandler)
            loader.loadBytes(photoRefByteArray);
        }else{
            takeNewPhotoHandler();
        }
    }

    private function loadCompleteHandler(e:flash.events.Event):void {
        var loaderInfo:LoaderInfo = LoaderInfo(e.currentTarget);
        var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, false, 0xFFFFFF);
        bitmapData.draw(loaderInfo.loader);

        _photoRef = new Image(Texture.fromBitmapData(bitmapData));
        _photoRef.y = 116;
        addChild(_photoRef);

        _takeNewPhoto = new feathers.controls.Button();
        _takeNewPhoto.defaultIcon = new Image(Assets.getAtlas().getTexture("DeleteIcon"));
        _takeNewPhoto.label = "Take other photo.";
        _takeNewPhoto.width = 200;
        _takeNewPhoto.x = 240 - _takeNewPhoto.width/2;
        _takeNewPhoto.y = 20;
        _takeNewPhoto.addEventListener(starling.events.Event.TRIGGERED, takeNewPhotoHandler);
        addChild(_takeNewPhoto);
    }

    private function takeNewPhotoHandler(e:starling.events.Event = null):void {
        var prevPhotoRef:File = File.applicationStorageDirectory.resolvePath("imgRef/" + _appModel.bills[_appModel.currentBill].photoReference);

        if(prevPhotoRef.exists){
            prevPhotoRef.deleteFile();
        }

        _appModel.bills[_appModel.currentBill].photoReference = "null";
        checkPhotoReference();
    }

    private function initCam():void{
        _camView = new StarlingCamera();
        _camView.init(_stageRect, 18, .7, false);
        _camView.reflect();
        _camView.y = 116;
        addChild(_camView);
        _camView.selectCamera(0);

        _takePhoto = new starling.display.Button(Assets.getAtlas().getTexture("PhotoButton"));
        _takePhoto.x = _camView.x + _camView.width/2 - _takePhoto.width/2;
        _takePhoto.y = _camView.y + _camView.height/2 - _takePhoto.height/2;
        _takePhoto.alpha = .16;
        _takePhoto.addEventListener(TouchEvent.TOUCH, photoButtonTouchedHandler);
        addChild(_takePhoto);
    }

    private function photoButtonTouchedHandler(e:TouchEvent):void {
        var touchedObject:starling.display.Button = e.currentTarget as starling.display.Button;
        var touch:Touch = e.getTouch(touchedObject);
        if(touch != null) {
            switch(touch.phase) {
                case TouchPhase.BEGAN:
                    _takePhoto.alpha = .85;
                    break;
                case TouchPhase.ENDED:
                    _takePhoto.alpha = .16;

                    var encoder:JPGEncoder = new JPGEncoder();
                    var jpgBytes:ByteArray = encoder.encode(_camView.getImage());

                    var imageDirectory:File = File.applicationStorageDirectory.resolvePath("imgRef");
                    if(imageDirectory.exists == false){
                        imageDirectory.createDirectory();
                    }

                    var photoRefPath:String = "billRef_"+_appModel.bills[_appModel.currentBill].billId+"_"+new Date().valueOf().toString() + ".jpg";
                    var photoRef:File = File.applicationStorageDirectory.resolvePath("imgRef/" + photoRefPath);

                    _fileStream.open(photoRef, FileMode.WRITE);
                    _fileStream.writeBytes(jpgBytes);
                    _fileStream.close();

                    _appModel.bills[_appModel.currentBill].photoReference = photoRefPath;
                    _appModel.save();
                    _appModel.load();

                    _camView.shutdown();
                    checkPhotoReference();

                    break;
            }
        }
    }

    private function backButtonTriggeredHandler(e:starling.events.Event):void {
        _appModel.currentPage = _appModel.previousPage;
    }

}
}
