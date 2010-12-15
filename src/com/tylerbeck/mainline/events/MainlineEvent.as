/*********************************************************************************
 * 
 *        Class: MainlineEvent
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: Event class utilized by Mainline Framework
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
 
package com.tylerbeck.mainline.events
{	
	// IMPORTS ###################################################################
	import flash.events.Event;
	
	//############################################################################
	public class MainlineEvent extends Event
	{
 		//========================================================================
		// Atrtributes
		//========================================================================
		public var parameters:Object;
		public var completeCallback:Function;
		public var errorCallback:Function;
		
 		//========================================================================
		// Constructor
		//========================================================================
		public function MainlineEvent(type:String, paramObj:Object = null, completeCallback:Function = null, errorCallback:Function = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.parameters = paramObj;
			this.completeCallback = completeCallback;
			this.errorCallback = errorCallback;
			super(type,bubbles,cancelable);
		}
				
	}
}