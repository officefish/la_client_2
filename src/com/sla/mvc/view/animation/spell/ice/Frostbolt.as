package com.sla.mvc.view.animation.spell.ice 
{
	import com.greensock.easing.Expo;
	import com.greensock.easing.Power0;
	import com.greensock.TimelineMax;
	import com.sla.mvc.view.animation.ITargetInitiatorAnimation;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Frostbolt implements ITargetInitiatorAnimation
	{
		
		// *fbca = frostbolt concentration asset 
		
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset1.png")]
		public var fbca1:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset2.png")]
		public var fbca2:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset3.png")]
		public var fbca3:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset4.png")]
		public var fbca4:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset5.png")]
		public var fbca5:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset6.png")]
		public var fbca6:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset7.png")]
		public var fbca7:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset8.png")]
		public var fbca8:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/concentration/concentrationAsset9.png")]
		public var fbca9:Class;
				
		// particles
		
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/frostboltParticle.pex", mimeType="application/octet-stream")]
		public var FrostboltConfig:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/frostboltRingParticle.pex", mimeType="application/octet-stream")]
		public var RingConfig:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/frostboltTailParticle.pex", mimeType="application/octet-stream")]
		public var TailConfig:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/frostboltSprinkleParticle.pex", mimeType="application/octet-stream")]
		public var SprinkleConfig:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/frostboltFlashParticle.pex", mimeType="application/octet-stream")]
		public var FlashConfig:Class;
		
		
		// particle textures
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/textures/flash.png")]
		public var FrostboltParticleAsset:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/textures/ring.png")]
		public var RingParticleAsset:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/textures/sprinkle.png")]
		public var SprinkleParticleAsset:Class;
		[Embed(source="../../../../../../../../lib/assets/animation/spell/ice/frostbolt/particle/textures/flash.png")]
		public var FlashParticleAsset:Class;
		
		// particle systems
		private var ps_frostbolt:PDParticleSystem;
		private var ps_ring:PDParticleSystem;
		private var ps_tail:PDParticleSystem;
		private var ps_sprinkle:PDParticleSystem;
		private var ps_flash:PDParticleSystem;
				
		// private properties
		private var initFlag:Boolean = false;
		private var concentrationImages:Vector.<Image>;
		
		private var concentrationContainer:Sprite;
		private var particlesContainer:Sprite;
		
		protected var concentrationTimeline:TimelineMax;
		protected var flyTimeline:TimelineMax;
		protected var hitTimeline:TimelineMax;
		
		protected var targetPosition:Point;
		protected var initiatorPosition:Point;
		protected var scene:DisplayObjectContainer;
		private var onComplete:Function;
				
		public function init () :void {
			if (initFlag) return;
			
			initConcentration();
			initParticles();
			initTweens();
			
			initFlag = true;
		}
		
		protected function initConcentration () :void {
			concentrationContainer = new Sprite();
			var fbcaAssetClasses:Vector.<Class> = new <Class>[fbca1,fbca2,fbca3,fbca4,fbca5,fbca6,fbca7,fbca8,fbca9];
			concentrationImages = new Vector.<Image>();
			var length:uint = fbcaAssetClasses.length; 
			var bitmap:Bitmap;
			var assetClass:Class;
			var image:Image;
			for (var i:int = 0; i < length; i ++) {
				assetClass = fbcaAssetClasses[i];
				bitmap = new assetClass();
				var fbcaTexture:Texture = Texture.fromBitmap(bitmap);
				image = new Image(fbcaTexture);
				image.x = -100;
				image.y = -100;
				image.alpha = 0;
				concentrationImages.push(image);
				concentrationContainer.addChild(image);
			}
			
		}
		protected function initParticles () :void {
			//particlesContainer = new Sprite();
			
			// textures
			var frostboltTexture:Texture = Texture.fromBitmap(new FrostboltParticleAsset());
			var ringTexture:Texture = Texture.fromBitmap(new RingParticleAsset());
			var spinkleTexture:Texture = Texture.fromBitmap(new SprinkleParticleAsset());
			var flashTexture:Texture = Texture.fromBitmap(new FlashParticleAsset());
			
			//systems
			var frostboltConfig:XML = XML(new FrostboltConfig());
			ps_frostbolt = new PDParticleSystem(frostboltConfig, frostboltTexture);
					
			//particlesContainer.addChild(ps_frostbolt);
			
			var ringConfig:XML = XML(new RingConfig());
			ps_ring = new PDParticleSystem(ringConfig, ringTexture);
						
			var tailConfig:XML = XML(new TailConfig());
			ps_tail = new PDParticleSystem(tailConfig, frostboltTexture);
						
			var spinkleConfig:XML = XML(new SprinkleConfig());
			ps_sprinkle = new PDParticleSystem(spinkleConfig, spinkleTexture);
			
			var flashConfig:XML = XML(new FlashConfig());
			ps_flash = new PDParticleSystem(flashConfig, flashTexture);
					
		}
		
		protected function initTweens () :void {
			initConcentrationTween();
			initFlyTween();
			initHitTween();
		}
		
		protected function initConcentrationTween() :void {
			concentrationTimeline = new TimelineMax( { onComplete:onConcentrationComplete } );
			concentrationTimeline.pause();
			
			concentrationTimeline.add('particlesSpin');
			concentrationTimeline.to(ps_frostbolt, 0, { alpha:0, scaleX:4, scaleY:4, ease: Power0.easeNone }, "partilesSpin");
			concentrationTimeline.to(ps_ring, 0, { alpha:0, ease: Power0.easeNone }, "partilesSpin");
			concentrationTimeline.to(ps_flash, 0, { alpha:0, scaleX:0.4, scaleY:0.4, ease: Power0.easeNone }, "partilesSpin");
			concentrationTimeline.to(ps_tail, 0, { alpha:0, ease: Power0.easeNone }, "partilesSpin");
			concentrationTimeline.to(ps_sprinkle, 0, { alpha:0, ease: Power0.easeNone }, "partilesSpin");
			concentrationTimeline.to(concentrationContainer, 0, { rotation:degreesToRadians(0), ease: Power0.easeNone }, "particlesSpin");

			var angle:uint = 5;
			var duration:Number = 0.1;
			var alpha:Number = 1;
			for (var i:int = 0; i < 8; i ++) {
				concentrationTimeline.add("spin" + i);
				concentrationTimeline.to(concentrationContainer, duration, { rotation:degreesToRadians(angle * i), ease: Power0.easeNone  }, "spin" + i);
				concentrationTimeline.to(concentrationImages[i], duration, { alpha:alpha , ease: Power0.easeNone, onComplete:runParticles}, "spin" + i ); 
			}
			
			concentrationTimeline.add("spin" + i);
			concentrationTimeline.to(concentrationContainer, duration*10, { rotation:degreesToRadians(angle * (i + 9)), ease: Power0.easeNone }, "spin" + i);
			concentrationTimeline.to(concentrationImages[i], duration*10, { alpha:alpha, ease: Power0.easeNone }, "spin" + i);
			concentrationTimeline.to(ps_frostbolt, duration*10, { alpha:alpha, ease: Power0.easeNone }, "spin" + i);
			
			i ++;
			concentrationTimeline.add("spin" + i);
			concentrationTimeline.to (concentrationContainer, duration*10, { rotation:degreesToRadians(140), ease: Power0.easeNone }, "spin" + i);
			concentrationTimeline.to (concentrationContainer, duration*10, { alpha:0, ease: Expo.easeOut }, "spin" + i); 
			concentrationTimeline.to (ps_frostbolt, duration*10, {scaleX:2.0, scaleY:2.0, ease: Power0.easeNone }, "spin" + i);
			
			i ++;
			concentrationTimeline.add("spin" + i);
			concentrationTimeline.to (ps_frostbolt, duration*5, {scaleX:1.0, scaleY:1.0, ease: Power0.easeNone }, "spin" + i);
			
		}
		
		protected function initFlyTween () :void {
			flyTimeline = new TimelineMax( { onComplete:onFlyComplete} );
			flyTimeline.pause();
			if (targetPosition == null) {
				return;
			}
			flyTimeline.add("spin");
			var speed:Number = 0.2;
			flyTimeline.to(ps_tail, 0, {alpha:1, ease: Power0.easeNone }, "spin");
			flyTimeline.to(ps_frostbolt, 0.2, { x:targetPosition.x, y:targetPosition.y, ease: Power0.easeNone }, "spin");
			flyTimeline.to(ps_tail, 0.2, { x:targetPosition.x, y:targetPosition.y, ease: Power0.easeNone }, "spin");
		}
		protected function initHitTween () :void {
			hitTimeline =  new TimelineMax( { onComplete:onHitComplete } );
			hitTimeline.pause();
			hitTimeline.add("spin");
			hitTimeline.to(ps_flash, 0, { alpha:1, ease: Power0.easeNone, onComplete:onPsFlashComplete}, "spin");
			hitTimeline.to(ps_tail, 0, { alpha:0, ease: Power0.easeNone }, "spin");
			hitTimeline.to(ps_ring, 0, { alpha:.3, scaleX:2.0, scaleY:2.0, ease: Power0.easeNone }, "spin");
			hitTimeline.to(ps_sprinkle, 0, { alpha:1, ease: Power0.easeNone, onComplete:onPsSpinkleComplete}, "spin");
			hitTimeline.to(ps_ring, 0.2, { alpha:.0, scaleX:4.0, scaleY:4.0, ease: Power0.easeNone, onComplete:onPsRingComplete}, "spin");
			hitTimeline.to(ps_frostbolt, 2.0, {alpha:0, scaleX:10.0, scaleY:10.0, ease: Expo.easeOut }, "spin");
			
		}
		
		private function onPsFlashComplete () :void {
			ps_flash.stop();
		}
		
		private function onPsRingComplete () :void {
			ps_ring.stop();
		}
		
		private function onPsSpinkleComplete () :void {
			ps_sprinkle.stop();
		}
		
		private function runParticles () :void {
			ps_frostbolt.start();
			ps_tail.start();
			ps_sprinkle.start();
			ps_ring.start();
			ps_flash.start();
			ps_ring.visible = true;
			ps_frostbolt.visible = true;
			
		}
		
		private function onConcentrationComplete () :void {
			ps_tail.start();
			flyTimeline.play();
		}
		
		private function onFlyComplete () :void {
			hitTimeline.play();
		}
		
		private function onHitComplete () :void {
			Starling.juggler.remove(ps_frostbolt);
			Starling.juggler.remove(ps_ring);
			Starling.juggler.remove(ps_sprinkle);
			Starling.juggler.remove(ps_tail);
			Starling.juggler.remove(ps_flash);
			
			ps_frostbolt.stop();
			ps_tail.stop();
			ps_sprinkle.stop();
			ps_ring.stop();
			ps_flash.stop();
			
			scene.removeChildren();
			onComplete();
		
			
		}
		
		private function degreesToRadians(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		private function prepare () :void {
			var length:uint = concentrationImages.length; 
			var image:Image;
			for (var i:int = 0; i < length; i ++) {
				image = concentrationImages[i];
				image.alpha = 0;
			}
			
			
			Starling.juggler.add(ps_frostbolt); 
			Starling.juggler.add(ps_ring);
			Starling.juggler.add(ps_sprinkle);
			Starling.juggler.add(ps_tail); 
			Starling.juggler.add(ps_flash); 
			
			ps_ring.visible = false;
			ps_frostbolt.visible = false;
						
			concentrationTimeline.restart();
			concentrationTimeline.pause();
			
			flyTimeline.restart();
			flyTimeline.pause();
			
			hitTimeline.restart();
			hitTimeline.pause();
		}
		
		
		
		public function configure(scene:DisplayObjectContainer, initiator:Point, target:Point, onComplete:Function) :void {
			
			this.onComplete = onComplete;
			
			targetPosition = target;
			//initParticles();
			initiatorPosition = initiator;
			
			this.scene = scene;
			
			//var bgQuad:Quad = new Quad((scene as Sprite).stage.stageWidth, (scene as Sprite).stage.stageHeight, 0x002143);
			//bgQuad.alpha = 0.5;
			//scene.addChild(bgQuad);
			
			scene.addChild(concentrationContainer);
			
			concentrationContainer.x = initiatorPosition.x;
			concentrationContainer.y = initiatorPosition.y;
						
			//scene.addChild(ps_ring);
			scene.addChild(ps_tail);
			scene.addChild(ps_ring);
			scene.addChild(ps_sprinkle);
			scene.addChild(ps_flash);
			scene.addChild(ps_frostbolt);
						
			ps_frostbolt.x = initiatorPosition.x;
			ps_frostbolt.y = initiatorPosition.y;
			
			ps_tail.x = initiatorPosition.x;
			ps_tail.y = initiatorPosition.y;
			
			ps_sprinkle.x = targetPosition.x;
			ps_sprinkle.y = targetPosition.y;
			
			ps_ring.x = targetPosition.x;
			ps_ring.y = targetPosition.y;
			
			ps_flash.x = targetPosition.x;
			ps_flash.y = targetPosition.y;
			
			var angle:Number = Math.atan2(ps_tail.y - targetPosition.y, ps_tail.x - targetPosition.x) / Math.PI * 180;
			angle = (angle < 0) ? angle + 360 : angle;
			ps_tail.emitAngle = degreesToRadians(angle + 180);
			
			//particlesContainer.x = concentrationContainer.x;
			//particlesContainer.y = concentrationContainer.y;
			
			
			prepare();
			initFlyTween();
			
			
		}
		
		public function start () :void {
			concentrationTimeline.play();
		}
		
	}

}