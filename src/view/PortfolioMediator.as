/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package view
{
	import flash.events.Event;
	
	import model.*;
	
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.*;

    /**
     * A Mediator for interacting with the SplashScreen component.
     */
    public class PortfolioMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "PortfolioMediator";
        
        /**
         * Constructor. 
         */
        public function PortfolioMediator( viewComponent:PortfolioView ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
			
			viewComponent.addEventListener(PortfolioView.GO_WEBSITE, navigateWebsite);
			viewComponent.addEventListener(PortfolioView.GO_NEWS, navigateNews);
			viewComponent.addEventListener(NewsView.AUTO, this.auto);
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
					StartupMonitorProxy.LOADING_STEP,
					StartupMonitorProxy.LOADING_COMPLETE,
					ConfigProxy.LOAD_SUCCESSFUL,
					ConfigProxy.LOAD_FAILED,
					LocaleProxy.LOAD_FAILED,
					ApplicationFacade.VIEW_PORTFOLIO
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
            switch ( note.getName() ) 
			{
				case ApplicationFacade.VIEW_PORTFOLIO:
					viewComponent.onInit();
					break;
            }
        }
		protected function navigateNews( e:Event ):void
		{
			this.sendNotification( ApplicationFacade.VIEW_NEWS );
		}
		protected function navigateWebsite( e:Event ):void
		{
			this.sendNotification( ApplicationFacade.VIEW_BROWSER, {url : this.viewComponent.url} );
		}
		protected function auto( e:Event ):void
		{
				this.sendNotification( ApplicationFacade.VIEW_VIDEO );
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
		
    }
}
