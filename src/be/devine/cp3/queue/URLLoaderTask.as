package be.devine.cp3.queue {

import flash.net.URLLoader;
import flash.net.URLRequest;

public class URLLoaderTask extends URLLoader implements ICanBeQueued
{
    private var _url:String;

    public function URLLoaderTask(url:String)
    {
        this._url = url;
    }

    public function start():void
    {
        this.load(new URLRequest(_url));
    }

}
}
