package be.devine.cp3.queue {

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.net.NetConnection;
import flash.net.Responder;

public class AMFTask extends EventDispatcher implements ICanBeQueued
{
    private var _gateWayURL:String;
    private var _command:String;
    private var _args:Array;

    public var result:Object;

    public function AMFTask(gateWayURL:String, command:String, args:Array) {
        this._gateWayURL = gateWayURL;
        this._command = command;
        this._args = args;
    }

    public function start():void
    {
        var netConnection:NetConnection = new NetConnection();
        netConnection.connect(_gateWayURL);

        var responder:Responder = new Responder(resultHandler, errorHandler);
        var arguments:Array = [_command, responder];
        arguments = arguments.concat(_args); //Zet de args uit constructor achteraan in array
        netConnection.call.apply(this, arguments);

        /* --------------
         trace("test", "een", "twee");

         var argumenten:Array = [];
         argumenten.push("test");
         argumenten.push("een");
         argumenten.push("twee");
         trace.apply(argumenten.length, argumenten);
         -------------- */
    }

    private function resultHandler(result:Array):void
    {
        trace("[AMF Task]", result, "[/AMF Task]")
        this.result = result;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function errorHandler(error:Object):void
    {
        trace(error);
    }

}
}
