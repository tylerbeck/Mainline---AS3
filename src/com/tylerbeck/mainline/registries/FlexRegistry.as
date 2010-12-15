/*********************************************************************************
 * 
 *        Class: FlexRegistry
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: base class for Flex injection registries, registry classes should 
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
	import com.tylerbeck.mainline.injectors.DelegateInjector;
	import com.tylerbeck.mainline.injectors.IObjectInjector;
	import com.tylerbeck.mainline.injectors.ObjectInjector;
	
	
	//############################################################################
	
	public class FlexRegistry extends AS3Registry
	{
		//========================================================================
		// Constructor
		//========================================================================
		public function FlexRegistry()
		{
			super();
		}
		
		//========================================================================
		// Functions
		//========================================================================
		//------------------------------------------------------------------------
		// registerDelegate - register IDelegate
		//------------------------------------------------------------------------
		protected function registerDelegate( id:String, delegateClass:Class ) : void
		{
			register( id, new DelegateInjector(delegateClass) );
		}

	}
}
