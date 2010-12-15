/*********************************************************************************
 * 
 *    Interface: ICommand
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: This interface defines the minimum requirements 
 * 			     for a Mainline framework Command.
 * 
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 *********************************************************************************/
 
package com.tylerbeck.mainline.commands
{
	import flash.events.Event;
	
	[Event(name="start", type="com.tylerbeck.mainline.events.CommandEvent")]
	[Event(name="complete", type="com.tylerbeck.mainline.events.CommandEvent")]
	[Event(name="error", type="com.tylerbeck.mainline.events.CommandEvent")]
	public interface ICommand
	{		
		function execute( parameters:Object = null ) : void;
		function addEventListener( type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false ) : void;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean=false ) : void;
		function dispatchEvent( event:Event ) : Boolean;
		function hasEventListener( type:String ) : Boolean;
		function willTrigger( type:String ) : Boolean
	}
}