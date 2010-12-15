/*********************************************************************************
 * 
 *        Class: MainlineDispatcher
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: base class for mainline dispatcher classes 
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
 
package com.tylerbeck.mainline.dispatchers
{
	// IMPORTS ###################################################################
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	//############################################################################
	
	public class MainlineDispatcher implements IEventDispatcher
	{
		//========================================================================
		// Attributes
		//========================================================================
		protected var dispatcher : EventDispatcher;
		
		//========================================================================
		// Constructor
		//========================================================================
		public function MainlineDispatcher()
		{
			dispatcher = new EventDispatcher;
		}
		
		//========================================================================
		// Functions
		//========================================================================
		//------------------------------------------------------------------------
		// addEventListener - adds listener to framework dispatcher
		//------------------------------------------------------------------------
		public function addEventListener( type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false ) : void 
		{
			dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}

		//------------------------------------------------------------------------
		// removeEventListener - removes listener from framework dispatcher
		//------------------------------------------------------------------------
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean=false ) : void 
		{ 
			dispatcher.removeEventListener( type, listener, useCapture );
		}

		//------------------------------------------------------------------------
		// dispatchEvent - dispatches event from framework dispatcher
		//------------------------------------------------------------------------
		public function dispatchEvent( event:Event ) : Boolean 
		{ 
			return dispatcher.dispatchEvent( event );
		}

		//------------------------------------------------------------------------
		// hasEventListener - checks if framework has event listener
		//------------------------------------------------------------------------
		public function hasEventListener( type:String ) : Boolean
		{ 
			return dispatcher.hasEventListener( type );
		}

		//------------------------------------------------------------------------
		// willTrigger - checks if event will trigger listener
		//------------------------------------------------------------------------
		public function willTrigger( type:String ) : Boolean
		{ 
			return dispatcher.willTrigger( type );
		}

		

	}
}
