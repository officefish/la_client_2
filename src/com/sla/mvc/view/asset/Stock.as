package com.sla.mvc.view.asset 
{
	import com.transform.Transform;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Stock 
	{
		
		[Embed(source = "../../../../../../lib/assets/cards/default.png")]
		private static var DefaultAsset:Class;
		
		[Embed(source = "../../../../../../lib/assets/cards/robots/alonso1.jpg")]
		private static var Robot1:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/fidel.png")]
		private static var Robot2:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/polino.png")]
		private static var Robot3:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/alvaro.png")]
		private static var Robot4:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/gonzalo.png")]
		private static var Robot5:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/horacio.png")]
		private static var Robot6:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/ernando.png")]
		private static var Robot7:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/goito.png")]
		private static var Robot8:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/efrain.png")]
		private static var Robot9:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/gervacio.png")]
		private static var Robot10:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/ernesto2.png")]
		private static var Robot11:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/leonseo.png")]
		private static var Robot12:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/djacobo.png")]
		private static var Robot13:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/apolinar.png")]
		private static var Robot14:Class;
		[Embed(source="../../../../../../lib/assets/cards/robots/maximiliano.png")]
		private static var Robot15:Class;
		
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/victoria.png")]
		private static var Cyborg1:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/francisko.png")]
		private static var Cyborg2:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/hoakin.png")]
		private static var Cyborg3:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/fronte2.png")]
		private static var Cyborg4:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/huan.png")]
		private static var Cyborg5:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/grenada.png")]
		private static var Cyborg6:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/placa.png")]
		private static var Cyborg7:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/hesus.png")]
		private static var Cyborg8:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/daniel.png")]
		private static var Cyborg9:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/hose.png")]
		private static var Cyborg10:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/mauricio.png")]
		private static var Cyborg11:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/ernesto.png")]
		private static var Cyborg12:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/luxas.png")]
		private static var Cyborg13:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/angela.png")]
		private static var Cyborg14:Class;
		[Embed(source="../../../../../../lib/assets/cards/cyborgs/ramon.png")]
		private static var Cyborg15:Class;
		
		[Embed(source="../../../../../../lib/assets/cards/mutants/orlando.png")]
		private static var Mutant1:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/verterder.png")]
		private static var Mutant2:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/Gonzo.jpg")]
		private static var Mutant3:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/milla.jpg")]
		private static var Mutant4:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/vistoze.jpg")]
		private static var Mutant5:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/arapaima.png")]
		private static var Mutant6:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/porku.png")]
		private static var Mutant7:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/supresa.png")]
		private static var Mutant8:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/spyu.png")]
		private static var Mutant9:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/setticoid.png")]
		private static var Mutant10:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/tersipello.png")]
		private static var Mutant11:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/colpitos.png")]
		private static var Mutant12:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/odin.png")]
		private static var Mutant13:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/cornudo.png")]
		private static var Mutant14:Class;
		[Embed(source="../../../../../../lib/assets/cards/mutants/humo.png")]
		private static var Mutant15:Class;
		
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar1.png")]
		private static var Delovar1:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar2.png")]
		private static var Delovar2:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar3.png")]
		private static var Delovar3:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar4.png")]
		private static var Delovar4:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar5.png")]
		private static var Delovar5:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar6.png")]
		private static var Delovar6:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar7.png")]
		private static var Delovar7:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar8.png")]
		private static var Delovar8:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar9.png")]
		private static var Delovar9:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar10.png")]
		private static var Delovar10:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar11.png")]
		private static var Delovar11:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar12.png")]
		private static var Delovar12:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar13.png")]
		private static var Delovar13:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar14.png")]
		private static var Delovar14:Class;
		[Embed(source="../../../../../../lib/assets/cards/delovars/delovar15.png")]
		private static var Delovar15:Class;
		
	
		
		private static var AssetsTexture:Dictionary = new Dictionary();
		private static var MirrorAssetsTexture:Dictionary = new Dictionary();
		private static var MinionAssetsTexture:Dictionary = new Dictionary();
		
		private static function getBitmap (id:int) :Bitmap {
			var bitmap:Bitmap;
			
			if (id == 10) {
				bitmap = new Bitmap();
			}
			
			// cyborgs
			if (id == 547) {
				bitmap = new Cyborg1();
			}
			if (id == 548) {
				bitmap = new Cyborg2();
			}
			if (id == 549) {
				bitmap = new Cyborg3();
			}
			if (id == 550) {
				bitmap = new Cyborg4();
			}
			if (id == 551) {
				bitmap = new Cyborg5();
			}
			if (id == 552) {
				bitmap = new Cyborg6();
			}
			if (id == 553) {
				bitmap = new Cyborg7();
			}
			if (id == 554) {
				bitmap = new Cyborg8();
			}
			if (id == 555) {
				bitmap = new Cyborg9();
			}
			if (id == 556) {
				bitmap = new Cyborg10();
			}
			if (id == 557) {
				bitmap = new Cyborg11();
			}
			if (id == 558) {
				bitmap = new Cyborg12();
			}
			if (id == 559) {
				bitmap = new Cyborg13();
			}
			if (id == 560) {
				bitmap = new Cyborg14();
			}
			if (id == 561) {
				bitmap = new Cyborg15();
			}
			
			// mutants
			if (id == 562) {
				bitmap = new Mutant1();
			}
			if (id == 563) {
				bitmap = new Mutant2();
			}
			if (id == 564) {
				bitmap = new Mutant3();
			}
			if (id == 565) {
				bitmap = new Mutant4();
			}
			if (id == 566) {
				bitmap = new Mutant5();
			}
			if (id == 567) {
				bitmap = new Mutant6();
			}
			if (id == 568) {
				bitmap = new Mutant7();
			}
			if (id == 569) {
				bitmap = new Mutant8();
			}
			if (id == 570) {
				bitmap = new Mutant9();
			}
			if (id == 571) {
				bitmap = new Mutant10();
			}
			if (id == 572) {
				bitmap = new Mutant11();
			}
			if (id == 573) {
				bitmap = new Mutant12();
			}
			if (id == 574) {
				bitmap = new Mutant13();
			}
			if (id == 575) {
				bitmap = new Mutant14();
			}
			if (id == 576) {
				bitmap = new Mutant15();
			}
			
			// robots
			if (id == 577) {
				bitmap = new Robot1();
			}
			if (id == 578) {
				bitmap = new Robot2();
			}
			if (id == 579) {
				bitmap = new Robot3();
			}
			if (id == 580) {
				bitmap = new Robot4();
			}
			if (id == 581) {
				bitmap = new Robot5();
			}
			if (id == 582) {
				bitmap = new Robot6();
			}
			if (id == 583) {
				bitmap = new Robot7();
			}
			if (id == 584) {
				bitmap = new Robot8();
			}
			if (id == 585) {
				bitmap = new Robot9();
			}
			if (id == 586) {
				bitmap = new Robot10();
			}
			if (id == 587) {
				bitmap = new Robot11();
			}
			if (id == 588) {
				bitmap = new Robot12();
			}
			if (id == 589) {
				bitmap = new Robot13();
			}
			if (id == 590) {
				bitmap = new Robot14();
			}
			if (id == 591) {
				bitmap = new Robot15();
			}
			
			// delovars
			if (id == 593) {
				bitmap = new Delovar1();
			}
			if (id == 594) {
				bitmap = new Delovar2();
			}
			if (id == 595) {
				bitmap = new Delovar3();
			}
			if (id == 596) {
				bitmap = new Delovar4();
			}
			if (id == 597) {
				bitmap = new Delovar5();
			}
			if (id == 598) {
				bitmap = new Delovar6();
			}
			if (id == 599) {
				bitmap = new Delovar7();
			}
			if (id == 600) {
				bitmap = new Delovar8();
			}
			if (id == 601) {
				bitmap = new Delovar9();
			}
			if (id == 602) {
				bitmap = new Delovar10();
			}
			if (id == 603) {
				bitmap = new Delovar11();
			}
			if (id == 604) {
				bitmap = new Delovar12();
			}
			if (id == 605) {
				bitmap = new Delovar13();
			}
			if (id == 606) {
				bitmap = new Delovar14();
			}
			if (id == 607) {
				bitmap = new Delovar15();
			}
			
			
			
			
			return bitmap;
		}
		
		private static var _defaultTexture:Texture;
		private static var _defaultMirrorTexture:Texture;
		private static var _defaultMinionTexture:Texture;
		private static function get defaultTexture () :Texture {
			if (!_defaultTexture) {
				var bitmap:Bitmap = new DefaultAsset();
				bitmap = Transform.scale(bitmap, 0.65);
				_defaultTexture	= Texture.fromBitmap(bitmap); 
			}
			return _defaultTexture;
		}
		private static function get defaultMinionTexture () :Texture {
			if (!_defaultMinionTexture) {
				var bitmap:Bitmap = new DefaultAsset();
				bitmap = Transform.scale(bitmap, 0.77);
				_defaultMinionTexture	= Texture.fromBitmap(bitmap); 
			}
			return _defaultMinionTexture;
		}
		private static function get defaultMirrorTexture () :Texture {
			if (!_defaultMirrorTexture) {
				var bitmap:Bitmap = new DefaultAsset();
				_defaultMirrorTexture	= Texture.fromBitmap(bitmap); 
			}
			return _defaultMirrorTexture;
		}
		
		
		public static function getTexture(id:int) :Texture {
			if (AssetsTexture[id]) {
				return AssetsTexture[id]
			} else {
				var bitmap:Bitmap = getBitmap(id);
				if (bitmap) {
					MirrorAssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = Transform.scale(bitmap, 0.65);
					AssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = getBitmap(id);
					bitmap = Transform.scale(bitmap, 0.77);
					MinionAssetsTexture[id] = Texture.fromBitmap(bitmap);
					return AssetsTexture[id];
				}
				return defaultTexture;	
			}
			
			
		}
		
		public static function getMirrorTextrure(id:int) :Texture {
			if (MirrorAssetsTexture[id]) {
				return MirrorAssetsTexture[id]
			} else {
				var bitmap:Bitmap = getBitmap(id);
				if (bitmap) {
					MirrorAssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = Transform.scale(bitmap, 0.65);
					AssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = getBitmap(id);
					bitmap = Transform.scale(bitmap, 0.77);
					MinionAssetsTexture[id] = Texture.fromBitmap(bitmap);
					return MirrorAssetsTexture[id];
				}
				return defaultMirrorTexture;	
			}
		}
		
		public static function getMinionTextrure(id:int) :Texture {
			if (MinionAssetsTexture[id]) {
				return MinionAssetsTexture[id]
			} else {
				var bitmap:Bitmap = getBitmap(id);
				if (bitmap) {
					MirrorAssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = Transform.scale(bitmap, 0.65);
					AssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = getBitmap(id);
					bitmap = Transform.scale(bitmap, 0.77);
					MinionAssetsTexture[id] = Texture.fromBitmap(bitmap);
					return MinionAssetsTexture[id];
				}
				return defaultMinionTexture;	
			}
		}
		
 		
	}

}