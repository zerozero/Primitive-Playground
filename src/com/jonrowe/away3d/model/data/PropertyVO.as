package com.jonrowe.away3d.model.data
{
	public class PropertyVO
	{
		public var propName :String;
		public var min :Number;
		public var max :Number;
		public var label :String;
		public var controlType :String;
		
		public function PropertyVO( propName :String, min : Number, max : Number, label :String, controlType :String )
		{
			this.propName = propName;
			this.min = min;
			this.max = max;
			this.label = label;
			this.controlType = controlType;
		}
	}
}