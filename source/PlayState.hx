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
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

				// Load the level's tilemaps
		var level = new TiledLevel("assets/maps/map-test.tmx");

		// Add tilemaps
		add(level.foregroundTiles);

		// Load player objects
		level.loadObjects(this);

		// Add background tiles after adding level objects, so these tiles render on top of player
		add(level.backgroundTiles);

		var player = new Player(20,20);

		add(player);
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
	}
}