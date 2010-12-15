/*********************************************************************************
 * 
 *        Interface: IMainlineLogger
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: Mainline Logging Interface
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
	
	public interface IMainlineLogger
	{
		function log(msg:String = '',target:Object = null, level:int = 2) : Boolean;
		function set logLevel(level:int) : void;
		function get logLevel() : int;
		function set logInternal(value:Boolean) : void;
		function get logInternal() : Boolean;
	}
}