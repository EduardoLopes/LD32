package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

	public static var player:Player;
	public var level:TiledLevel;
	public var collideWithMap:FlxGroup;
	public static var bullets:FlxTypedGroup<Bullet>;
	public var enemies:FlxTypedGroup<Enemy>;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;

		collideWithMap = new FlxGroup();
		bullets = new FlxTypedGroup<Bullet>();
		enemies = new FlxTypedGroup<Enemy>();

		collideWithMap.add(bullets);

				// Load the level's tilemaps
		level = new TiledLevel("assets/maps/map.tmx");

		// Add tilemaps
		add(level.foregroundTiles);


		// Load player objects
		level.loadObjects(this);

		// Add background tiles after adding level objects, so these tiles render on top of player
		add(level.backgroundTiles);
		add(bullets);
		add(enemies);


	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();

		level.collideWithLevel(collideWithMap, function(map, object):Void{

			if(Std.is(object, Player))
			{
				playerCollideMap();
			}
			else if(Std.is(object, Bullet))
			{
				bulletCollideMap(object);
			}

		});

		FlxG.overlap(player, enemies, function(player, enemy):Void{

			if(FlxG.pixelPerfectOverlap(player, enemy)){
				resetLevel();
			}

		});

		FlxG.overlap(bullets, enemies, function(bullet, enemy):Void{
						
			enemy.onOff();
			bullet.kill();

		});

	}

	private function resetLevel():Void
	{

		enemies.forEach(function(enemy){
			enemy.returnToInitialPosition();
		});

		player.returnToInitialPosition();

	}

	private function playerCollideMap():Void
	{
		switch(player.facing)
		{
			case FlxObject.LEFT, FlxObject.RIGHT:
				player.animation.play("idlelr");
			case FlxObject.UP, FlxObject.DOWN:
				player.animation.play("idleud");
		}
	}

	private function bulletCollideMap(bullet:FlxObject):Void
	{
		bullet.kill();
	}

}
