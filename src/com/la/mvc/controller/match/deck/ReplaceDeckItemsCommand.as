package com.la.mvc.controller.match.deck 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.MatchServiceEvent;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.deck.FieldDeckRow;
	import com.la.mvc.view.field.deck.FieldDeckSlot;
	import com.la.mvc.view.field.deck.FieldDeckWidget;
	import com.la.mvc.view.field.IField;
	import flash.display.Sprite;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ReplaceDeckItemsCommand extends Command 
	{
		[Inject]
		public var event:MatchServiceEvent;
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='field')]
		public var field:IField; 
		
		private var widget:FieldDeckWidget;
		private var initiatorSlot:FieldDeckSlot;
		private var railItems:Array;
		private var animationCof:int;
		private var rails:Array;
		private var initiatorRail:Sprite;
		private var sameRowFlag:Boolean;
		private var targetSlot:FieldDeckSlot;
		
		override public function execute():void 
		{
			rails = [];
			var initiatorIndex:int = event.getData().initiator;
			var targetIndex:int = event.getData().target;
			widget = field.getDeckWidget();
			initiatorSlot = widget.getSlot(initiatorIndex);
			targetSlot = widget.getSlot(targetIndex);
			
			var targetRow:FieldDeckRow = targetSlot.parent as FieldDeckRow;
			var initiatorRow:FieldDeckRow = initiatorSlot.parent as FieldDeckRow;
			var downRail:Sprite;
			
			var endRowX:int;
			var rail:Sprite;
				
			
			sameRowFlag = false;
			if (targetRow == initiatorRow) {
				sameRowFlag = true;
			}
			
			initiatorSlot.visible = false;
			
			if (initiatorIndex < targetIndex) {
				
				// сразу же ставим перетаскиваемую ячейку на новую позицию в ряд. 
				targetRow.addChildAt(initiatorSlot, 0);
				initiatorSlot.x = targetSlot.x;
				initiatorSlot.y = targetSlot.y;
				
				// Обрабатываем ряд в который добавляется перетаскиваемая ячейка
				rail = new Sprite ();
				if (sameRowFlag) {
					rail.x = (initiatorSlot.position + 1) * 25;
					endRowX = initiatorSlot.position * 25;
					initiatorRail = rail;
				} else {
					rail.x = 0;
					endRowX = -25;
					rails.push(rail);
				}
				
				// Формируем передвигаемые ячейки для того же ряда
				railItems = [] 
				for (var i:int = 0; i < targetRow.numChildren; i ++) {
					var slot:FieldDeckSlot = targetRow.getChildAt(i) as FieldDeckSlot;
					if (slot.x < initiatorSlot.x) {
						if (sameRowFlag) {
							if (slot.position > initiatorSlot.position) {
								railItems.push(slot);
							} else {
								continue;
							}
						} else {
							railItems.push(slot);
						}
						
					}
				}
				targetRow.addChild(rail);
	
				for (i = 0; i < railItems.length; i ++) {
					rail.addChild(railItems[i]);
					railItems[i].x = 25 * rail.numChildren;
				}
				rail.addChild(targetSlot);
				targetSlot.x = 25 * rail.numChildren;
				
				animationCof = 1;
				TweenLite.to (rail, 0.5, { x:endRowX, ease:Expo.easeOut, onComplete:onAnimComplete } );
				
				// Если ячейка из более верхнего ряда также обрабатываем другие ряды
				if (!sameRowFlag) {
					// уточняем позицию своего ряда
					// уточняем позицию предыдущего ряда
					var rowPosition:int = targetRow.position - 1;
					var previousRow:FieldDeckRow = widget.getRow(rowPosition);
					// если ячейка из этого ряда то обрабатываем ряд с дыркой
					if (previousRow.position == initiatorRow.position) {
						initiatorRail = tweenInitiatorRail(previousRow, rail);
					}
					// если нет то обрабатываем как ряд без дырки, 
					else {
						
						downRail = tweenRail(previousRow, rail);
						rails.push(downRail);
						// поднимаемся еще на один ряд выше и повторяем опирацию
						rowPosition = previousRow.position - 1;
						previousRow = widget.getRow(rowPosition);
						if (previousRow.position == initiatorRow.position) {
							initiatorRail = tweenInitiatorRail(previousRow, downRail);
						} else {
							downRail = tweenRail(previousRow, downRail);
							rails.push(downRail);
							rowPosition = previousRow.position - 1;
							previousRow = widget.getRow(rowPosition);
							initiatorRail = tweenInitiatorRail(previousRow, downRail);
						}
						
					}
					
				} 
				
				
			
			} else {
				// сразу же ставим перетаскиваемую ячейку на новую позицию в ряд. 
				initiatorSlot.x = targetSlot.x;
				initiatorSlot.y = targetSlot.y;
								
				// Обрабатываем ряд в который добавляется перетаскиваемая ячейка
				rail = new Sprite ();
				rail.x = (targetSlot.position + 1) * 25;
				endRowX = (targetSlot.position + 2) * 25;
				if (sameRowFlag) {
					initiatorRail = rail;
				} else {
					rails.push(rail);
				}
								
				// Формируем передвигаемые ячейки для того же ряда
				railItems = [] 
				for (i = 0; i < targetRow.numChildren; i ++) {
					slot = targetRow.getChildAt(i) as FieldDeckSlot;
					if (slot.position >= targetSlot.position) {
						if (sameRowFlag) {
							if (slot.position < initiatorSlot.position) {
								railItems.push(slot);
							} else {
								continue;
							}
						} else {
							railItems.push(slot);
						}
						
					}
				}
				targetRow.addChild(initiatorSlot);
				targetRow.addChild(rail);
	
				for (i = 0; i < railItems.length; i ++) {
					railItems[i].x = 25 * rail.numChildren;
					rail.addChild(railItems[i]);
				}
			
				animationCof = 1;
				TweenLite.to (rail, 0.5, { x:endRowX, ease:Expo.easeOut, onComplete:onInverseAnimComplete } );
				
				if (!sameRowFlag) {
					rowPosition = targetRow.position + 1;
					var nextRow:FieldDeckRow = widget.getRow(rowPosition);
					if (nextRow.position == initiatorRow.position) {
						initiatorRail = tweenInverseInitiatorRail(nextRow, rail);
					} else {
						downRail = inverseTweenRail(nextRow, rail);
						rails.push(downRail);
						rowPosition = nextRow.position + 1;
						nextRow = widget.getRow(rowPosition);
						if (nextRow.position == initiatorRow.position) {
							initiatorRail = tweenInverseInitiatorRail(nextRow, downRail);
						} else {
							downRail = inverseTweenRail(nextRow, downRail);
							rails.push(downRail);
							rowPosition = nextRow.position + 1;
							nextRow = widget.getRow(rowPosition);
							initiatorRail = tweenInverseInitiatorRail(nextRow, downRail);
						}
					}
				}
				
			}
		}
		
		private function tweenInverseInitiatorRail(nextRow:FieldDeckRow, upRail:Sprite):Sprite {
			var nextRail:Sprite = new Sprite();
			railItems = []
			var downSlot:FieldDeckSlot = upRail.getChildAt(upRail.numChildren - 1) as FieldDeckSlot;
			downSlot = downSlot.clone()
			railItems.push(downSlot);
			for (var i:int = 0; i < nextRow.numChildren; i ++) {
				var slot:FieldDeckSlot = nextRow.getChildAt(i) as FieldDeckSlot;
				if (slot.position < initiatorSlot.position) {
					railItems.push(slot);
				}
			}
			for (i = 0; i < railItems.length; i ++) {
				nextRail.addChild(railItems[i]);
				railItems[i].x = 25 * nextRail.numChildren;
			}
			nextRail.x = -25;
			nextRow.addChild(nextRail);
			animationCof ++;			
			TweenLite.to (nextRail, 0.5, { x: 0, ease:Expo.easeOut, onComplete:onInverseAnimComplete } );
			return nextRail;
			
		}
		
		private function inverseTweenRail (nextRow:FieldDeckRow, upRail:Sprite) :Sprite {
			var nextRail:Sprite = new Sprite();
			railItems = []
			var downSlot:FieldDeckSlot = upRail.getChildAt(upRail.numChildren - 1) as FieldDeckSlot;
			downSlot = downSlot.clone()
			railItems.push(downSlot);
			for (var i:int = 0; i < nextRow.numChildren; i ++) {
				var slot:FieldDeckSlot = nextRow.getChildAt(i) as FieldDeckSlot;
				railItems.push(slot);
			}
			for (i = 0; i < railItems.length; i ++) {
				nextRail.addChild(railItems[i]);
				railItems[i].x = 25 * nextRail.numChildren;
			}
						
			nextRail.x = -25;
			nextRow.addChild(nextRail);
			animationCof ++;			
			TweenLite.to (nextRail, 0.5, { x: 0, ease:Expo.easeOut, onComplete:onInverseAnimComplete } );
			return nextRail;
		}
		
		private function tweenInitiatorRail (previousRow:FieldDeckRow, downRail:Sprite) :Sprite {
			var previousRail:Sprite = new Sprite();
			railItems = []
			for (var i:int = 0; i < previousRow.numChildren; i ++) {
				var slot:FieldDeckSlot = previousRow.getChildAt(i) as FieldDeckSlot;
				if (slot.position > initiatorSlot.position) {
					railItems.push(slot);
				}
			}
			for (i = 0; i < railItems.length; i ++) {
				previousRail.addChild(railItems[i]);
				railItems[i].x = 25 * previousRail.numChildren;
			}
			previousRail.x = (initiatorSlot.position + 1) * 25;
			previousRow.addChild(previousRail);
			var upSlot:FieldDeckSlot = downRail.getChildAt(0) as FieldDeckSlot;
			upSlot = upSlot.clone()
			previousRail.addChild(upSlot);
			upSlot.x = previousRail.numChildren * 25;
			animationCof ++;
			TweenLite.to (previousRail, 0.5, { x:previousRail.x - 25, ease:Expo.easeOut, onComplete:onAnimComplete } );
			return previousRail;
		}
		
		private function tweenRail (previousRow:FieldDeckRow, downRail:Sprite) :Sprite {
			var previousRail:Sprite = new Sprite();
			railItems = []
			for (var i:int = 0; i < previousRow.numChildren; i ++) {
				var slot:FieldDeckSlot = previousRow.getChildAt(i) as FieldDeckSlot;
				railItems.push(slot);
			}
			for (i = 0; i < railItems.length; i ++) {
				previousRail.addChild(railItems[i]);
				railItems[i].x = 25 * previousRail.numChildren;
			}
						
			previousRail.x = 0;
			previousRow.addChild(previousRail);
			var upSlot:FieldDeckSlot = downRail.getChildAt(0) as FieldDeckSlot;
			upSlot = upSlot.clone()
			previousRail.addChild(upSlot);
			upSlot.x = previousRail.numChildren * 25;
			animationCof ++;			
			TweenLite.to (previousRail, 0.5, { x: - 25, ease:Expo.easeOut, onComplete:onAnimComplete } );
			return previousRail;
		}
		
		private function onAnimComplete () :void {
			animationCof --;
			if (!animationCof) {
				initiatorSlot.visible = true;
				var slots:Array;
				var clearFlag:Boolean;
				var rail:Sprite;
				var row:FieldDeckRow ;
				for (var i:int = 0; i < rails.length; i++) {
					clearFlag = true;
					rail = rails[i];
					rail.removeChildAt(0);
					row = rail.parent as FieldDeckRow;
					row.removeChild(rail);
					console.debug(row.position.toString());
					slots = [];
					if (rail.numChildren == 8) {
						for (var j:int = 0; j < rail.numChildren; j ++) {
							var slot:FieldDeckSlot = rail.getChildAt(j) as FieldDeckSlot;
							slots.push(slot);
						}
						for (j = 0; j < slots.length; j ++) {
							slot = slots[j];
							if (clearFlag) {
								row.clear();
								clearFlag = false;
							}
							row.addItem(slot);
						}
					} else {
						for (j = 0; j < rail.numChildren; j ++) {
							slot = rail.getChildAt(j) as FieldDeckSlot;
							slots.push(slot);
						}
						for (j = 0; j < row.numChildren; j ++) {
							slot = row.getChildAt(j) as FieldDeckSlot;
							slots.push(slot);
						}
						for (j = 0; j < slots.length; j ++) {
							slot = slots[j];
							if (clearFlag) {
								row.clear();
								clearFlag = false;
							}
							row.addItem(slot);
						}
					}
				}
				
				// обрабатываем ряд инициатора
				row = initiatorRail.parent as FieldDeckRow;
				row.removeChild(initiatorRail);
				clearFlag = true;
				slots = [];
				if (sameRowFlag) {
					for (j = 0; j < row.numChildren; j ++) {
						slot = row.getChildAt(j) as FieldDeckSlot;
						if (slot.position < initiatorSlot.position) {
							slots.push(slot);
						}
					}
					for (j = 0; j < initiatorRail.numChildren; j ++) {
						slot =  initiatorRail.getChildAt(j) as FieldDeckSlot;
						slots.push(slot);
					}
					slots.push(initiatorSlot);
					for (j = 0; j < row.numChildren; j ++) {
						slot = row.getChildAt(j) as FieldDeckSlot;
						if (slot.position > targetSlot.position) {
							slots.push(slot);
						}
					}
				} else {
					for (j = 0; j < row.numChildren; j ++) {
						slot = row.getChildAt(j) as FieldDeckSlot;
						slots.push(slot);
					}
					for (j = 0; j < initiatorRail.numChildren; j ++) {
						slot =  initiatorRail.getChildAt(j) as FieldDeckSlot;
						slots.push(slot);
					}
				}
				
				for (j = 0; j < slots.length; j ++) {
					slot = slots[j];
					if (clearFlag) {
						row.clear();
						clearFlag = false;
					}
						row.addItem(slot);
				}
								
				// реиндексируем слоты
				widget.reindexSlots();
				// done!!
			}
		}
		
		private function onInverseAnimComplete () :void {
			animationCof --;
			if (!animationCof) {
				initiatorSlot.visible = true;
				
				var slots:Array;
				var clearFlag:Boolean;
				var rail:Sprite;
				var row:FieldDeckRow ;
				for (var i:int = 0; i < rails.length; i++) {
					clearFlag = true;
					rail = rails[i];
					rail.removeChildAt(rail.numChildren - 1);
					row = rail.parent as FieldDeckRow;
					row.removeChild(rail);
					//console.debug(row.position.toString());
					slots = [];
					
					if (rail.numChildren == 8) {
						for (var j:int = 0; j < rail.numChildren; j ++) {
							var slot:FieldDeckSlot = rail.getChildAt(j) as FieldDeckSlot;
							slots.push(slot);
						}
						for (j = 0; j < slots.length; j ++) {
							slot = slots[j];
							if (clearFlag) {
								row.clear();
								clearFlag = false;
							}
							row.addItem(slot);
						}
					} else {
						
						for (j = 0; j < row.numChildren; j ++) {
							slot = row.getChildAt(j) as FieldDeckSlot;
							slots.push(slot);
						}
						for (j = 0; j < rail.numChildren; j ++) {
							slot = rail.getChildAt(j) as FieldDeckSlot;
							slots.push(slot);
						}
						
						for (j = 0; j < slots.length; j ++) {
							slot = slots[j];
							if (clearFlag) {
								row.clear();
								clearFlag = false;
							}
							row.addItem(slot);
					
						}
					}
					
				}
				
				
				// обрабатываем ряд инициатора
				row = initiatorRail.parent as FieldDeckRow;
				row.removeChild(initiatorRail);
				clearFlag = true;
				slots = [];
				if (sameRowFlag) {
					for (j = 0; j < row.numChildren; j ++) {
						slot = row.getChildAt(j) as FieldDeckSlot;
						if (slot.position < targetSlot.position) {
							slots.push(slot);
						}
					}
					slots.push(initiatorSlot);
					for (j = 0; j < initiatorRail.numChildren; j ++) {
						slot =  initiatorRail.getChildAt(j) as FieldDeckSlot;
						slots.push(slot);
					}
					for (j = 0; j < row.numChildren; j ++) {
						slot = row.getChildAt(j) as FieldDeckSlot;
						if (slot.position > initiatorSlot.position) {
							slots.push(slot);
						}
					}
					
				} else {
					for (j = 0; j < initiatorRail.numChildren; j ++) {
						slot =  initiatorRail.getChildAt(j) as FieldDeckSlot;
						slots.push(slot);
					}
					for (j = 0; j < row.numChildren; j ++) {
						slot = row.getChildAt(j) as FieldDeckSlot;
						slots.push(slot);
					}
				}
				
				
				for (j = 0; j < slots.length; j ++) {
					slot = slots[j];
					if (clearFlag) {
						row.clear();
						clearFlag = false;
					}
						row.addItem(slot);
				}
								
				// реиндексируем слоты
				widget.reindexSlots();
				// done!!
				
			}
		}
	}

}