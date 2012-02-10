package com.jonrowe.away3d.meshGroupFactory.interfaces
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.entities.Mesh;
	import away3d.materials.MaterialBase;
	
	import com.jonrowe.away3d.meshGroupFactory.PrimitiveInit;
	
	import flash.geom.Vector3D;
	
	import uk.co.soulwire.gui.SimpleGUI;
	
	public interface IMeshGroupContainer3D
	{
		//insert interface methods here
		//function init( type :String, initObject :* ):void;
		function movePivot( x:Number, y:Number, z:Number ):void;
		
		function get meshContainer( ):ObjectContainer3D;
		function set meshContainer( obj:ObjectContainer3D ):void;
		function set primitiveName( name :String ):void;
		function get primitiveName( ):String;
		function set type( name :String ):void;
		function get type( ):String;
		function set selected( trueOrFalse :Boolean):void;
		function get selected( ):Boolean;
		function deleteObject():Boolean;
		
		function appendMesh( mesh:Mesh ):void;
		function applyMaterial( material:MaterialBase ):void;
		function light( lights :Array ):void;
		function set pivotPoint(pivot:Vector3D):void
		function get meshes():Vector.<Mesh>;
		
	}
}