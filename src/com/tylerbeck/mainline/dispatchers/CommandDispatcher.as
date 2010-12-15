/*********************************************************************************
 * 
 *        Class: CommandDispatcher
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: This class should be extended to create custom command dispatchers.
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
 
package com.tylerbeck.mainline.dispatchers
{	
	// IMPORTS ###################################################################
	import com.tylerbeck.mainline.Mainline;
	
	//############################################################################
	
	public class CommandDispatcher
	{
		
 		//========================================================================
		// ATTRIBUTES
		//========================================================================
		protected var commandName:String = '';
		
 		//========================================================================
		// CONSTRUCTOR
		//========================================================================
		public function CommandDispatcher()
		{

		}

 		//========================================================================
		// FUNCTIONS
		//========================================================================
		//------------------------------------------------------------------------
		// dispatch
		//------------------------------------------------------------------------
		public function dispatch( completeCallback:Function = null, errorCallback:Function = null ) : void
		{
			if (commandName != '')
			{
				Mainline.dispatch( commandName, this, completeCallback, errorCallback);
			}
			else
			{
				throw new Error('CommandDispatcher::commandName not set!');
			}
		}
	}
}