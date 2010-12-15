/*********************************************************************************
 * 
 *        Class: DelegateInjector
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: injects a new instance of the specified delegate class
 * 				 into the specified property of the obj, with the obj as
 * 				 the responder *the specified obj must implement the 
 * 				 IResponder interface
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
	import flash.utils.describeType;
	
	import mx.rpc.IResponder;
	
	//############################################################################
	
	public class DelegateInjector implements IObjectInjector
	{
		//========================================================================
		// Attributes
		//========================================================================
    	protected var generator:Class;
		
		//========================================================================
		// Constructor
		//========================================================================
		public function DelegateInjector( delegate:Class )
		{
			var desc:XML = describeType( delegate );

			/** check if obj implements IResponder */
			if (desc.factory.extendsClass.(@type=='com.tylerbeck.mainline.business::Delegate').length() == 0)
				throw new Error('delegate class must extend com.tylerbeck.mainline.business::Delegate'); 

			generator = delegate;
			
		}
		
		//========================================================================
		// Functions
		//========================================================================
		//------------------------------------------------------------------------
		// inject - do injection
		//------------------------------------------------------------------------
		public function inject( obj:Object, property:String ) : void
		{			
			var desc:XML = describeType( obj );

			/** check if obj implements IResponder */
			if (desc.implementsInterface.(@type=='mx.rpc::IResponder').length() == 0)
				throw new Error('delegate injection host object must implement mx.rpc.IResponder'); 
			
			/** continue with injection	*/
			obj[property] = newInstance( obj as IResponder );

		}

		//------------------------------------------------------------------------
		// newInstance - get class object
		//------------------------------------------------------------------------
		public function newInstance(responder:IResponder):*
		{
			var instance:Object = new generator( responder );
	       	return instance;
		}
	
	}
}