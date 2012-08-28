﻿package ca.confidant.glory.model;	import nme.display.DisplayObject;    import org.puremvc.haxe.patterns.proxy.Proxy;	import haxe.Timer;	import ca.confidant.glory.ApplicationFacade;	/*	 *  @author Allan Dowdeswell	 *  This proxy exists to provide ticker-style events, which are useful for map-panning, etc.	 *  Control it using the TimerEnable/TimerDisable commands.	 */	class TickerProxy extends Proxy	{		private var interval:Int; //milliseconds		private var myTimer:Timer;		public static var NAME:String = "TickerProxy";		/**		 * Use this proxy to broadcast framework-wide ticker events		 */		public function new( )		{	       		super ( NAME);		}		public function startTimer(i:Int=0):Void{			//trace("startTimer!");			myTimer=new Timer(interval);			myTimer.run = onTimerTick;		}		public function stopTimer():Void{			myTimer.stop();		}		private function onTimerTick():Void{			//trace("onTimerTick");			sendNotification(ApplicationFacade.TIMER_TICK);		}		public function setInterval(i:Int):Void{			interval=i;		}	}