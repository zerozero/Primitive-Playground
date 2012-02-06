package com.jonrowe.away3d.services
{
	import com.jonrowe.away3d.productFactory.PrimitiveInit;

	public interface ISocketService
	{
		function connect():void;
		function handshake(id:int):void;
		function createObject(init:PrimitiveInit):void;
		function toJSON( obj :Object ):String;
		function fromJSON( str :String):Object;
		function handleResult(obj:Object):void;
	}
}