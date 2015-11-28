package com.sla.mvc.service 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.data.AbilityData;
	import com.sla.mvc.model.data.BookData;
	import com.sla.mvc.model.data.CollectionCardData;
	import com.sla.mvc.model.data.DeckData;
	import com.sla.mvc.model.data.HeroData;
	import org.robotlegs.mvcs.Actor;
	//import com.adobe.serialization.json.JSON;
	/*
	import com.la.event.ApiServiceEvent;
	import com.la.mvc.model.AchieveData;
	import com.la.mvc.model.BookData;
	import com.la.mvc.model.CollectionCardData;
	import com.la.mvc.model.DeckData;
	import com.la.mvc.model.HeroData;
	import flash.sampler.DeleteObjectSample;
	
	import com.greensock.loading.DataLoader;
	import com.greensock.events.LoaderEvent;
	import com.adobe.serialization.json.JSON;
	*/

	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ApiService extends Actor
	{
		private var _host:String;
		private var _port:int;
		private var _userId:int;
		
		public function set host (value:String) :void {
			_host = value;	
		}
		
		public function get host () :String {
			return _host;
		}
		
		public function set port (value:int) :void {
			_port = value;
		}
		
		public function set userId (value:int) :void {
			_userId = value;
		}
		
		private final function get url () :String {
			return "http://" + _host + ':' + _port + '/api/';	
		}
		
		public function ApiService() 
		{
			
		}
		
		// request
		public function requestDeckList () :void {
			
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST))
			
			var methodUrl:String = url + "get_deck_list/?user_id=" + _userId; 
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteDeckList, onError:errorHandler});
			loader.load();
		}
		
		public function requestDeckReadyToLobby (deckId:int, heroId:int) :void {
			var methodUrl:String = url + 'select_deck/?user_id=' + _userId + '&deck_id=' + deckId + '&hero_id=' + heroId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteIntroSelectDeck, onError:errorHandler});
			loader.load();
		}
		
		public function requestCollection (userId:int) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST))
			var methodUrl:String = url + 'get_collection/?user_id=' + userId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:completeRequestCollection, onError:errorHandler});
			loader.load();
		}
		
		public function requestEditDeck (userId:int, deckId:int) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST));
			var methodUrl:String = url + 'edit_deck/?user_id=' + userId + '&deck_id=' + deckId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteEditDeck, onError:errorHandler});
			loader.load();
		}
		
		public function requestSaveDeck (userId:int, deckId:int, deckTitle:String, items:Array) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST));
			var data:Object = { }
			data['deckId'] = deckId;
			data['deckTitle'] = deckTitle;
			data['items'] = items;
	        var params:String = JSON.stringify (data);
			var methodUrl:String = url + 'save_deck/?user_id=' + userId + '&data=' + params;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteSaveDeck, onError:errorHandler});
			loader.load();
			
		}
		
		public function requestRemoveDeck (userId:int, deckId:int) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST));
			var methodUrl:String = url + 'remove_deck/?user_id=' + userId + '&deck_id=' + deckId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteRemoveDeck, onError:errorHandler});
			loader.load();
		}
		
		public function requestHeroes (userId:int) :void {
			var methodUrl:String = url + 'get_heroes/?user_id=' + userId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:completeRequestHeroes, onError:errorHandler});
			loader.load();
		}
		
		public function requestNewDeck (userId:int, heroId:int) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST));
			var methodUrl:String = url + 'create_deck/?user_id=' + userId +'&hero_id=' + heroId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:completeCreateDeck, onError:errorHandler});
			loader.load();
		}
		public function requestFullCollection (userId:int) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST));
			var methodUrl:String = url + 'get_full_collection/?user_id=' + userId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteFullCollection, onError:errorHandler});
			loader.load()
		}
		
		public function requestCraftCard (userId:int, cardId:int, goldenFlag:Boolean) :void {
			var golden:int = 0
			if (goldenFlag) {
				golden = 1;
			}
			var methodUrl:String = url + 'craft_card/?user_id=' + userId + '&card_id=' + cardId + '&golden=' + golden;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteCraftCard, onError:errorHandler});
			loader.load()
		}
		
		public function requestDestroyCard(userId:int, cardId:int, goldenFlag:Boolean) :void {
			var golden:int = 0
			if (goldenFlag) {
				golden = 1;
			}
			var methodUrl:String = url + 'destroy_card/?user_id=' + userId + '&card_id=' + cardId + '&golden=' + golden;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteDestroyCard, onError:errorHandler});
			loader.load()
		}
		
		public function editAbilities (userId:int, heroId:int) :void {
			var methodUrl:String = url + 'achieves_list/?user_id=' + userId + '&hero_id=' + heroId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteAchievesList, onError:errorHandler});
			loader.load()
		}
		
		public function requestSaveAbilities (userId:int, heroId:int, setup:Array) :void {
			var data:Object = {}
			data['setup'] = setup
			var params:String = JSON.stringify (data);
			var methodUrl:String = url + 'setup_achieves/?user_id=' + userId + '&hero_id=' + heroId + '&data=' + params;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteSetupAchieves, onError:errorHandler});
			loader.load();
		}
		
		public function requestCraftAbilities (userId:int, heroId:int) :void {
			var methodUrl:String = url + 'craft_achieves_list/?user_id=' + userId + '&hero_id=' + heroId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteCraftAchievesList, onError:errorHandler});
			loader.load();
		}
		public function craftAbility (userId:int, heroId:int, achieveId:int) :void {
			var methodUrl:String = url + 'craft_achieve/?user_id=' + userId + '&hero_id=' + heroId + '&achieve_id=' + achieveId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteCraftAbility, onError:errorHandler});
			loader.load();
		}
		
		public function dustAbility(userId:int, heroId:int, achieveId:int) :void {
			var methodUrl:String = url + 'destroy_achieve/?user_id=' + userId + '&hero_id=' + heroId + '&achieve_id=' + achieveId;
			var loader:DataLoader = new DataLoader(methodUrl, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteDestroyAchieve, onError:errorHandler});
			loader.load();
		}
			
				
		// response
		public function onCompleteDestroyAchieve (event:LoaderEvent) :void {
			var response:Object = JSON.parse(event.target.content);
			if (response.status == 'success') {
				var serviceData:Object = {}
				serviceData['achieveId'] = response.achieve_id;
				serviceData['dust'] = response.dust
				serviceData['count'] = response.count
				dispatch (new ApiServiceEvent (ApiServiceEvent.COMPLETE_DUST_ABILITY, serviceData));

			} else if (response.status == 'error') {
				trace ('Error:' + response.message); 
			}
			
		}
		
		public function onCompleteCraftAbility (event:LoaderEvent) :void {
			MonsterDebugger.log('onCompleteCraftAbility')
			var response:Object = JSON.parse(event.target.content);
			if (response.status == 'success') {
				var serviceData:Object = {}
				serviceData['abilityId'] = response.achieve_id;
				serviceData['dust'] = response.dust;
				serviceData['count'] = response.count;
				dispatch (new ApiServiceEvent (ApiServiceEvent.COMPLETE_CRAFT_ABILITY, serviceData));

			} else if (response.status == 'error') {
				MonsterDebugger.log ('Error:' + response.message); 
			}
			
		}
		
		
		
		private function onCompleteCraftAchievesList(event:LoaderEvent) :void {
			var response:Object = JSON.parse(event.target.content);
			var serviceData:Object = { }
			serviceData['abilities'] = getAbilitiesData (response.achieves);
			serviceData['dust'] = response.dust
			if (response.status == 'success') {
				//MonsterDebugger.log('onCompleteCraftAbilitiesList');
				dispatch (new ApiServiceEvent (ApiServiceEvent.ABILITIES_CRAFT_LIST_INIT, serviceData));
			}
		}
		
		private function onCompleteSetupAchieves(event:LoaderEvent) :void {
			dispatch (new ApiServiceEvent (ApiServiceEvent.SETUP_ABILITIES, null));
		}
		
		public function onCompleteAchievesList (event:LoaderEvent) :void {
			
			var response:Object = JSON.parse(event.target.content);
			var serviceData:Object = { }
			serviceData['achieves'] = getAbilitiesData (response.achieves);
			serviceData['heroId'] = response.hero_id;
			serviceData['heroVocation'] = response.hero_vocation;
			serviceData['setup'] = response.setup;
			if (response.status == 'success') {
				dispatch (new ApiServiceEvent (ApiServiceEvent.ABILITIES_LIST_INIT, serviceData));
			}
			
		}
		
		private function onCompleteDestroyCard (event:LoaderEvent) :void {
			var response:Object = JSON.parse(event.target.content);
			var serviceData:Object = { }
			serviceData['count'] = response.count;
			serviceData['dust'] = response.dust;
			if (response.success) {
				dispatch (new ApiServiceEvent (ApiServiceEvent.CARD_DESTROYED, serviceData));
			}
		}
		
		private function onCompleteCraftCard (event:LoaderEvent) :void {
			var response:Object = JSON.parse(event.target.content);
			var serviceData:Object = { }
			serviceData['count'] = response.count;
			serviceData['dust'] = response.dust;
			if (response.success) {
				dispatch (new ApiServiceEvent (ApiServiceEvent.CARD_CREATED, serviceData));
			}
		}
		
		private function onCompleteFullCollection (event:LoaderEvent) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST_COMPLETE))
			var response:Object =  JSON.parse(event.target.content);
			var serviceData:Object = parseCollection(event.target.content);
			serviceData['dust'] = response.dust;
			dispatch (new ApiServiceEvent (ApiServiceEvent.FULL_COLLECTION_INIT, serviceData));
		}
		private function completeCreateDeck (event:LoaderEvent) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST_COMPLETE))
			var serviceData:Object = parseCollection(event.target.content);
			var response:Object = JSON.parse(event.target.content);
			MonsterDebugger.log(response);
			var responseHeroData:Object = response.hero;
			var responseDeckData:Object = response.deck;
			var heroData:HeroData = getHeroData (responseHeroData);
			var deckData:DeckData = getDeckData (responseDeckData);
			serviceData['hero'] = heroData;
			serviceData['deck'] = deckData;
			dispatch(new ApiServiceEvent(ApiServiceEvent.NEW_DECK_INIT, serviceData));
			
		}
		
		private function completeRequestHeroes (event:LoaderEvent) :void {
			var serviceData:Object = parseHeroes(event.target.content);
            dispatch(new ApiServiceEvent(ApiServiceEvent.HEROES_INIT, serviceData));

		}
		
		private function onCompleteRemoveDeck (event:LoaderEvent) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST_COMPLETE))
			var serviceData:Object = parseCollection(event.target.content);
			var decks:Array = getDecks (event.target.content);
			serviceData['decks'] = decks;
			dispatch(new ApiServiceEvent(ApiServiceEvent.COLLECTION_INIT, serviceData));
		}
		
		
		private function onCompleteSaveDeck (event:LoaderEvent) :void {

			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST_COMPLETE))
			var serviceData:Object = parseCollection(event.target.content);
			var decks:Array = getDecks (event.target.content);
			serviceData['decks'] = decks;
			dispatch(new ApiServiceEvent(ApiServiceEvent.COLLECTION_INIT, serviceData));
		}
		
		
		
		private function onCompleteEditDeck (event:LoaderEvent) :void {

			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST_COMPLETE));
			var serviceData:Object = parseCollection(event.target.content);
			var response:Object = JSON.parse(event.target.content);
			var responseHeroData:Object = response.hero;
			var responseDeckData:Object = response.deck;
			var heroData:HeroData = getHeroData (responseHeroData);
			var deckData:DeckData = getDeckData (responseDeckData);
			serviceData['hero'] = heroData;
			serviceData['deck'] = deckData;
			dispatch(new ApiServiceEvent(ApiServiceEvent.EDIT_DECK_INIT, serviceData));
			
		}
		
		private function completeRequestCollection (event:LoaderEvent) :void {
			MonsterDebugger.log ('completeRequestCollection');
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST_COMPLETE))
			var serviceData:Object = parseCollection(event.target.content);
			var decks:Array = getDecks (event.target.content);
			serviceData['decks'] = decks;
			dispatch(new ApiServiceEvent(ApiServiceEvent.COLLECTION_INIT, serviceData));

		}
		
		
		private function onCompleteDeckList (event:LoaderEvent) :void { 
			
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST_COMPLETE));
			
			var response:Object = JSON.parse(event.target.content);
			//MonsterDebugger.log(response);
			var serviceData:Object = parseDeckList(response);
			serviceData['actualDeck'] = int(response.actual_deck);
			//MonsterDebugger.log(serviceData);

			dispatch (new ApiServiceEvent (ApiServiceEvent.INTRO_DECKLIST_INIT, serviceData));
		}
		
		private function progressHandler(event:LoaderEvent):void { 
			trace("progress: " + event.target.progress);
		}
		private function errorHandler(event:LoaderEvent):void {
			MonsterDebugger.log ("error occured with " + event.target + ": " + event.text);
			trace("error occured with " + event.target + ": " + event.text);
		}
		
		private function onCompleteIntroSelectDeck (event:LoaderEvent) :void {
			var response:Object = JSON.parse(event.target.content);
			var serviceData:Object = { };
			serviceData['hero_id'] = int(response.hero_id);
			serviceData['deck_id'] = int(response.deck_id);
			serviceData['hero_uid'] = int(response.hero_uid);
			serviceData['level'] = int(response.level);
			dispatch (new ApiServiceEvent (ApiServiceEvent.DECK_READY_TO_LOBBY, serviceData));
		}
		
		
		// parser
		private function parseHeroes(responseStr:String) :Object {
	        var response:Object = JSON.parse(responseStr);
			var data:Object = {}
			var responseHeroes:Array = response.heroes as Array;
			var heroes:Array = []
			var heroData:HeroData;
			var responseHeroData:Object;
			for (var i:int = 0; i < responseHeroes.length; i ++) {
				heroData = new HeroData ();
				responseHeroData = responseHeroes[i];
				heroData.title =  responseHeroData.title;
				heroData.vocation =  responseHeroData.vocation;
				heroData.description = responseHeroData.description;
				heroData.uid = int(responseHeroData.uid);
				heroData.id = int (responseHeroData.id);
				heroData.level = int (responseHeroData.level);
				heroes.push (heroData);
			}
			data['heroes'] = heroes;
			return data;
		}
		
		private function parseCollection(responseStr:String) :Object {
	        var response:Object = JSON.parse(responseStr);
			var data:Object = {}
			var responseBooks:Array = response.books as Array;
			var books:Array = []
			
			var bookData:BookData 
			var responseBookData:Object;
			for (var i:int = 0; i < responseBooks.length; i ++) {
				bookData = new BookData ();
				responseBookData = responseBooks[i];
				bookData.setTitle (responseBookData.title)
				bookData.setDescription(responseBookData.description)
				initCollectionItems (responseBookData.cards, bookData);
				books.push (bookData);
			}
			data['books'] = books;
			
			return data;
		}
		
		private function parseDeckList (response:Object) :Object {
	        var responseDecks:Array = response.decks;
			var serviceData:Object = {}
			var deckData:Object;
			var responseDeck:Object;
			var decks:Vector.<DeckData> = new Vector.<DeckData>();
			var length:int = responseDecks.length;
			for (var i:int = 0; i < length; i ++) {
				responseDeck = responseDecks[i];
				deckData = getDeckData (responseDeck);
				decks.push (deckData)
			}
			serviceData['decks'] = decks;
			return serviceData;
		}
		
		private function getAbilitiesData (achieves:Array) :Vector.<AbilityData> {
			var list:Vector.<AbilityData> = new Vector.<AbilityData>();
			var achieveResponseData:Object;
			var achieveData:AbilityData;
			for (var i:int = 0; i < achieves.length; i ++) {
				achieveResponseData = achieves[i];
				achieveData = new AbilityData();
				achieveData.id = achieveResponseData.id;
				achieveData.title = achieveResponseData.title;
				achieveData.description = achieveResponseData.description;
				achieveData.autonomic = achieveResponseData.autonomic;
				achieveData.type = achieveResponseData.type;
				achieveData.price = achieveResponseData.price;
				achieveData.access = achieveResponseData.access;
				achieveData.max_access = achieveResponseData.max_access;
				achieveData.count = achieveResponseData.count;
				achieveData.buyCost = achieveResponseData.buyCost;
				achieveData.saleCost = achieveResponseData.saleCost;
				list.push(achieveData);
			}
			return list;
		}
		
		private function getDeckData (responseDeckData:Object) :DeckData {
			var deckData:DeckData = new DeckData();
			deckData.title =  responseDeckData.title;
			deckData.id = int (responseDeckData.id);
			deckData.complicated = responseDeckData.complicated;
			deckData.count = responseDeckData.cardsCount;
			deckData.uid = responseDeckData.uid;
			if (responseDeckData.items) {
				deckData.items = getDeckItems (responseDeckData.items)
			} else {
				deckData.items = new Vector.<CollectionCardData>(); 
			}
			if (responseDeckData.userHero) {
				deckData.hero = getHeroData (responseDeckData.userHero)
			}
			return deckData;
		}
		
		private function getDeckItems (cards:Array) : Vector.<CollectionCardData> {
			var items:Vector.<CollectionCardData> = new Vector.<CollectionCardData>(); 
			var cardData:Object;
			var item:CollectionCardData;
			for (var i:int = 0; i < cards.length; i ++) {
				cardData = cards[i];
				item = new CollectionCardData (cardData.attack, cardData.health, cardData.price);
				item.type = int(cardData.type)
				if (cardData.race) {
					item.race = cardData.race;
				}
				if (cardData.subrace) {
					item.subrace = cardData.subrace;
				}
				item.title = cardData.title;
				item.description = cardData.description;
				item.setGolden (cardData.golden);
				item.setCount (cardData.count);
				item.id = cardData.id;
				items.push (item)
			}
			return items;
		}
		
		private function getHeroData (responseHeroData:Object) :HeroData {
			var heroData:HeroData = new HeroData(); 
			heroData.title =  responseHeroData.title;
			heroData.vocation =  responseHeroData.vocation;
			heroData.description = responseHeroData.description;
			heroData.uid = int(responseHeroData.uid);
			heroData.id = int (responseHeroData.id);
			heroData.level = int (responseHeroData.level);
			return heroData;
		}
		
		
		/*
		
		
		
		
		
		
		
		
		
		
		public function requestIntroSelectDeck (userId:int, deckId:int, heroId:int) :void {
			var url:String = 'http://127.0.0.1:8000/api/select_deck/?user_id=' + userId + '&deck_id=' + deckId + '&hero_id=' + heroId;
			var loader:DataLoader = new DataLoader(url, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteIntroSelectDeck, onError:errorHandler});
			loader.load();
		}
		
		private function onCompleteIntroSelectDeck (event:LoaderEvent) :void {
			var response:Object = com.adobe.serialization.json.JSON.decode(event.target.content);
			var serviceData:Object = { };
			serviceData['hero_id'] = int(response.hero_id);
			serviceData['deck_id'] = int(response.deck_id);
			serviceData['hero_uid'] = int(response.hero_uid);
			serviceData['level'] = int(response.level);
			dispatch (new ApiServiceEvent (ApiServiceEvent.INTRO_DECK_SELECT, serviceData));
		}
		
		
		
		
		
		public function editDeck (userId:int, deckId:int) :void {
			var url:String = 'http://127.0.0.1:8000/api/edit_deck/?user_id=' + userId + '&deck_id=' + deckId;
			var loader:DataLoader = new DataLoader(url, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteEditDeck, onError:errorHandler});
			loader.load();
		}
		
		private function onCompleteEditDeck (event:LoaderEvent) :void {
			var serviceData:Object = parseCollection(event.target.content);
			var heroData:HeroData = getHeroData (event.target.content);
			var deckData:DeckData = getDeckData (event.target.content);
			serviceData['hero'] = heroData;
			serviceData['deck'] = deckData;
			dispatch(new ApiServiceEvent(ApiServiceEvent.EDIT_DECK_INIT, serviceData));
		}
		
		public function removeDeck (userId:int, deckId:int) :void {
			var url:String = 'http://127.0.0.1:8000/api/remove_deck/?user_id=' + userId + '&deck_id=' + deckId;
			var loader:DataLoader = new DataLoader(url, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteRemoveDeck, onError:errorHandler});
			loader.load();
		}
		
		public function saveDeck (userId:int, deckId:int, deckTitle:String, items:Array) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST, {}))
			var data:Object = { }
			data['deckId'] = deckId;
			data['deckTitle'] = deckTitle;
			data['items'] = items;
	        var params:String = com.adobe.serialization.json.JSON.encode (data);
			
			var url:String = 'http://127.0.0.1:8000/api/save_deck/?user_id=' + userId + '&data=' + params;
			var loader:DataLoader = new DataLoader(url, {'noCache':true, onProgress:progressHandler, onComplete:onCompleteSaveDeck, onError:errorHandler});
			loader.load();
			
		}
		
		
		
	
		
		
		
		public function requestCollection (userId:int) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST, {}))
			var url:String = 'http://127.0.0.1:8000/api/get_collection/?user_id=' + userId;
			var loader:DataLoader = new DataLoader(url, {'noCache':true, onProgress:progressHandler, onComplete:completeRequestCollection, onError:errorHandler});
			loader.load();
		}
		
		public function createDeck (userId:int, heroId:int) :void {
			var url:String = 'http://127.0.0.1:8000/api/create_deck/?user_id=' + userId +'&hero_id=' + heroId;
			var loader:DataLoader = new DataLoader(url, {'noCache':true, onProgress:progressHandler, onComplete:completeCreateDeck, onError:errorHandler});
			loader.load();
		}
		
		private function completeCreateDeck (event:LoaderEvent) :void {
			var serviceData:Object = parseCollection(event.target.content);
			var heroData:HeroData = getHeroData (event.target.content);
			var deckData:DeckData = getDeckData (event.target.content);
			serviceData['hero'] = heroData;
			serviceData['deck'] = deckData;
			dispatch(new ApiServiceEvent(ApiServiceEvent.NEW_DECK_INIT, serviceData));
		}
		
		private function completeRequestCollection (event:LoaderEvent) :void {
			dispatch (new ApiServiceEvent(ApiServiceEvent.REQUEST_COMPLETE, {}))
			var serviceData:Object = parseCollection(event.target.content);
			var decks:Array = getDecks (event.target.content);
			serviceData['decks'] = decks;
			dispatch(new ApiServiceEvent(ApiServiceEvent.COLLECTION_INIT, serviceData));

		}
		
		private function getDeckData (responseStr:String) : DeckData {
			var response:Object = com.adobe.serialization.json.JSON.decode(responseStr);
			var responseDeckData:Object = response.deck;
			return getDeckDataByResponseData(responseDeckData)
		}
		
		
		
		
		
		
		
		private function getHeroData (responseStr:String) :HeroData {
	        var response:Object = com.adobe.serialization.json.JSON.decode(responseStr);
			var responseHeroData:Object = response.hero;
			return (getHeroDataByResponseData(responseHeroData));
		}
		
		
		
		private function parseCollection(responseStr:String) :Object {
	        var response:Object = com.adobe.serialization.json.JSON.decode(responseStr);
			var data:Object = {}
			var responseBooks:Array = response.books as Array;
			var books:Array = []
			var bookData:BookData
			var responseBookData:Object;
			for (var i:int = 0; i < responseBooks.length; i ++) {
				bookData = new BookData ();
				responseBookData = responseBooks[i];
				bookData.setTitle (responseBookData.title)
				bookData.setDescription(responseBookData.description)
				initCollectionItems (responseBookData.cards, bookData);
				books.push (bookData);
			}
			data['books'] = books;
			return data;
		}
		
		*/
		private function getDecks (responseStr:String) : Array {
			var response:Object = JSON.parse(responseStr);
			var responseDecks:Array = response.decks
			var responseDeckData:Object; 
			var deckData:DeckData;
			var decks:Array = []
			for (var i:int = 0; i < responseDecks.length; i ++) {
				responseDeckData = responseDecks[i];
				deckData = new DeckData ();
				deckData.title =  responseDeckData.title;
				deckData.id = int (responseDeckData.id);
				deckData.complicated = responseDeckData.complicated;
				deckData.count = responseDeckData.count;
				deckData.uid = responseDeckData.uid;
				decks.push (deckData);
			}
			return decks;
		}
		private function initCollectionItems (cards:Array, data:BookData) :void {
			var cardData:Object;
			var item:CollectionCardData;
			for (var i:int = 0; i < cards.length; i ++) {
				cardData = cards[i];
				item = new CollectionCardData (cardData.attack, cardData.health, cardData.price);
				item.type = (int(cardData.type))
				if (cardData.race) {
					item.race = (cardData.race)
				}
				if (cardData.subrace) {
					item.subrace = (cardData.subrace)
				}
				item.title = (cardData.title);
				item.description = (cardData.description);
				item.setGolden (cardData.golden);
				item.setCount (cardData.count);
				item.setId (cardData.id)
				
				// craft variables
				
				if (cardData.buy_cost) {
					item.setBuyCost (cardData.buy_cost); 
				}
				if (cardData.sale_cost) {
					item.setSaleCost (cardData.sale_cost); 
				}
				if (cardData.rarity) {
					item.setRarity (cardData.rarity); 
				}
				if (cardData.access_simple) {
					item.setAccessSimple (cardData.access_simple); 
				}
				if (cardData.max_simple) {
					item.setMaxSimple (cardData.max_simple); 
				}
				if (cardData.access_golden) {
					item.setAccessGolden (cardData.access_golden); 
				}
				if (cardData.max_golden) {
					item.setMaxGolden (cardData.max_golden); 
				}
				if (cardData.craft_available) {
					
					item.setCraftAvailable (cardData.craft_available); 
				}
				if (cardData.simple_count) {
					item.setSimpleCount (cardData.simple_count); 
					item.setGolden (false);
				}
				if (cardData.golden_count) {
					item.setGoldenCount (cardData.golden_count); 
					item.setGolden (true);
				}
				
				//MonsterDebugger.log (cardData.title + ':' + cardData.simple_count + ',' + cardData.golden_count);
				data.addItem (item);
			}
			
		}
		
	}
}