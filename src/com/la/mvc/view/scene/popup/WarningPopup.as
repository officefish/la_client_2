package com.la.mvc.view.scene.popup 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class WarningPopup extends Sprite 
	{
		
		private var lbl:TextField;
		
		private var confirmBtn:PopupBtn;
		private var cancelBtn:PopupBtn;
		
		private var _confirmCallBack:Function;
		private var _cancelCallback:Function;
		
		public function WarningPopup(msg:String, 
		confirmFlag:Boolean = false, 
		cancelFlag:Boolean = false,
		confirmCallback:Function = null,
		cancelCallback:Function = null
		):void 
		{
			_confirmCallBack = confirmCallback;
			_cancelCallback = cancelCallback;
			
			trace (_confirmCallBack);
			
			graphics.beginFill (0xEEEEEE, 1);
			graphics.drawRect (0, 0, 450, 200);
			graphics.endFill();
			
			lbl = new TextField ();
			lbl.width = 350;
			lbl.x = 50;
			lbl.wordWrap = true;
			lbl.autoSize = TextFieldAutoSize.CENTER;
			lbl.defaultTextFormat = WarningPopup.format;
			lbl.text = msg;
			lbl.y = 50;
			lbl.mouseEnabled = false;
			addChild (lbl);
			
			if (confirmFlag && !cancelFlag) {
				confirmBtn = new PopupBtn ('Понятно');
				confirmBtn.x = (this.width - confirmBtn.width) / 2;
				confirmBtn.y = 170;
				confirmBtn.addEventListener (MouseEvent.CLICK, onConfirmClick);
				addChild (confirmBtn);
			}
			
			if (confirmFlag && cancelFlag) {
				confirmBtn = new PopupBtn ('Да');
				confirmBtn.x = (this.width - (confirmBtn.width * 2 + 10)) / 2;
				confirmBtn.addEventListener (MouseEvent.CLICK, onConfirmClick);
				confirmBtn.y = 135;
				addChild (confirmBtn);
				
				cancelBtn = new PopupBtn ('Нет');
				cancelBtn.x = confirmBtn.x + confirmBtn.width + 10;
				cancelBtn.y = 135;
				cancelBtn.addEventListener (MouseEvent.CLICK, onCancelClick);
				addChild (cancelBtn);
			}
			
			buttonMode = true;
		}
		
		private static var _format:TextFormat;
		private static function get format () :TextFormat {
			if (!_format) {
				_format = new TextFormat ();
				_format.size = 14;
				_format.bold = true;
				_format.align = TextFormatAlign.CENTER;
				_format.color = 0x222222;
			}
			return _format;
		}
		
		private function onCancelClick (event:MouseEvent) :void {
			confirmBtn.removeEventListener (MouseEvent.CLICK, onConfirmClick);
			cancelBtn.removeEventListener (MouseEvent.CLICK, onCancelClick);
			if (_cancelCallback != null) _cancelCallback ();
		}
		
		private function onConfirmClick (event:MouseEvent) :void {
			confirmBtn.removeEventListener (MouseEvent.CLICK, onConfirmClick);
			if (cancelBtn) {
				cancelBtn.removeEventListener (MouseEvent.CLICK, onCancelClick);
			}
			
			if (_confirmCallBack != null) _confirmCallBack ();
		}
		
	}

}