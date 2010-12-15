/*********************************************************************************
 * 
 *        Class: Mainline
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: Mainline Framework foundation singleton class
 * 
 *    IMPORTANT: "-keep-as3-metadata=Inject" must be added to 
 * 				 additional compiler settings
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
 
package com.tylerbeck.mainline.logging
{

	// IMPORTS ###################################################################
	import flash.utils.getQualifiedClassName;
	
	//############################################################################
	
	public class AS3Logger implements IMainlineLogger
	{
		//========================================================================
		// ATTRIBUTES
		//========================================================================
		protected var _logLevel:int = 0; //log all
		public var _logInternal : Boolean = false;

		//========================================================================
		// CONSTRUCTOR
		//========================================================================
		public function AS3Logger()
		{
			
		}
		
		//========================================================================
		// FUNCTIONS
		//========================================================================		
		//------------------------------------------------------------------------
		// logLevel - 
		//------------------------------------------------------------------------
		public function set logLevel(level:int) : void
		{
			_logLevel = level;
		}
		public function get logLevel() : int
		{
			return _logLevel;
		}
		//------------------------------------------------------------------------
		// logInternal - 
		//------------------------------------------------------------------------
		public function set logInternal(value:Boolean) : void
		{
			_logInternal = value;
		}
		public function get logInternal() : Boolean
		{
			return _logInternal;
		}
		//------------------------------------------------------------------------
		// log - 
		//------------------------------------------------------------------------
		public function log(msg:String = '',target:Object = null, level:int = 2) : Boolean
		{
			if (level > _logLevel)
			{
				var logged:Boolean = false;
				var className:String = flash.utils.getQualifiedClassName(target);
				if ( this._logInternal || className.indexOf('com.tylerbeck.mainline')==-1 )
				{
					var time:Date = new Date();
					
					trace('['+level+'] ['+time.time+'] '+className+' - '+msg);
					logged = true;
				}
			}
			return logged;
		}
		
		
	}
}