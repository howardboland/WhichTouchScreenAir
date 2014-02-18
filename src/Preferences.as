package
{
	public class Preferences
	{
		public static var server:String = "http://test.c-lab.co.uk/services";
		public static function getHiRes( s:String ):String
		{
			var regex:RegExp = new RegExp("(.png|.jpg)");
			var imgurlHR:String = s.replace(regex, "hr"+(s.indexOf(".png")>=0 ? ".png" : ".jpg") );
			return imgurlHR;
		}
	}
}