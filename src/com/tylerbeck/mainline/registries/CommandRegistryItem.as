/*********************************************************************************
 *		  Class: com.tylerbeck.mainline.registries.CommandRegistryItem
 *        
 *       Author: Tyler Beck
 *
 *  Description: 
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

package com.tylerbeck.mainline.registries
{
	// IMPORTS ###################################################################	
	import com.tylerbeck.mainline.injectors.IObjectInjector;
	

	//############################################################################
	
	public class CommandRegistryItem extends RegistryItem
	{
		//========================================================================
		// ATTRIBUTES
		//========================================================================
		public var command:Class;
		
		//========================================================================
		// CONSTRUCTOR
		//========================================================================
		public function CommandRegistryItem( eventName:String = "", command:Class = null )
		{
			this.id = eventName;
			this.type = 'command';
			this.command = command;
		}
		
	}
}