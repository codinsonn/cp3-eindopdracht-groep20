package be.devine.cp3.queue {

import flash.events.IEventDispatcher;

public interface ICanBeQueued extends IEventDispatcher
    {
        function start():void;
    }
}
