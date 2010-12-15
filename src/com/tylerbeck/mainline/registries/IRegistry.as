/*********************************************************************************
 * 
 *        Interface: IRegistry
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: Mainline Injection Registry Interface
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
	public interface IRegistry
	{
		function get priority() : uint;
		function set priority(value:uint) : void;
		function get items() : Array;  //change this to a vector of RegistryItem Objects
	}
}
