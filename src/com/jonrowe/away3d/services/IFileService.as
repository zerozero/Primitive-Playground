package com.jonrowe.away3d.services
{
	import away3d.entities.Mesh;

	public interface IFileService
	{
		function loadMesh():void;
		function get loadedMesh():Mesh;
	}
}