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

package com.tylerbeck.mainline
{
	
	// IMPORTS ###################################################################
	import com.tylerbeck.mainline.commands.Command;
	import com.tylerbeck.mainline.dispatchers.MainlineDispatcher;
	import com.tylerbeck.mainline.events.CommandEvent;
	import com.tylerbeck.mainline.events.MainlineEvent;
	import com.tylerbeck.mainline.injectors.IObjectInjector;
	import com.tylerbeck.mainline.logging.IMainlineLogger;
	import com.tylerbeck.mainline.logging.LogLevel;
	import com.tylerbeck.mainline.registries.CommandRegistryItem;
	import com.tylerbeck.mainline.registries.IRegistry;
	import com.tylerbeck.mainline.registries.InjectorRegistryItem;
	import com.tylerbeck.mainline.registries.RegistryItem;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	//############################################################################
	
	public class Mainline extends MainlineDispatcher
	{
		//========================================================================
		// STATIC ATTRIBUTES
		//========================================================================
		private static var instance:Mainline = null;
		
		//========================================================================
		// ATTRIBUTES
		//========================================================================
		private var initialized : Boolean = false;
		
		protected var registries : Array;
		protected var injectors : Dictionary;
		protected var events : Dictionary;
		
		//logging variables
		public var logEnabled : Boolean = false;
		public var logger:IMainlineLogger;
		
		public var useRegistryPriority:Boolean = true;
		
		//========================================================================
		// CONSTRUCTOR
		//========================================================================
		public function Mainline()
		{
			super();
			
			if ( instance != null)
				throw new Error("Only one instance of the Mainline framework can be instantiated!");
			
			reset();
			
		}
		
		//========================================================================
		// FUNCTIONS
		//========================================================================		
		//------------------------------------------------------------------------
		// loadRegistry - adds / loads registry's - this function should be called
		// 				  by all IRegistry Classes
		//------------------------------------------------------------------------
		public function loadRegistry( registry:IRegistry ) : void
		{
			debug('loadRegistry: '+registry,instance);
			if (!initialized)
				registries.push(registry);
			else
				loadRegistryItems(registry);
		}
		
		//------------------------------------------------------------------------
		// unloadRegistry - removes / unloads registrys
		//------------------------------------------------------------------------
		public function unloadRegistry( registry:IRegistry ) : void
		{
			debug('unloadRegistry: '+registry,this);
			for each(var item:RegistryItem in registry.items)
			{
				unloadRegistryItem( item )
			}
		}
		
		//------------------------------------------------------------------------
		// unloadRegistryItem - removes / unloads item
		//------------------------------------------------------------------------
		public function unloadRegistryItem( item:RegistryItem ) : void
		{
			switch (item.type)
			{
				case 'injector':
					injectors[item.id] = null;
					delete injectors[item.id];
					break;
				case 'command':
					var cItem:CommandRegistryItem = item as CommandRegistryItem;
					events[ cItem.id ] = null;
					delete events[ cItem.id ];
					if (cItem.command != null)
						dispatcher.removeEventListener(cItem.id,executeCommand);
					break;
			}
		}
		
		
		//------------------------------------------------------------------------
		// loadRegistryItems - adds / loads registry's injectors
		//------------------------------------------------------------------------
		public function loadRegistryItems( registry:IRegistry ) : void
		{		
			debug('loadRegistryItems: '+registry,this );
			for each(var item:RegistryItem in registry.items)
			{
				loadRegistryItem( item );
			}
		}	
		
		//------------------------------------------------------------------------
		// loadRegistryItem - adds / loads item
		//------------------------------------------------------------------------
		public function loadRegistryItem( item:RegistryItem ) : void
		{
			switch (item.type)
			{
				case 'injector':
					debug('add injector:'+item.id,this);
					if (injectors[item.id] != null)
						throw new Error("The injector ID '"+item.id+"' has already been taken");
					var iItem:InjectorRegistryItem = item as InjectorRegistryItem;
					injectors[ iItem.id ] = iItem.injector;
					break;
				case 'command':
					debug('add command:'+item.id,this);
					if (injectors[item.id] != null)
						throw new Error("The command ID '"+item.id+"' has already been taken");
					var cItem:CommandRegistryItem = item as CommandRegistryItem;
					events[ cItem.id ] = cItem;
					if (cItem.command != null)
						dispatcher.addEventListener( cItem.id, executeCommand );
					break;
			}
		}
		
		
		//------------------------------------------------------------------------
		// initialize - sets up loaded registries - sets up initial Mainline registries
		//------------------------------------------------------------------------
		public function initialize(event:Event = null) : void
		{			
			debug('initialize',this);
			
			if (useRegistryPriority)
				registries.sortOn('priority', Array.NUMERIC);
			
			for( var i:int = 0; i < registries.length; i++ )
			{
				var registry:IRegistry = registries[i] as IRegistry;
				loadRegistryItems(registry);
			}
		}
		
		//------------------------------------------------------------------------
		// reset - resets Mainline to uninitialized state
		//------------------------------------------------------------------------
		public function reset(event:Event = null) : void
		{			
			debug('reset',this);
			initialized = false;
			injectors = new Dictionary();
			events = new Dictionary();
			dispatcher = new EventDispatcher(this);
			registries = new Array();

		}
		
		//------------------------------------------------------------------------
		// executeCommand - executes a event command
		//------------------------------------------------------------------------
		protected function executeCommand( event:MainlineEvent ) : void
		{
			debug('executeCommand: '+event.type,this);
			var commandClass:Class = events[event.type].command;
			var command:Command =  new commandClass();
			if (command != null && command.hasOwnProperty( 'execute' ) )
			{
				if (event.completeCallback != null)
					command.addEventListener(CommandEvent.COMPLETE,event.completeCallback);
				if (event.errorCallback != null)
					command.addEventListener(CommandEvent.ERROR,event.errorCallback);
				command.execute(event.parameters);
			}
			else
			{
				throw new Error('method "execute" not found on '+events[event.type]);
			}
		}
		
		//------------------------------------------------------------------------
		// dispatch - dispatches a MainlineEvent
		//------------------------------------------------------------------------
		public function dispatch( type:String, paramObj:Object = null, completeCallback:Function = null, errorCallback:Function = null  ) : void
		{
			debug('dispatch: '+type,this);
			var event:MainlineEvent = new MainlineEvent( type, paramObj, completeCallback, errorCallback );
			dispatcher.dispatchEvent(event);
		}		
		
		//------------------------------------------------------------------------
		// introspect - examines object and does injections
		//------------------------------------------------------------------------
		public function introspect( obj:Object ) : void
		{
			if (logger && logger.logInternal)
				debug('introspect',obj);
			
			var objDescription:XML = describeType( obj );
			
			/** get the objects that need to be injected */
			var variables : XMLList = objDescription.variable.(child('metadata').(@name=='Inject').length() > 0);
			var accessors : XMLList = objDescription.accessor.(child('metadata').(@name=='Inject').length() > 0).(@access=='readwrite' || @access=='writeonly' || @access=='write');
			
			doInjections(obj,variables,accessors);
			
		}
		
		//------------------------------------------------------------------------
		// doInjections - do injections for descriptors
		//------------------------------------------------------------------------
		protected function doInjections( obj:Object, ...lists ) : void
		{
			for each (var list:XMLList in lists)
			{
				for (var i:String in list)
				{
					var item:XML = list[i];
					var property:String = item.@name;
					var injection:XML = item.metadata.(@name=='Inject')[0];
					
					/** only inject if argument is available */
					var id:String = (injection.hasOwnProperty('arg')) ? (injection.arg[0].@value) : ('');
					if (id != '')
					{
						/** do the injection */
						if (injectors[id] != null)
							injectors[id].inject( obj, property );
					}
				}
			}
		}
		
		//------------------------------------------------------------------------
		// getInjectorValue - return injector value
		//------------------------------------------------------------------------
		public function getInjectorValue( injectorId:String ) : *
		{
			debug('getInjectorValue: '+injectorId,this);
			var obj:Object = {prop:null};
			if (injectors[injectorId] != null)
				injectors[injectorId].inject( obj, 'prop' );
			return obj['prop'];
		}
		
		//------------------------------------------------------------------------
		// getInjectorClass - return injector class (only works with ClassInjector)
		//------------------------------------------------------------------------
		/**
		 * Returns a ClassInjector's generator class.  If the injector does not 
		 * implement "function get generatorClass():Class" the Object classs
		 * will be returned */
		public function getInjectorClass( injectorId:String ) : Class
		{
			debug('getInjectorClass: '+injectorId,this);
			
			if (injectors[injectorId].hasOwnProperty('generatorClass') )
			{
				return injectors[injectorId].generatorClass;
			}
			else
			{
				return Object;
			}
		}
		
		//------------------------------------------------------------------------
		// initLogging - 
		//------------------------------------------------------------------------
		protected function initLogging():void 
		{
			/*if (logger == null)
			{
			// Create a logger.
			logger = new AS3Logger();
			}
			
			// Begin logging.
			info('BEGIN LOGGING',this);*/
		}
		
		//------------------------------------------------------------------------
		// log - 
		//------------------------------------------------------------------------
		public function log(msg:String = '',target:Object = null, level:int = 3) : void
		{
			if (logEnabled)
			{
				logger.log(msg,target,level);
			}
		}
		
		//------------------------------------------------------------------------
		// debug - 
		//------------------------------------------------------------------------
		public function debug(msg:String = '',target:Object = null ) : void
		{
			log(msg,target,LogLevel.DEBUG);
		}
		
		//------------------------------------------------------------------------
		// info - 
		//------------------------------------------------------------------------
		public function info(msg:String = '',target:Object = null ) : void
		{
			log(msg,target,LogLevel.INFO);
		}
		
		//------------------------------------------------------------------------
		// warn - 
		//------------------------------------------------------------------------
		public function warn(msg:String = '',target:Object = null ) : void
		{
			log(msg,target,LogLevel.WARN);
		}
		
		//------------------------------------------------------------------------
		// error - 
		//------------------------------------------------------------------------
		public function error(msg:String = '',target:Object = null ) : void
		{
			log(msg,target,LogLevel.ERROR);
		}
		
		//------------------------------------------------------------------------
		// fatal - 
		//------------------------------------------------------------------------
		public function fatal(msg:String = '',target:Object = null ) : void
		{
			log(msg,target,LogLevel.FATAL);
		}
		
		
		// STATIC FUNCTION ALIASES ###############################################
		//------------------------------------------------------------------------
		// getInstance - gets singleton instance
		//------------------------------------------------------------------------
		public static function getInstance() : Mainline
		{
			if (instance == null)
			{
				instance = new Mainline();
			}
			return instance;
		}
		
		public static function initialize( event:Event = null) : void { Mainline.getInstance().initialize( event ) }
		public static function reset( event:Event = null) : void { Mainline.getInstance().reset( event ) }
		public static function introspect( obj:Object ) : void { Mainline.getInstance().introspect( obj ) }
		public static function inject( event:Event ) : void { Mainline.getInstance().introspect( event.currentTarget ) }
		public static function getInjectorValue( injectorId:String ) : * { return Mainline.getInstance().getInjectorValue( injectorId ) }
		public static function getInjectorClass( injectorId:String ) : Class { return Mainline.getInstance().getInjectorClass( injectorId ) }
		public static function loadRegistry( registry:IRegistry ) : void { Mainline.getInstance().loadRegistry( registry ) }
		public static function unloadRegistry( registry:IRegistry ) : void { Mainline.getInstance().unloadRegistry( registry ) }
		public static function loadRegistryItem( item:RegistryItem ) : void { Mainline.getInstance().loadRegistryItem( item ) }
		public static function unloadRegistryItem( item:RegistryItem ) : void { Mainline.getInstance().unloadRegistryItem( item ) }
		public static function dispatch( type:String, paramObj:Object = null, completeCallback:Function = null, errorCallback:Function = null ) : void { Mainline.getInstance().dispatch( type, paramObj, completeCallback, errorCallback ) }
		public static function addEventListener( type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false ) : void { Mainline.getInstance().addEventListener( type, listener, useCapture, priority, useWeakReference ); }
		public static function removeEventListener( type:String, listener:Function, useCapture:Boolean=false ) : void { Mainline.getInstance().removeEventListener( type, listener, useCapture ); }
		public static function dispatchEvent( event:Event ) : Boolean { return Mainline.getInstance().dispatchEvent( event ); }
		public static function log( msg:String, target:Object = null, level:int = 2 ) : void { return Mainline.getInstance().log( msg, target, level ); }
		public static function debug( msg:String, target:Object = null ) : void { return Mainline.getInstance().debug( msg, target ); }
		public static function info( msg:String, target:Object = null ) : void { return Mainline.getInstance().info( msg, target ); }
		public static function warn( msg:String, target:Object = null ) : void { return Mainline.getInstance().warn( msg, target ); }
		public static function error( msg:String, target:Object = null ) : void { return Mainline.getInstance().error( msg, target ); }
		public static function fatal( msg:String, target:Object = null ) : void { return Mainline.getInstance().fatal( msg, target ); }
		public static function set logEnabled( value:Boolean ) : void { Mainline.getInstance().logEnabled = value; }
		public static function get logEnabled() : Boolean { return Mainline.getInstance().logEnabled; }
		public static function set logger( value:IMainlineLogger ) : void { Mainline.getInstance().logger = value; }
		public static function get logger() : IMainlineLogger { return Mainline.getInstance().logger; }
		
	}
}