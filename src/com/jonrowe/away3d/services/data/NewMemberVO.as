package com.jonrowe.away3d.services.data
{
	public class NewMemberVO
	{
		public var authorID :String;
		public var message :String;
		
		public function NewMemberVO(id:String, msg:String){
			authorID = id;
			message = msg;
		}
	}
}