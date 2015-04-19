package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.input.gamepad.FlxGamepad;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class EndState extends FlxState
{

  private var gamepad(get, never):FlxGamepad;
  private function get_gamepad():FlxGamepad
  {
    var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
    if (gamepad == null)
    {
      // Make sure we don't get a crash on neko when no gamepad is active
      gamepad = FlxG.gamepads.getByID(0);
    }
    return gamepad;
  }

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

    FlxG.mouse.visible = false;

    var text = new FlxText(0, 0, FlxG.width, 'The End');
    text.autoSize = true;
    text.setFormat(null, 20, 0xFFFFFF, 'center');
    FlxSpriteUtil.screenCenter(text, false, true);
    text.setPosition(text.x, text.y - 40);
    add(text);

    var text2 = new FlxText(0, 0,  FlxG.width, 'Press ENTER or any gamepad button to start again');
    text2.setFormat(null, 10, 0xFFFFFF, 'center');
    FlxSpriteUtil.screenCenter(text2, false, true);
    text2.setPosition(text2.x, text2.y + 20);
    add(text2);

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

    if(gamepad.anyButton() || FlxG.keys.anyPressed(['ENTER'])){
      Reg.currentMap = 1;
      FlxG.switchState(new PlayState());
    }

	}

}
