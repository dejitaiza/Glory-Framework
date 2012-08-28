﻿package ca.confidant.glory.controller;    //import org.puremvc.as3.interfaces.ICommand;    import org.puremvc.haxe.interfaces.INotification;    import org.puremvc.haxe.patterns.command.SimpleCommand;//    import ca.confidant.glory.ApplicationFacade;//    import ca.confidant.glory.view.StageMediator;//	import ca.confidant.glory.view.ApplicationMediator;//	import ca.confidant.glory.view.PeopleCarouselMediator;//	import ca.confidant.glory.view.ExternalInterfaceMediator;//	import ca.confidant.glory.view.components.PeopleCarouselComponent;	import ca.confidant.glory.model.PagesConfigProxy;	import ca.confidant.glory.model.LoaderProxy;	//import ca.confidant.glory.*;	//import WidgetFramework;	//import tv.stinkdigital.puremvcbase.model.BulkLoaderProxy;	/*	 * @author Allan Dowdeswell	 * Triggered by the LoaderProxy. This passes the XML to the PagesConfigProxy for parsing.	 */    class HandleAssetsLoadedCommand extends SimpleCommand    {        override public function execute( note:INotification ) : Void        {			trace('HandleAssetsLoadedCommand');			var lp:LoaderProxy=cast(facade.retrieveProxy(LoaderProxy.NAME),LoaderProxy);			var assetID=cast(note.getBody(),String);			if(assetID=="xml"){				var pcp:PagesConfigProxy=cast(facade.retrieveProxy(PagesConfigProxy.NAME),PagesConfigProxy);				pcp.loadXML(lp.retrieveLoadedAsset(assetID));			}        }    }