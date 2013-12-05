package be.devine.cp3.queue {

import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLRequest;

public class Queue extends EventDispatcher {

    private var loader:Loader;
    private var itemsToLoad:Array;
    private var _done:Array;

    public function Queue() {
        itemsToLoad = new Array();
        _done = new Array();
    }

    public function add(item:ICanBeQueued):void
    {
        itemsToLoad.push(item);
    }

    public function start():void
    {
        loader = new Loader();

        if(itemsToLoad.length > 0)
        {
            var item:ICanBeQueued = itemsToLoad.shift();
            item.addEventListener(Event.COMPLETE, itemCompleteHandler);
            item.start();
        }else{
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function itemCompleteHandler(event:Event):void
    {
        _done.push(event.currentTarget);
        trace("Item load completed");
        start();
    }

    public function get done():Array {
        return _done;
    }
}
}
