package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

	public var player:Player;
	public var level:TiledLevel;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible = false;

				// Load the level's tilemaps
		level = new TiledLevel("assets/maps/map.tmx");

		// Add tilemaps
		add(level.foregroundTiles);

		// Load player objects
		level.loadObjects(this);

		// Add background tiles after adding level objects, so these tiles render on top of player
		add(level.backgroundTiles);
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

		level.collideWithLevel(player);

	}
}
