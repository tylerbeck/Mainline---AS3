/*********************************************************************************
 * 
 *    	 Class: Agent
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: This base class for a Mainline framework Agent.
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
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

//############################################################################
	
	public class Agent extends EventDispatcher
	{
		//========================================================================
		// ATTRIBUTES
		//========================================================================
		protected var clients:Dictionary;
		protected var _count:int = 0;
		
		//========================================================================
		// CONSTRUCTOR
		//========================================================================
		public function Agent( )
		{
			super();
			Mainline.introspect(this);
			clients = new Dictionary();
		}
		
		//========================================================================
		// GETTERS SETTERS
		//========================================================================
		//------------------------------------------------------------------------
		// 	clientCount
		//------------------------------------------------------------------------
		public function get clientCount() : int
		{
			return _count;
		}
		
		//========================================================================
		// FUNCTIONS
		//========================================================================
		//------------------------------------------------------------------------
		//  clientExists											
		//------------------------------------------------------------------------
		public function clientExists( id:String ) :Boolean
		{
			return clients[id] != null;
		}
		
		//------------------------------------------------------------------------
		//  addClient											
		//------------------------------------------------------------------------
		public function addClient( client:*, id:String ) :void
		{
			clients[id] = client;
			_count++;
		}
		
		//------------------------------------------------------------------------
		//  removeClient											
		//------------------------------------------------------------------------
		public function removeClient( id:String ) :void
		{
			if ( clients[id] != null )
			{
				delete clients[id];
				_count--;
			}
		}
		
		//------------------------------------------------------------------------
		//  getClient											
		//------------------------------------------------------------------------
		public function getClient( id:String ) : *
		{
			return clients[id];
		}
		
		//------------------------------------------------------------------------
		//  renameClient											
		//------------------------------------------------------------------------
		public function renameClient( oldId:String, newId:String ):void
		{			
			this.clients[ newId ] = this.getClient( oldId );
			delete this.clients[ oldId ];
		}
		
	}
}