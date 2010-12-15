/*********************************************************************************
 * 
 *        Class: Command
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: This class should be extended to create custom command classes.
 * 				 When used with a delegate injector, the IResponder interface
 * 				 should be implemented.
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
 
package com.tylerbeck.mainline.commands
{	
	// IMPORTS ###################################################################
	import com.tylerbeck.mainline.Mainline;
	import com.tylerbeck.mainline.dispatchers.MainlineDispatcher;
	import com.tylerbeck.mainline.events.CommandEvent;
	
	import flash.events.IEventDispatcher;
	
	//############################################################################
	
	[Event(name="start", type="com.tylerbeck.mainline.events.CommandEvent")]
	[Event(name="complete", type="com.tylerbeck.mainline.events.CommandEvent")]
	[Event(name="error", type="com.tylerbeck.mainline.events.CommandEvent")]
	public class Command extends MainlineDispatcher implements ICommand, IEventDispatcher
	{
		//========================================================================
		// Attributes
		//========================================================================		
		protected var parameters:Object;
		
 		//========================================================================
		// Constructor
		//========================================================================
		public function Command()
		{
			super();
			Mainline.debug( '', this );
			Mainline.introspect(this);
		}

 		//========================================================================
		// Functions
		//========================================================================
		//------------------------------------------------------------------------
		// execute
		//------------------------------------------------------------------------
		public function execute( parameters:Object = null ) : void
		{
			this.parameters = parameters;
			start();
			process();
			
		}

		//------------------------------------------------------------------------
		// process
		//------------------------------------------------------------------------
		protected function process() : void
		{
			/**
			 * This function should be overriden.
			 * 'Command::complete' should
			 * be called once the command processing is 
			 * complete and 'result' is available 
			 **/	
			throw new Error("ICommand::process was not overridden");
		}

		//------------------------------------------------------------------------
		// start - dispatches start event
		//------------------------------------------------------------------------
		protected function start( info:String = 'command processing started' ) : void
		{
			Mainline.debug( info, this);
			var startEvent:CommandEvent = new CommandEvent( CommandEvent.START );
			startEvent.data = null;
			startEvent.info = info;
			dispatcher.dispatchEvent(startEvent);
		}

		//------------------------------------------------------------------------
		// complete - dispatches complete event
		//------------------------------------------------------------------------
		protected function complete(info:String = 'command processing complete', data:* = null) : void
		{
			Mainline.debug( info, this );
			var completeEvent:CommandEvent = new CommandEvent( CommandEvent.COMPLETE );
			completeEvent.data = data;
			completeEvent.info = info;
			dispatcher.dispatchEvent(completeEvent);
		}

		//------------------------------------------------------------------------
		// error - dispatches error event
		//------------------------------------------------------------------------
		protected function error( info:String = 'command processing error', data:* = null ) : void
		{
			Mainline.error( info, this );
			var errorEvent:CommandEvent = new CommandEvent( CommandEvent.ERROR );
			errorEvent.data = data;
			errorEvent.info = info;
			dispatcher.dispatchEvent(errorEvent);
		}

	}
}