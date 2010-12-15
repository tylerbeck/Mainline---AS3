/*********************************************************************************
 * 
 *        Class: FlexLogger
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
	import com.tylerbeck.mainline.Mainline;
	
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	
	//############################################################################
	
	public class FlexLogger extends AS3Logger implements IMainlineLogger
	{
		//========================================================================
		// ATTRIBUTES
		protected var verboseLogging : Boolean = false;
		protected var logTarget : ILoggingTarget;
		protected var logger:ILogger;

		//========================================================================
		// CONSTRUCTOR
		//========================================================================
		public function FlexLogger(logTarget:ILoggingTarget = null, verboseLogging:Boolean = true)
		{
			this.verboseLogging = verboseLogging;
			this.logTarget = logTarget;
			
			initLogging();			
		}
		
		//========================================================================
		// FUNCTIONS
		//========================================================================		
		//------------------------------------------------------------------------
		// initLogging - 
		//------------------------------------------------------------------------
		protected function initLogging():void 
		{
            if (logTarget == null)
            {
	            // Create a target.
	            var tt:TraceTarget = new TraceTarget();
	            tt.filters=["*"];
	            tt.level = _logLevel;
	
	            // Add date, time, category, and log level to the output.
	            tt.includeDate = verboseLogging;
	            tt.includeTime = verboseLogging;
	            tt.includeCategory = verboseLogging;
	            tt.includeLevel = verboseLogging;
	            logTarget = tt;
            }
            
            // Begin logging.
            Log.addTarget(logTarget);
            logger = Log.getLogger('Mainline');
 			log('BEGIN LOGGING',this,LogLevel.INFO);
        }
		
		//------------------------------------------------------------------------
		// logLevel - 
		//------------------------------------------------------------------------
		override public function set logLevel(level:int) : void
		{
			super.logLevel = level;
			if (logTarget != null)
				logTarget.level = level;
		}
		
				
		//------------------------------------------------------------------------
		// log - 
		//------------------------------------------------------------------------
		override public function log(msg:String = '',target:Object = null, level:int = 2) : Boolean
		{
			var className:String = flash.utils.getQualifiedClassName(target);
			if ( this._logInternal || className.indexOf('com.tylerbeck.mainline')==-1 )
			{
				logger.log(level,className+' - '+msg);
				return (level > _logLevel)
			}
			return false;
		}
		
		
	}
}