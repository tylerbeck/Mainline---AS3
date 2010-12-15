/*********************************************************************************
 * 
 *    	 Class: Delegate
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: This base class for a Mainline framework Delegate.
 * 
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
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
 
package com.tylerbeck.mainline.business
{	
// IMPORTS ###################################################################
	import com.tylerbeck.mainline.Mainline;

	import mx.rpc.IResponder;
		
//############################################################################
	
	public class Delegate
	{
		//========================================================================
		// ATTRIBUTES
		//========================================================================
		protected var responder:IResponder;
		
		//========================================================================
		// CONSTRUCTOR
		//========================================================================
		public function Delegate( responder:IResponder )
		{
			Mainline.introspect(this);
			this.responder = responder;
		}				
	}
}