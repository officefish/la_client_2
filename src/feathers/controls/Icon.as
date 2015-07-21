package feathers.controls 
{
	import feathers.core.FeathersControl;
	import feathers.skins.IStyleProvider;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Icon extends FeathersControl 
	{
		public static var globalStyleProvider:IStyleProvider; 
		
		public function Icon() 
		{
			
		}
		
		public function set backgroundSkin (target:DisplayObject) :void {
			this.removeChildren();
			this.addChild(target);
		}
		
		public function set source (target:DisplayObject) :void {
			this.removeChildren();
			this.addChild(target);
		}
		
		/**
		 * @private
		 */
		override protected function get defaultStyleProvider():IStyleProvider
		{
			return Icon.globalStyleProvider;
		}
		
	}

}