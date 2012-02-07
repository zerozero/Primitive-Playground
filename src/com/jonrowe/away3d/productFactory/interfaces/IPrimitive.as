package com.jonrowe.away3d.productFactory.interfaces
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	
	import com.jonrowe.away3d.productFactory.PrimitiveInit;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public interface IPrimitive
	{
		//insert interface methods here
		function init( type :String, initObject :* ):void;
		function light( lights :Array ):void;
		function movePivot( x:Number, y:Number, z:Number ):void;
		
		function get object3D( ):ObjectContainer3D;
		function set object3D( obj:ObjectContainer3D ):void;
		function set primitiveName( name :String ):void;
		function get primitiveName( ):String;
		function set type( name :String ):void;
		function get type( ):String;
		function set selected( trueOrFalse :Boolean):void;
		function get selected( ):Boolean;
		function deleteObject():Boolean;
	}
}