package com.pyro.engine.character 
{
	/**
	 * ...
	 * @author Mark Petro
	 * @author Leland Ede
	 * @author Robbie Carrington Jr.
	 * 
	 * This is designed to simply hold all the information of a character:  statistics and states.
	 */

	import com.pyro.engine.physics.ProjectileEvent;
	import data.items.GameAxe;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import com.pyro.engine.character.PeCharacterTracker;
	import com.pyro.engine.core.InputController;
	import com.pyro.engine.core.IPeController;
	import com.pyro.engine.core.IPeObject;
	import com.pyro.engine.core.IPeTicked;
	import com.pyro.engine.core.PeFPS;
	import com.pyro.engine.core.PeGroup;
	import com.pyro.engine.core.PeKeyBinding;
	import com.pyro.engine.debug.PeLogger;
	import com.pyro.engine.gfx2d.sprites.PeSprite;
	import com.pyro.engine.objects.PePoint;
	import com.pyro.engine.gfx2d.sprites.PeBlitter;
	import com.pyro.engine.physics.CollisionEvent;
	import com.pyro.engine.physics.PeCircleCollider;
	import com.pyro.engine.core.PeWorld;
	import com.pyro.engine.PE;
	import com.pyro.engine.physics.IPeCollider;
	import com.pyro.engine.physics.PeVector2D;
	import com.pyro.engine.sound.PeSoundEngine;
	import com.pyro.engine.ai.PeMonsterAI;
	 
	public class PeCharacter extends EventDispatcher implements IPeObject, IPeTicked
	{
		public static const THROW:String			= "throw";
		public static const RUN:String				= "run";
		public static const ATTACK:String			= "attack";
		public static const DEFEND:String			= "defend";
		public static const IDLE:String				= "idle";
		public static const DIE:String				= "die";
		public static const JUMPUP:String			= "jumpup";
		public static const JUMPDOWN:String			= "jumpdown";
		public static const JUMPAIR:String			= "jumpair";
		public static const JUMP_SPEED:Number		= 4.0;
		public static const RIGHT:String			= "right";
		public static const LEFT:String				= "left";
		public static const VICTORY:String			= "celebrate";
		
		private var _name:String;
		private var _stats:PeCharacterTracker;
		private var _layer:int;							// ID number of objects layer in the array stack
		private var _group:PeGroup;
		private var _parent:DisplayObjectContainer;
		private var _sprite:Sprite;
		
		private var _collider:IPeCollider;				// Collision system
		private var _collProjectile:IPeCollider;		// Projectile collision area
		private var _collAttack:IPeCollider;			// Attack collision area
		
		private var trackCollision:Array;				// Track objects re have collided with.
		private var _isTickReady:Boolean;				// Track if tick is ready to process
		private var speedPos:PeVector2D;				// Direction speed for positive direction
		private var speedNeg:PeVector2D;				// Direction speed for negitive direction
		private var _vector:PeVector2D;					// Vector speed of object
		
		//private var _sound:IPeSound;
		
		private var _startPos:PePoint;
		private var _direction:String;
		private var currState:String;					// Current state character is in
		private var prevState:String;					// Previous state character was in
		private var _levelMove:Boolean;
		private var isIdle:Boolean;
		private var currStatePos:PePoint;
		private var animation:String;
		private var _moveMap:Function;
		private var _leftBoundry:int;
		private var _rightBoundry:int;
		private var mapPos:PePoint;
		private var lock:Boolean;
		private var _lockout:PeLock;
		private var _controller:IPeController;			// Character game controller
		private var _world:PeWorld;					// Update the character world position
		private var blitter:PeBlitter;
		private var processAttack:Boolean;
		private var vertVelocity:Number;
		private var _spawner:Function;
		private var _godMode:Boolean;
		private var _tickID:int;
		private var _projAxe:GameAxe;
		
		public function PeCharacter(inName:String):void
		{
			//Yay! We have a character!  Player and Monster classes will extend this.
			//_sprite = new Sprite;
			_name = inName;
			_startPos = new PePoint(0, 0, 0, false);
			_direction = "right";
			currState = new String;
			isIdle = true;
			currStatePos = new PePoint(0, 0, 0);
			mapPos = new PePoint(0, 0, 0, true);
			_levelMove = false;
			animation = IDLE;
			_sprite = new Sprite();
			processAttack = false;
			// Lock states definitions
			_lockout = new PeLock();
			lock = false;
			_vector = new PeVector2D();
			trackCollision = [];
			_isTickReady = false;
			speedPos = new PeVector2D();
			speedNeg = new PeVector2D();
			_godMode = false;
		}
	
		public function get stats():PeCharacterTracker 
		{
			return _stats;
		}
		
		public function set stats(value:PeCharacterTracker):void 
		{
			_stats = value;
			setBaseSpeed();
		}
		
		public function moveToStartLocation():void
		{
			
			_sprite.x = stats.pos.x;
			_sprite.y = stats.pos.y;
			stats.pos.z = (stats.pos.y - 360) / (475 - 360);
			PeLogger.getInstance.log("------- Start Size: " + Number(stats.pos.z).toString());
			_sprite.scaleX = 0.85+(0.15 * stats.pos.z);
			_sprite.scaleY = 0.85+(0.15 * stats.pos.z);
//			jumpHeight = 0;
		}
		
		/***
		 * IPeObject Requirements
		 * 
		 * These are just stubs and will beed to be filled out with functionality
		 * once we understand how they will work with the character class
		 ***/
		
		public function get name():String
		{
			return _name;
		}// End method name
		
		public function set name(inName:String):void
		{
			_name = inName;
		}
		
		public function get layer():int 
		{
			return _layer;
		}
		
		public function set layer(value:int):void 
		{
			_layer = value;
		}
		
		public function get owningGroup():PeGroup 
		{
			return _group;
		}
		
		public function set owningGroup(value:PeGroup):void 
		{
			_group = value;
		}
		
		public function init(inName:String):Boolean
		{
			currState = animation;
			prevState = currState;
			_sprite.addChild(blitter);
			if (_stats.type != "player")
			{
				_sprite.addChild(_stats.bar);
			}
			_sprite.addChild(_sprite.hitArea);
			moveToStartLocation();
			return true;
		}
		
		public function setBlitter(thing:PeBlitter):void
		{
			blitter = thing;
			blitter.action = animation;
			blitter.direction = _direction;
			blitter.loop = true;
			blitter.init();
		}
		
		public function set parent(parent:DisplayObjectContainer):void
		{
				_parent = parent;
		}
		
		public function get sprite():Sprite
		{
			// Need to override this in the child class where this data is stored
			return _sprite;
		}
		
		public function get levelMove():Boolean 
		{
			return _levelMove;
		}
		
		public function get direction():String 
		{
			return _direction;
		}
		

		public function get moveMap():Function 
		{
			return _moveMap;
		}
		
		public function set moveMap(value:Function):void 
		{
			_moveMap = value;
		}
		
		public function set rightBoundry(value:int):void 
		{
			_rightBoundry = value;
		}
		
		public function set leftBoundry(value:int):void 
		{
			_leftBoundry = value;
		}
		
		public function set controller(ctrl:IPeController):void 
		{
			_controller = ctrl;
			if (_controller != null)
			{
				_controller.addKeyEvent(	Keyboard.D, moveRight);
				_controller.addKeyPressUp(	Keyboard.D, clrRight);
				_controller.addKeyEvent(	Keyboard.A, moveLeft);
				_controller.addKeyPressUp(	Keyboard.A, clrLeft);
				_controller.addKeyEvent(	Keyboard.W, moveUp);
				_controller.addKeyPressUp(	Keyboard.W, clrUp);
				_controller.addKeyEvent(	Keyboard.S, moveDown);
				_controller.addKeyPressUp(	Keyboard.S, clrDown);
				_controller.addKeyPress(	Keyboard.SPACE, jump);
				_controller.addKeyEvent(	Keyboard.Q, block);
				_controller.addKeyEvent(	Keyboard.LEFT, block);
				_controller.addKeyPress(	Keyboard.E, attackMelee);
				_controller.addKeyPress(	Keyboard.RIGHT, attackMelee);
				_controller.addKeyPress(	Keyboard.R, attackRange);
				_controller.addKeyPress(	Keyboard.UP, attackRange);
				_controller.addKeyPress(	Keyboard.T, addHealth);
				_controller.addKeyPress(	Keyboard.Y, removeHealth);
				_controller.addKeyPress(	Keyboard.BACKSLASH, andersonMode);
				
				_controller.addKeyPress(200, setDirLeft);
				_controller.addKeyPress(201, setDirRight);
				_controller.addKeyUpEvent(makeIdle);
				_controller.gamePos = stats.pos;
			}
		}
		
		public function addHealth(e:Event):void
		{
			if (_stats.lifePotions-- > 0)
			{
				_stats.life += 25;
				_stats.lifePotions--;
				playPowerup();
			}else
			{
				// Play out of potiuons sound
			}
		}
		
		public function removeHealth(e:Event):void
		{
			_stats.life--;
		}
		
		public function get controller():IPeController
		{
			return _controller;
		}
		
		public function set world(wrld:PeWorld):void 
		{
			_world = wrld;
		}
		
		public function get lockout():PeLock 
		{
			return _lockout;
		}
		
		public function set direction(value:String):void 
		{
			_direction = value;
		}
		
		public function get collider():IPeCollider 
		{
			return _collider;
		}
		
		public function set collider(coll:IPeCollider):void 
		{
			_collider = coll;
			sprite.addChild(_collider.sprite);
		}
		
		public function get vector():PeVector2D 
		{
			return _vector;
		}
		
		public function set vector(value:PeVector2D):void 
		{
			_vector = value;
		}
		
		public function destroy():void
		{
			// Check to see if object is in parent
			//if (true == _parent.contains(this))
			//{
				// Remove from parent class
				//_parent.removeChild(this);
			//}
		}// End destory
		
		/*
		 * 
		 * onFrame runs everything
		 * 
		 */
		public function onFrame(e:Event):void
		{
			// Yes Timmy when a player is dead we need to remove them from the game field
			if (stats.dead)
			{
				// Process dead
				dead();
			}else
			{
				// Process jump
				if (lockout.locked & PeLock.JUMP)
				{
					jump(e);
				}
				// Set current animation state
				currState = animation;
				// Check to see if we need to move the game level
				if (!(lockout.locked & (PeLock.ATTACK | PeLock.DEFEND | PeLock.THROW)))
				{
					vector.x = stats.pos.x - sprite.x;
					vector.y = stats.pos.y - sprite.y;
					move(stats.pos);
					if (_levelMove && _moveMap != null)
					{
						_vector.x = -(mapPos.x);
						_vector.y = mapPos.y;
						_moveMap(mapPos);
					}else if (_world != null)
					{
						// Update player field position to calculate world position
						_world.playerPosition = stats.pos;
					}
				}
				if (currState == VICTORY)
				{
					_direction = RIGHT;
				}
				_collider.vector = _vector;
			}// Endif character is dead check
			if (_stats.gotHit && !(lockout.locked & PeLock.DEFEND) )
			{
					if (animation == "hurta")
					{
						animation = "hurtb";
					}else
					{
						animation = "hurta";
					}
					blitter.speed = 40;
					_stats.gotHit = false;
					blitter.hold = true;	
			}
			if (_stats.powerUp)
			{
				if (stats.type == "player")
				{
					animation = "powerup";
					blitter.speed = 40;
					_stats.powerUp = false;
				}
			}

			// Process throw actions
			if (lockout.locked & PeLock.THROW && blitter.frame == 10)
			{
				throwProjectile();
			}
			
			// Set blitter animaiton to recorded animation
			blitter.action = animation;
			// Set blitter direction
			blitter.direction = _direction;
			// Process blitter on frame event
			blitter.onFrame(e);
			// Check to see if blitter is done
			if (blitter.done || lockout.locked & PeLock.CLEARANIM)
			{
				// Reset lock
				lock = false;
				if (!isIdle)
				{
					makeIdle(e);
				}
			}// Endif blitter is done
			if (prevState != currState)
			{
				unlock(prevState);
			}
			
			prevState = currState;
			// Set object ready for tick
			_isTickReady = true;
		}
		
		/**
		 * Tick event handler, used for processing collisions
		 * 
		 * @param	deltaTime
		 */
		
		public function onTick(deltaTime:Number):void
		{
			//PeLogger.getInstance.debugState = true;
			setBaseSpeed();
		
			var maxAngle:Number = 45.0;
			var attacked:PeCharacter = null;
			var chkSpeed:PeVector2D = new PeVector2D();

			_collider.clearPredictor();
			_collAttack.clearPredictor();
			_collProjectile.clearPredictor();
			if (trackCollision.length > 0 && !(lockout.locked & PeLock.JUMP))
			{
				for each(var obj:PeCharacter in trackCollision)
				{
					if (_godMode)
					{
						obj.stats.life = 0;
						continue;
					}
					var collDetected:Boolean = _collider.hitTestCollider(obj.collider);
					var angle:Number = PeCircleCollider(_collider).hitAngle;
					var distance:PeVector2D = new PeVector2D();
					if (PeCircleCollider(_collider).distance != null)
					{
						distance = PeCircleCollider(_collider).distance;
						if (obj.vector != null)
						{
							chkSpeed.x = Math.abs(obj.vector.x);
							chkSpeed.y = Math.abs(obj.vector.y);
						}// Endif validate vector of other object
					}
					PeLogger.getInstance.log("Distance: " + distance.toString())
					PeLogger.getInstance.log("Angle: " + angle);
					// Process monster attack
					if (angle > (180 - maxAngle) && angle < (180 + maxAngle))
					{
						if (collDetected)
						{
							speedPos.x = 0;
						}else if (distance.x < speedPos.x + chkSpeed.x && speedPos.x > 0)
						{
							speedPos.x = distance.x - chkSpeed.x;
						}
						// Process my attack
						if ((lockout.locked & PeLock.ATTACK) && processAttack && direction == RIGHT && !(obj.lockout.locked & PeLock.DIE))
						{
							if (attacked == null)
							{
								attacked = obj;
							}else if(PeCircleCollider(obj.collider).hypotenuse < PeCircleCollider(attacked.collider).hypotenuse)
							{
								attacked = obj;
							}
						}
						// Process their attack
						if ((obj.lockout.locked & PeLock.ATTACK) && obj.processAttack && obj.direction == LEFT 
							&& (obj.blitter.frame > 5 && obj.blitter.frame < 8) && !(lockout.locked & PeLock.DIE))
						{
							reduceLife(obj.stats.attack);
							obj.processAttack = false;
							if (stats.life <= 0)
							{
								obj.animation = VICTORY;
								obj.blitter.loop = false;
								obj.blitter.speed = 20;
							}
						}
					}// Endif angle between 135 and 225 (Font collision)
					if ((angle > (360 - maxAngle) && angle <= 360) || (angle >= 0 && angle < maxAngle))
					{
						if (collDetected)
						{
							speedNeg.x = 0;
						}else if (distance.x < speedNeg.x + chkSpeed.x && speedNeg.x > 0)
						{
							speedNeg.x = distance.x - chkSpeed.x;
						}
						// Process my attack
						if ((lockout.locked & PeLock.ATTACK) && processAttack && direction == LEFT)
						{
							if (attacked == null)
							{
								attacked = obj;
							}else if(PeCircleCollider(obj.collider).hypotenuse < PeCircleCollider(attacked.collider).hypotenuse)
							{
								attacked = obj;
							}
						}						
						// Process their attack
						if ((obj.lockout.locked & PeLock.ATTACK) && obj.processAttack && obj.direction == RIGHT
							&& (obj.blitter.frame > 5 && obj.blitter.frame < 8) && !(lockout.locked & PeLock.DIE))
						{
							reduceLife(obj.stats.attack);
							obj.processAttack = false;
						}
					}// Endif angle between 315 - 360 and 0 - 45 (Back collision)
					if (angle > (90 - maxAngle) && angle < (90 + maxAngle)) 
					{
						if (collDetected)
						{
							speedNeg.y = 0;
						}else if (distance.y < speedNeg.y)
						{
							//PeLogger.getInstance.log("distance: " + distance.toString() + " Speed: " + speedNeg.toString());
							speedNeg.y = distance.y;
						}
					}// Endif angle between 135 and 45 (Up Collision)
					if (angle > (270 - maxAngle) && angle < (270 + maxAngle))
					{
						if (collDetected)
						{
							speedPos.y = 0;
						}else if (distance.y < speedPos.y)
						{
							speedPos.y = distance.y;
						}
					}// Endif angle between 225 and 315 (Bottom Collision)
				}// End for each collision object
			}
			if (attacked != null && collAttack.hitTestCollider(attacked.collider))
			{
				if (blitter.frame > 5 && blitter.frame < 8)
				{
					attacked.reduceLife(stats.attack);
					playHit();
					processAttack = false;
					PeMonsterAI(attacked.controller).hitByPlayer = true;
					if (attacked.stats.life <= 0)
					{
						stats.exp += attacked.stats.expereince;
					}
				}
			}else if ((lockout.locked & PeLock.ATTACK) && processAttack)
			{
				playMiss();
				processAttack = false;
			}
			// Make sure speed is not negitive
			if (speedPos.x < 0)
			{
				speedPos.x = 0;
			}
			if (speedPos.y < 0)
			{
				speedPos.y = 0;
			}
			if (speedNeg.x < 0)
			{
				speedNeg.x = 0;
			}
			if (speedNeg.y < 0)
			{
				speedNeg.y = 0;
			}
			// Clear tracking list
			trackCollision = [];
			_isTickReady = false;
			//PeLogger.getInstance.debugState = false;
		}
		
		public function get tickReady():Boolean
		{
			return _isTickReady;
		}
		
		public function set spawner(value:Function):void 
		{
			_spawner = value;
		}
		
		public function get collProjectile():IPeCollider 
		{
			return _collProjectile;
		}
		
		public function set collProjectile(value:IPeCollider):void 
		{
			_collProjectile = value;
			sprite.addChild(_collProjectile.sprite);
		}
		
		public function get collAttack():IPeCollider 
		{
			return _collAttack;
		}
		
		public function set collAttack(value:IPeCollider):void 
		{
			_collAttack = value;
			sprite.addChild(collAttack.sprite);
		}
		
		public function get tickID():int 
		{
			return _tickID;
		}
		
		public function set tickID(value:int):void 
		{
			_tickID = value;
		}
		
		public function set projAxe(axe:GameAxe):void 
		{
			_projAxe = axe;
			_projAxe.init();
		}
		
		//public function set sound(snd:IPeSound):void 
		//{
			//_sound = snd;
		//}
		
		public function reduceLife(life:int):void
		{
			if (!(lockout.locked & PeLock.DEFEND))
			{
				stats.life -= life;
				playOuch();
			}else
			{
				playDefend();
			}
		}
		
		
		/*
		 * Start movement functions to be called every frame
		 */ 
		 
		public function move(pos:PePoint):void
		{
			_sprite.x = pos.x;
			_sprite.y = pos.y + stats.jumpPos;
			_sprite.scaleX = 0.85+(0.15 * pos.z);
			_sprite.scaleY = 0.85+(0.15 * pos.z);
		}
		
		public function jump(e:Event):void
		{
		if (!(lockout.locked & (PeLock.ATTACK | PeLock.DEFEND | PeLock.THROW | PeLock.DIE | PeLock.POWERUP)))
			{
				if (!(lockout.locked & PeLock.JUMP))
				{
					//PeLogger.getInstance.log("Setting up jump.");
					vertVelocity = -JUMP_SPEED;
					lockout.lock = PeLock.JUMP;
				}
				
				if (vertVelocity < -0.5)
				{
					blitter.loop = false;
					blitter.speed = 20;
					animation = JUMPUP;
				}else if (vertVelocity > 0.5)
				{
					blitter.loop = false;
					blitter.speed = 20;
					animation = JUMPDOWN;
				}else {
					blitter.loop = false;
					blitter.speed = 20;
					animation = JUMPAIR;
				}
				stats.jumpPos += vertVelocity;
				vertVelocity += 0.1;
				if (vertVelocity > JUMP_SPEED)
				{
					vertVelocity = 0;
					lockout.unlock = PeLock.JUMP;
					animation = IDLE;
					stats.jumpPos= 0;
				}
			}// Endif lockout check
		}
		
		/*
		 * 
		 * Start action call functions
		 * 
		 */
		
		public function block(e:Event):void
		{
			if (lockout.locked == 0 || !(lockout.locked & (PeLock.JUMP | PeLock.ATTACK | PeLock.THROW 
				| PeLock.DIE | PeLock.POWERUP | PeLock.LEVELUP)))
			{
				if (!lock)
				{
					isIdle = false;
					lock = true;
					animation = DEFEND;
					blitter.loop = false;
					blitter.speed = stats.blockSpeed;
					lockout.lock = PeLock.DEFEND;
				}
			}
		}
		
		public function attackMelee(e:Event):void
		{
			if (lockout.locked == 0 || !(lockout.locked & (PeLock.ATTACK | PeLock.JUMP | PeLock.DEFEND | PeLock.THROW | PeLock.DIE
				| PeLock.POWERUP | PeLock.LEVELUP)))
			{
				isIdle = false;
				lock = true;
				processAttack = true;
				animation = ATTACK;
				blitter.loop = false;
				blitter.speed = stats.attackSpeed;
				lockout.lock = PeLock.ATTACK;
			}else
			{
				PeLogger.getInstance.log("Attack Lockout: " + (lockout.locked));
			}
		}
		
		public function attackRange(e:Event):void
		{
			if (lockout.locked == 0 || !(lockout.locked & (PeLock.JUMP | PeLock.ATTACK | PeLock.DEFEND | PeLock.THROW 
				| PeLock.DIE | PeLock.POWERUP | PeLock.LEVELUP)))
			{
				isIdle = false;
				lock = true;
				animation = THROW;
				blitter.loop = false;
				blitter.speed = 50;
				lockout.lock = PeLock.THROW;
			}
		}
		
		public function moveRight(e:Event):void
		{
			if (lockout.locked == 0 || !(lockout.locked & (PeLock.ATTACK | PeLock.DEFEND | PeLock.THROW
				| PeLock.DIE | PeLock.POWERUP | PeLock.LEVELUP | PeLock.LEFT)))
			{
				PeLogger.getInstance.log("Speed: " + speedPos.toString());
				var speed:Number = speedPos.x * PeFPS.getInstance.deltaTime;
				if (lockout.locked & (PeLock.UP | PeLock.DOWN))
				{
					speed *= .7071;
				}
				stats.pos.x += speed;
				if (stats.pos.x > _rightBoundry)
				{
					mapPos.x = (_rightBoundry - stats.pos.x) * 1.5;
					stats.pos.x = _rightBoundry;
					_levelMove = true;
				}
				isIdle = false;
				lock = true;
				_direction = RIGHT;
				animation = RUN;
				blitter.loop = true;
				lockout.lock = PeLock.RUN | PeLock.RIGHT;
			}// Endif lockout check
		}// End method move right
		
		public function moveLeft(e:Event):void
		{
			if (lockout.locked == 0 || !(lockout.locked & (PeLock.ATTACK | PeLock.DEFEND | PeLock.THROW
				| PeLock.DIE | PeLock.POWERUP | PeLock.LEVELUP | PeLock.RIGHT)))
			{
				//PeLogger.getInstance.log("Moving left");
				var speed:Number = speedNeg.x * PeFPS.getInstance.deltaTime;
				if (lockout.locked & (PeLock.UP | PeLock.DOWN))
				{
					speed *= .7071
				}
				stats.pos.x -= speed;
				if (stats.pos.x < _leftBoundry)
				{
					mapPos.x = (_leftBoundry - stats.pos.x) * 1.5;
					stats.pos.x = _leftBoundry;
					_levelMove = true;
				}
				isIdle = false;
				_direction = LEFT;
				animation = RUN;
				lock = true;
				blitter.loop = true;
				lockout.lock = PeLock.RUN | PeLock.LEFT;
			}// Ednif lockout check
		}
		
		public function moveUp(e:Event):void
		{
			if (lockout.locked == 0 || !(lockout.locked & (PeLock.ATTACK | PeLock.DEFEND | PeLock.THROW
				| PeLock.DIE | PeLock.POWERUP | PeLock.LEVELUP | PeLock.DOWN)))
			{
				PeLogger.getInstance.log("Move up");
				var speed:Number = speedNeg.y * PeFPS.getInstance.deltaTime;
				if (lockout.locked & (PeLock.LEFT | PeLock.RIGHT))
				{
					speed *= .7071;
				}
				if (speed > 0 && speed < 1)
				{
					speed = 1;
				}
				stats.pos.y -= speed;
				if (stats.pos.y < 360)
				{
					stats.pos.y = 360;
				}
				lock = true;
				blitter.loop = true;
				isIdle = false;
				animation = RUN;
				stats.pos.z = (stats.pos.y - 360) / (475 - 260);
				lockout.lock = PeLock.RUN | PeLock.UP;
				//PeLogger.getInstance.log("Locked UP");
			}else
			{
				PeLogger.getInstance.log("Lockout code: " + lockout.locked);
			}// Endif lockout check
		}
		
		public function moveDown(e:Event):void
		{
			if (lockout.locked == 0 || !(lockout.locked & (PeLock.ATTACK | PeLock.DEFEND | PeLock.THROW
				| PeLock.DIE | PeLock.POWERUP | PeLock.LEVELUP | PeLock.UP)))
			{
				PeLogger.getInstance.log("Move Down");
				var speed:Number = speedPos.y * PeFPS.getInstance.deltaTime;
				if (lockout.locked & (PeLock.LEFT | PeLock.RIGHT))
				{
					speed *= .7071;
				}
				if (speed > 0 && speed < 1)
				{
					speed = 1;
				}
				stats.pos.y += speed;
				PeLogger.getInstance.log("Speed: " + speed + " SpeedPos: " + speedPos.toString());
				if (stats.pos.y > 475)
				{
					stats.pos.y = 475;
				}
				stats.pos.z = (stats.pos.y - 360) / (475 - 360);
				blitter.loop = true;
				isIdle = false;
				animation = RUN;
				lockout.lock = PeLock.RUN | PeLock.DOWN;
				PeLogger.getInstance.log("Locked DOWN");
			}// Endif lockout check
		}

		public function clrRight(e:Event):void
		{
			//PeLogger.getInstance.log("Clear right");
			_levelMove = false;
			lockout.unlock = PeLock.RIGHT;
			lockout.lock = PeLock.CLEARANIM;
		}
		
		public function clrLeft(e:Event):void
		{
			//PeLogger.getInstance.log("Clear left");
			_levelMove = false;
			lockout.unlock = PeLock.LEFT;
			lockout.lock = PeLock.CLEARANIM;
		}
		
		public function clrUp(e:Event):void
		{
			PeLogger.getInstance.log("Clear UP");
			lockout.unlock = PeLock.UP;
		}
		
		public function clrDown(e:Event):void
		{
			PeLogger.getInstance.log("Clear DOWN");
			lockout.unlock = PeLock.DOWN;
			lockout.lock = PeLock.CLEARANIM;
		}
				
		public function makeIdle(e:Event):void
		{
			//PeLogger.getInstance.log("Make Idle");
			if ((!isIdle && !lock) || (animation == "defend"))
			{
				if (blitter.done)
				{
					blitter.loop = true;
				}
				isIdle = true;
				_levelMove = false;
				animation = IDLE;
				lockout.lock = PeLock.IDLE;
				lockout.unlock = PeLock.CLEARANIM;
			}
		}
		
		public function setDirRight(e:Event):void
		{
			if (!(lockout.locked & PeLock.DIE))
			{
				_direction = RIGHT;
			}
		}
		
		public function setDirLeft(e:Event):void
		{
			if (!(lockout.locked & PeLock.DIE))
			{
				_direction = LEFT;
			}
		}
		
		public function dead():void
		{
			// Character is dead so lock out all functions and play dieing animation
			animation = DIE;
			lockout.lock = PeLock.DIE;
			lock = true;
			blitter.loop = false;
			// Check to see if blitter animation is completed
			if (blitter.done)
			{
				// Time to fade character from game field
				_sprite.alpha -= .02;
				if (_sprite.alpha <= 0)
				{
					// Character is off game field so dispatch event
					dispatchEvent(new CharacterEvent(CharacterEvent.REMOVE_CHARACTER, layer));
				}// Endif alphs is 0
			}// Endif blitting is done
		}
		
		private function unlock(state:String):void
		{
			//PeLogger.getInstance.log("Unlock state");
			switch(state)
			{
				case IDLE:
					lockout.unlock = PeLock.IDLE;
					break;
				case ATTACK:
					{	
						lockout.unlock = PeLock.ATTACK;
					}
					break;
				case DEFEND:
					lockout.unlock = PeLock.DEFEND;
					break;
				case THROW:
					{
						lockout.unlock = PeLock.THROW;
					}
					break;
				case RUN:
					lockout.unlock = PeLock.RUN | PeLock.LEFT | PeLock.RIGHT | PeLock.UP | PeLock.DOWN;
					break;
				default:
					//PeLogger.getInstance.log("Unlock state: " + state);
					break;
			}
		}
		
		public function playHit():void
		{
			//var hit:PeSoundItem = _sound.getFont("attack", "hit");
			//if (hit != null)
			//{
				//hit.volume = .3;
				//hit.play();
			//}
			PeSoundEngine.getInstance.playSound("attack_hit");
		}
		
		public function playDefend():void
		{
			//var defend:PeSoundItem = _sound.getFont("attack", "block");
			//if (defend != null)
			//{
				//defend.volume = .3;
				//defend.play();
			//}
			PeSoundEngine.getInstance.playSound("attack_block");
		}
		
		public function playMiss():void
		{
			//var miss:PeSoundItem = _sound.getFont("attack", "miss");
			//if (miss != null)
			//{
				//miss.volume = .3;
				//miss.play();
			//}
			PeSoundEngine.getInstance.playSound("attack_miss");
		}
		
		public function playOuch():void
		{
			//var hit:PeSoundItem = _sound.getFont("player", "hit");
			//if (hit != null)
			//{
				//hit.volume = 0.3;
				//hit.play();
			//}
			PeSoundEngine.getInstance.playSound("player_hit");
		}
		
		public function playPowerup():void
		{
			//var power:PeSoundItem = _sound.getFont("player", "powerup");
			//if (power != null)
			//{
				//power.volume = 0.6;
				//power.play();
			//}
			PeSoundEngine.getInstance.playSound("player_powerup");
		}
		
		public function throwProjectile():void
		{
			// Create projectile
			var projectile:PeProjectile = new PeProjectile();
			var pnt:Point = new Point(sprite.x, sprite.y);
			if (_world != null)
			{
				pnt.x = _world.playerPosition.x;
				pnt.y - _world.playerPosition.y;
			}
			var speed:Number = 10.0;
			if (direction == LEFT) speed = -10.0;
			
			projectile.collider = new PeCircleCollider(new PeVector2D(64,64), 15.0);
			projectile.collider.debug = false;
			projectile.vector = new PeVector2D(speed, -2.0);
			projectile.projectile.y = -54;
			projectile.position = new PeVector2D(pnt.x + 32, pnt.y + 15);
			projectile.attack = stats.attack / 2;
			projectile.axeBlit = _projAxe;
			projectile.dir = _direction;
			_spawner(projectile);			
		}
		
		public function onCollision(e:CollisionEvent):void
		{
			// Add object to the collision tracking system
			trackCollision.push(e.colObject);
		}
		
		public function onProjectile(e:ProjectileEvent):void
		{
			if (!(lockout.locked & (PeLock.DIE)))
			{
				if (_collProjectile.hitTestCollider(e.projectile.collider) && e.projectile.active == true)
				{
					reduceLife(e.projectile.attack);
					e.projectile.onHit();
				}
			}
		}

		public function setBaseSpeed():void
		{
			if (_godMode)
			{
				speedPos.setXY(stats.speed * 2, stats.speed);
				speedNeg.setXY(stats.speed * 2, stats.speed);
			}else
			{
				speedPos.setXY(stats.speed, stats.speed / 2);
				speedNeg.setXY(stats.speed, stats.speed / 2);
			}
		}
		
		public function andersonMode(e:Event):void
		{
			if (_godMode)
			{
				_godMode = false;
			}else
			{
				_godMode = true;
				PeSoundEngine.getInstance.playSound("andersonmode");
			}
		}
		
	}
}