/*********************************************************************************
 * 
 *        Class: CommandQueue
 * 
 *       Author: ©2009 Tyler Beck (http://www.tylerbeck.com)
 * 
 *  Description: The command queue class can be used to link one or more
 * 				 commands together at runtime or in a registry.
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
	import com.tylerbeck.mainline.events.CommandEvent;
	
	import flash.utils.setTimeout;

	//############################################################################
	[Event(name="start", type="com.tylerbeck.mainline.events.CommandEvent")]
	[Event(name="complete", type="com.tylerbeck.mainline.events.CommandEvent")]
	[Event(name="error", type="com.tylerbeck.mainline.events.CommandEvent")]
	public class CommandQueue extends Command
	{
		//========================================================================
		// Attributes
		//========================================================================
		protected var queue:Array;
		public var ignorErrors:Boolean = false;
		public var delay:int = 0;
		
 		//========================================================================
		// Constructor
		//========================================================================
		public function CommandQueue()
		{
			super();
			queue = new Array();
		}

 		//========================================================================
		// Functions
		//========================================================================
		//------------------------------------------------------------------------
		// addCommand - adds command to queue
		//------------------------------------------------------------------------
		public function addCommand( command:ICommand, parameters:Object = null, completeCallback:Function = null, errorCallback:Function = null ) : void
		{
			queue.push({command:command, parameters:parameters, complete:completeCallback, error:errorCallback});
		}

		//------------------------------------------------------------------------
		// execute - begins queue execution
		//------------------------------------------------------------------------
		override public function execute( parameters:Object = null ) : void
		{
			start('queue processing start');
			executeNext();
		}

		//------------------------------------------------------------------------
		// executeNext - executes next command in queue
		//------------------------------------------------------------------------
		protected function executeNext( event:CommandEvent = null ) : void
		{
			if (queue.length > 0)
			{
				var cObj:Object = queue.shift();
				var command:Command = cObj.command as Command;
				var params:Object = cObj.parameters;
				var complete:Function = cObj.complete as Function;
				var error:Function = cObj.error as Function;
				
				command.addEventListener(CommandEvent.COMPLETE, delayExecuteNext);
				command.addEventListener(CommandEvent.ERROR, handleError);
				
				if (complete != null)
					command.addEventListener(CommandEvent.COMPLETE, complete);
				if (error != null)
					command.addEventListener(CommandEvent.ERROR, error);
				
				command.execute( params );
			}
			else
			{
				super.complete('queue processing complete');
			}
		}
		//------------------------------------------------------------------------
		// delayExecuteNext - executes next command in queue
		//------------------------------------------------------------------------
		protected function delayExecuteNext( event:CommandEvent = null ) : void
		{
			if (delay > 0)
				flash.utils.setTimeout( executeNext, delay );
			else
				executeNext();
		}
		

		//------------------------------------------------------------------------
		// handleError - error handler
		//------------------------------------------------------------------------
		protected function handleError( event:CommandEvent = null ):void
		{
			if (ignorErrors)
			{
				flash.utils.setTimeout( executeNext, delay );
			}
			error(event.info);
		}
		

	}
}