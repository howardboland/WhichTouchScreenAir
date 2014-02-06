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
    public class NewsMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "NewsMediator";
        
        /**
         * Constructor. 
         */
        public function NewsMediator( viewComponent:NewsView ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
			
			viewComponent.addEventListener(NewsView.GO_BACK, this.navigateBack);
			viewComponent.addEventListener(NewsView.AUTO, this.auto);
			viewComponent.addEventListener(NewsView.GO_PORTFOLIO, this.navigatePortfolio);
			viewComponent.addEventListener(NewsView.GO_WEBSITE, this.navigateWebsite);
			viewComponent.addEventListener(NewsView.PREVIOUS_ITEM, this.previousNews);
			viewComponent.addEventListener(NewsView.NEXT_ITEM, this.nextNews);
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
					NewsProxy.LOAD_FAILED,
					NewsProxy.LOAD_SUCCESSFUL,
					ApplicationFacade.VIEW_NEWS
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
				case ApplicationFacade.VIEW_NEWS:
					//viewComponent.onInit();
					
					newsProxy.load();
					break;
				case NewsProxy.LOAD_FAILED:
					Console.log("NewsProxy.LOAD_FAILED", this);
					break;
				case NewsProxy.LOAD_SUCCESSFUL:
					Console.log("NewsProxy.LOAD_SUCCESSFUL", this);
						nextNews();
					break;
            }
        }
		
		protected function get newsProxy():NewsProxy
		{
			return NewsProxy(facade.retrieveProxy( NewsProxy.NAME ));
		}
		protected function auto( e:Event ):void
		{
			if (newsProxy.isLast())
				this.sendNotification( ApplicationFacade.VIEW_VIDEO );
			else
				nextNews();
		}
		protected function navigateBack( e:Event ):void
		{
			Console.log("navigateBack", this);
			this.sendNotification( ApplicationFacade.VIEW_VIDEO );
		}
		protected function navigatePortfolio( e:Event ):void
		{
			Console.log( "Go to portfolio", this);
			this.sendNotification( ApplicationFacade.VIEW_PORTFOLIO );
		}
		protected function navigateWebsite( e:Event ):void
		{
			this.sendNotification( ApplicationFacade.VIEW_BROWSER, {url : this.viewComponent.url} );
		}
		protected function previousNews( e:Event=null ):void
		{
			//speak to model
			if (!newsProxy.hasData())
				this.sendNotification( ApplicationFacade.VIEW_VIDEO );
			else
				this.viewComponent.populate( newsProxy.previousItem() )
		}
		protected function nextNews( e:Event=null ):void
		{
			//speak to model
			if (!newsProxy.hasData())
				this.sendNotification( ApplicationFacade.VIEW_VIDEO );
			else
				this.viewComponent.populate( newsProxy.nextItem() )
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
