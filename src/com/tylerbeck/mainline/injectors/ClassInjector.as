/*********************************************************************************
 * 
 *        Class: ClassInjector
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: Use to inject new instances of the generator class
 * 				 with the specified properties
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
 
package com.tylerbeck.mainline.injectors
{	
	// IMPORTS ###################################################################
	
	//############################################################################
	
	public class ClassInjector implements IObjectInjector
	{
		//========================================================================
		// Attributes
		//========================================================================
    	protected var generator:Class;
		protected var properties:Object = null;
		protected var type:Class = null;
		
		//========================================================================
		// Constructor
		//========================================================================
		public function ClassInjector(generator:Class, props:Object = null, type:Class = null )
		{
			this.generator = generator;
			this.properties = props;
			this.type = type;
		}
		
		//========================================================================
		// GETTERS / SETTERS
		//========================================================================
		//------------------------------------------------------------------------
		// class
		//------------------------------------------------------------------------
		public function get generatorClass():Class
		{
			return generator;
		}
		
		//========================================================================
		// Functions
		//========================================================================
		//------------------------------------------------------------------------
		// inject - do inection
		//------------------------------------------------------------------------
		public function inject( obj:Object, property:String ) : void
		{
			if (type != null)	
				obj[property] = newInstance() as type;
			else
				obj[property] = newInstance();
		}
		
		//------------------------------------------------------------------------
		// newInstance - get class object
		//------------------------------------------------------------------------
		public function newInstance():*
		{
			var instance:Object = new generator();
	
	        if (properties != null)
	        {
	        	for (var p:String in properties)
				{
	        		instance[p] = properties[p];
				}
	       	}
	       		       	
	       	return instance;
		}

		
	}
}