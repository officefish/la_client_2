package com.sla.mvc.view.lobby 
{
	import feathers.controls.List;
	import feathers.data.ListCollection;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InvitesStack extends Stack 
	{
		
		private var rendererStyleName:String;
		
		public function InvitesStack(title:String, width:int, height:int, rendererStyleName:String) 
		{
			this.rendererStyleName = rendererStyleName;
			super(title, width, height);
		}
		
		override protected function initList():void 
		{
			list = new List(); 
			list.isSelectable = true;
			list.styleNameList.add(rendererStyleName);
			list.width = width - 4;
			list.x = 2;
			list.height = height - 42;
			list.y = 37;
			addChild(list); 
			
			var data:Array = [
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 },
			{id:1, uid:1, level:1, mode:1 }
			]
			
			var collection:ListCollection = new ListCollection(data);
			list.dataProvider = collection; 
		}
		
	}

}