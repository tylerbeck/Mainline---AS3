/*********************************************************************************
 * 
 *        Class: Registry
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: base class for event registries, event registry classes 
 * 				 should override the initialize function to register events 
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
	import com.tylerbeck.mainline.Mainline;
	
	//############################################################################
	
	public class EventRegistry implements IRegistry
	{
		//========================================================================
		// ATTRIBUTES
		//========================================================================
		protected var _items:Array;
		protected var _priority:uint;
		
		//========================================================================
		// CONSTRUCTOR
		//========================================================================
		public function EventRegistry()
		{
			this.priority = 0xFFFFFF; //last
			Mainline.loadRegistry(this);
		}
		
		//========================================================================
		// GETTERS / SETTERS
		//========================================================================
		//------------------------------------------------------------------------
		// items - get registry items
		//------------------------------------------------------------------------
		public function get items() : Array
		{
			Mainline.introspect(this);
			_items = new Array();
			initialize();
			return _items;
		}

		//------------------------------------------------------------------------
		// priority - get registry items
		//------------------------------------------------------------------------
		public function get priority() : uint
		{
			return _priority;
		}
		public function set priority(value:uint) : void
		{
			_priority = value;
		}
		
		//========================================================================
		// FUNCTIONS
		//========================================================================
		//------------------------------------------------------------------------
		// initialize - registry initializer
		//------------------------------------------------------------------------
		protected function initialize() : void
		{
			
			/** this function should be overridden in 
			 *  the application's registry classes
			 */ 
		}

		//------------------------------------------------------------------------
		// register - register Event / Command chain
		//------------------------------------------------------------------------
		protected function register( eventName:String, command:Class ) : void
		{
			_items.push( new CommandRegistryItem( eventName, command ) );
		}

	}
}
