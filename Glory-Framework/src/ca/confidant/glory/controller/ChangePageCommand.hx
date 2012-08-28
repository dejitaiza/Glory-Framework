﻿package ca.confidant.glory.controller;    //import js.Dom;	import nme.display.Sprite;	import haxe.xml.Fast;	import nme.Assets;    import org.puremvc.haxe.patterns.command.SimpleCommand;	import org.puremvc.haxe.interfaces.INotification;//    import ca.confidant.glory.ApplicationFacade;    import ca.confidant.glory.view.PageMediator;	import ca.confidant.glory.view.ApplicationMediator;	import ca.confidant.glory.ApplicationFacade;	//import WidgetFramework;//	import ca.confidant.glory.model.LoaderProxy;	import ca.confidant.glory.model.PagesConfigProxy;	//import ca.confidant.glory.model.ControlsRegistryProxy;	import ca.confidant.glory.view.constants.ControlConstants;	import ca.confidant.glory.model.ControlsRegistryProxy;	import nme.display.DisplayObject;		/*	 * This is triggered by any control that has a pageForward, pageBackward, or pageSkipTo action. 	 * It triggers BuildPageCommand and RemovePageCommand and updates the current page in the PageConfigProxy.	 * It will trigger transitions in the future (when they are implemented).  	 */    class ChangePageCommand extends SimpleCommand    {		var pcp:PagesConfigProxy;		var appMediator:ApplicationMediator;		//var csp:ControlsRegistryProxy;        override public function execute( note:INotification ) : Void        {			trace('ChangePageCommand:'+note.getBody());			pcp=cast(facade.retrieveProxy(PagesConfigProxy.NAME) , PagesConfigProxy);			appMediator = cast(facade.retrieveMediator(ApplicationMediator.NAME) , ApplicationMediator);			var action=cast(note.getBody(),String);//current page						switch(action){				case ControlConstants.PAGE_FORWARD:					//var current:Hash<Dynamic>=pcp.getCurrentPage();					var nextPage=pcp.getNextPage();					if (nextPage != null){						sendNotification(ApplicationFacade.REMOVE_PAGE, pcp.getCurrentPage().get("id"));						sendNotification(ApplicationFacade.BUILD_PAGE, nextPage.get("id"));						pcp.setCurrentPageById(nextPage.get("id"));					}					floatControls();				case ControlConstants.PAGE_BACKWARD:					//var current:Hash<Dynamic>=pcp.getCurrentPage();					var prevPage=pcp.getPreviousPage();					if (prevPage != null){						sendNotification(ApplicationFacade.REMOVE_PAGE, pcp.getCurrentPage().get("id"));						sendNotification(ApplicationFacade.BUILD_PAGE, prevPage.get("id"));						pcp.setCurrentPageById(prevPage.get("id"));					}					floatControls();				default:					// must be a skip 					var p=pcp.getPageById(action);					var overlay:Bool=p.get("type")=="overlay";																if(p != null){						//if it's an overlay, we don't remove the underlying page or change the current page						if(!overlay){							sendNotification(ApplicationFacade.REMOVE_PAGE, pcp.getCurrentPage().get("id"));						}												sendNotification(ApplicationFacade.BUILD_PAGE, p.get("id"));						if(!overlay){							floatControls();							pcp.setCurrentPageById(p.get("id"));						}											}			}						//appMediator.reportLayers();        }		private function floatControls():Void{			var crp:ControlsRegistryProxy=cast(facade.retrieveProxy(ControlsRegistryProxy.NAME),ControlsRegistryProxy);			var controls:Array<Dynamic>=crp.getControls();			//trace("controls:"+controls.length);			var i=0;			for (thisControl in controls){				//trace("control:"+appMediator.getIndex(thisControl));								//must remove and re-add for the HTML5 target to work				appMediator.removeDisplayObject(thisControl);				appMediator.addDisplayObject(thisControl);				i++;			}		}    }
