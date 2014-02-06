/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package view
{
	import com.which.utils.Console;
	
	import flash.events.Event;
	
	import model.*;
	
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.*;

    /**
     * A Mediator for interacting with the SplashScreen component.
     */
    public class BrowserMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "BrowserMediator";
        
        /**
         * Constructor. 
         */
        public function BrowserMediator( viewComponent:BrowserView ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
			viewComponent.addEventListener(NewsView.GO_BACK, this.navigateBack);
        }
		
		

        /**
         * List all notifications this Mediator is interested in.
         * <P>
         * Automatically called by the framework when the mediator
         * is registered with the view.</P>
         * 
         * @return Array the list of Nofitication names
         */
        override public function listNotificationInterests():Array 
        {
            return [ 
					ApplicationFacade.VIEW_BROWSER
					];
        }

        /**
         * Handle all notifications this Mediator is interested in.
         * <P>
         * Called by the framework when a notification is sent that
         * this mediator expressed an interest in when registered
         * (see <code>listNotificationInterests</code>.</P>
         * 
         * @param INotification a notification 
         */
        override public function handleNotification( note:INotification ):void 
        {
			Console.log("note.getName():"+note.getName(), this);
            switch ( note.getName() ) 
			{
				case ApplicationFacade.VIEW_BROWSER:
					//newsProxy.load();
					Console.log("URL:"+note.getBody().url,this);
					this.viewComponent.open( note.getBody().url );
					break;
            }
        }
		
		
		protected function navigateBack( e:Event ):void
		{
			Console.log("navigateBack", this);
			this.sendNotification( ApplicationFacade.BACK );
		}

        /**
         * Cast the viewComponent to its actual type.
         * 
         * <P>
         * This is a useful idiom for mediators. The
         * PureMVC Mediator class defines a viewComponent
         * property of type Object. </P>
         * 
         * <P>
         * Here, we cast the generic viewComponent to 
         * its actual type in a protected mode. This 
         * retains encapsulation, while allowing the instance
         * (and subclassed instance) access to a 
         * strongly typed reference with a meaningful
         * name.</P>
         * 
         * @return SplashScreen the viewComponent cast to org.puremvc.as3.demos.flex.appskeleton.view.components.SplashScreen
         */
		 
        protected function get splashScreen():SplashScreen
		{
            return viewComponent as SplashScreen;
        }
		
		/**
         * End effect event
         */
		private function endEffect(event:Event=null):void
		{
			// start to load the resources
			var startupMonitorProxy:StartupMonitorProxy = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			startupMonitorProxy.loadResources();
		}
		
    }
}
