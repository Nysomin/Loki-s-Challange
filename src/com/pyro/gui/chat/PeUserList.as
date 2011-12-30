package com.pyro.gui.chat 
{
	/**
	 * ...
	 * @author Leland Ede
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	import com.pyro.engine.gfx2d.style.PeStyle;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.objects.UserObject;

	public class PeUserList extends TextField
	{
		private var userList:Array;
		private var _list:Sprite;
		
		public function PeUserList(style:PeStyle, size:PePoint, pos:PePoint) 
		{
			userList = new Array();
				_list = new Sprite();
				_list.graphics.beginFill(style.backgroundColor);
				_list.graphics.drawRect(0, 0, size.x, size.y);
				_list.graphics.endFill();
				_list.x = pos.x;
				_list.y = pos.y;
			
			_list.addChild(this);
		}// End PeUserList constructor
		
		public function addUser(user:UserObject):void
		{
			var userIndex:int = findUser(user.userName);
			
			if (0 == userIndex)
			{
				userList.push(user);
				render();
			}
		}// End addUser
		
		// Method to find index of a user name
		public function findUser(user:String):int
		{
			// Default return value
			var index:int = 0;
			
			for (var i:int = 0; i < userList.length; i++)
			{
				if (userList[i].userName == user)
				{
					// Index found return value
					index = i;
					break;
				}
			}// End i loop
			
			return index;
		}// End method findUser
		
		public function removeUser(user:String):void
		{
			var i:int = findUser(user);
			if (i > 0)
			{
				userList.splice(i, 1);
			}
		}// End method removeUSer
		
		public function render():void
		{
			text = "";
			if (userList.length > 0)
			{
				var i:int = 0;
				for (i = 0; i < userList.length; i++)
				{
					super.appendText(userList[i].userName + "\n");
				}// End loop i
			}// Endif userList.length
		}// End onRender
		
		public function get uSprite():Sprite
		{
			return _list;
		}// End get button
	}

}