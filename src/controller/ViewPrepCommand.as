/*
 PureMVC AS3 Demo - Flex Application Skeleton 
 Copyright (c) 2007 Daniele Ugoletti <daniele.ugoletti@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
*/
package controller
{
    import model.*;
    import view.ApplicationMediator;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;
    import org.puremvc.as3.patterns.observer.*;
    
    /**
     * Prepare the View for use.
     * 
     * <P>
     * The <code>Notification</code> was sent by the <code>Application</code>,
     * and a reference to that view component was passed on the note body.
     * The <code>ApplicationMediator</code> will be created and registered using this
     * reference. The <code>ApplicationMediator</code> will then register 
     * all the <code>Mediator</code>s for the components it created.</P>
     * 
     */
    public class ViewPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void    
		{
            // Register the ApplicationMediator
            facade.registerMediator( new ApplicationMediator( note.getBody() as Main ) );
			
			// send the notification for show the Splash Screen
			sendNotification( ApplicationFacade.VIEW_SPLASH_SCREEN );
        }
    }
}
