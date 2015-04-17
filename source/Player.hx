package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.FlxG;

class Player extends FlxSprite {

  public function new (x:Float = 0, y:Float = 0){

    super(x, y);
    loadGraphic(AssetPaths.player__png, true, 16, 16);

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);

  }

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

  private function movement():Void
  {

    var up:Bool = false;
    var down:Bool = false;
    var left:Bool = false;
    var right:Bool = false;
    var A:Bool = false;
    var B:Bool = false;
    var X:Bool = false;
    var Y:Bool = false;

    up = FlxG.keys.anyPressed(["UP", "W", "Z"]);
    down = FlxG.keys.anyPressed(["DOWN", "S"]);
    left = FlxG.keys.anyPressed(["LEFT", "A", "Q"]);
    right = FlxG.keys.anyPressed(["RIGHT", "D"]);
    A = FlxG.keys.anyPressed(["H"]);
    B = FlxG.keys.anyPressed(["J"]);
    X = FlxG.keys.anyPressed(["K"]);
    Y = FlxG.keys.anyPressed(["L"]);

    if( #if flash gamepad.pressed(XboxButtonID.DPAD_LEFT) #else gamepad.dpadLeft #end || left || gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_X) < 0 ){

      //LEFT

    } else if( #if flash gamepad.pressed(XboxButtonID.DPAD_RIGHT) #else gamepad.dpadRight #end || right || gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_X) > 0 ){

      //RIGHT

    } else if( #if flash gamepad.pressed(XboxButtonID.DPAD_UP) #else gamepad.dpadUp #end || up || gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_Y) < 0 ){

      //UP

    } else if(#if flash gamepad.pressed(XboxButtonID.DPAD_DOWN) #else gamepad.dpadDown #end || down || gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_Y) > 0 ){

      //DOWN

    }

    if(A || gamepad.pressed(XboxButtonID.A) ){

      //A

    }

    if(B || gamepad.pressed(XboxButtonID.B) ){

      //B

    }

    if(X || gamepad.pressed(XboxButtonID.X) ){

      //X

    }

    if(Y || gamepad.pressed(XboxButtonID.Y) ){

      //Y

    }

  }
  override public function destroy():Void
  {
    super.destroy();
  }

  override public function update():Void
  {

    super.update();

    movement();

  }

}
