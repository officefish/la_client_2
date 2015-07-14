package com.la.mvc.model 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MiniCardData 
	{
		public var title:String;
		public var index:int;
		public var price:int;
		
		public function MiniCardData(title:String, price:int, index:int) :void {
			this.title = title;
			this.price = price;
			this.index = index;
		}
		
		
	}

}