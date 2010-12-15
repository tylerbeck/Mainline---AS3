/*********************************************************************************
 * 
 *        Class: AS3Registry
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: base class for AS3 injection registries, registry classes should 
 * 				 override the initialize function to register injectors 
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
	import com.tylerbeck.mainline.injectors.ClassInjector;
	import com.tylerbeck.mainline.injectors.IObjectInjector;
	import com.tylerbeck.mainline.injectors.ObjectInjector;
	
	
	//############################################################################
	
	public class AS3Registry implements IRegistry
	{
		//========================================================================
		// Attributes
		//========================================================================
		protected var _items:Array;
		protected var _priority:uint;
		
		//========================================================================
		// Constructor
		//========================================================================
		public function AS3Registry()
		{
			_items = new Array();
			this.priority = 0x888888;
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
		// Functions
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
		// register - register IObjectInjector
		//------------------------------------------------------------------------
		protected function register( id:String, injector:IObjectInjector ) : void
		{
			_items.push( new InjectorRegistryItem(id, injector) );
		}

		//------------------------------------------------------------------------
		// registerFactory - register class injector
		//------------------------------------------------------------------------
		protected function registerClass( id:String, generator:Class, properties:Object = null, type:Class = null ) : void
		{
			register( id, new ClassInjector(generator,properties,type) );
		}

		//------------------------------------------------------------------------
		// registerResource - register shared object
		//------------------------------------------------------------------------
		protected function registerObject( id:String, obj:* ) : void
		{
			register( id, new ObjectInjector(obj) );
		}

	}
}
