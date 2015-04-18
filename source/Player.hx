package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.FlxG;
import flixel.util.FlxAngle;

class Player extends FlxSprite {

  private var speed:Int = 200;

  public function new (x:Float = 0, y:Float = 0){

    super(x, y);
    loadGraphic(AssetPaths.player__png, true, 16, 16);

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
    setFacingFlip(FlxObject.UP, false, false);
    setFacingFlip(FlxObject.DOWN, false, true);

    drag.x = drag.y = 1600;

    velocity.x = speed;
    velocity.y = speed;


    animation.add('lr', [0,1], 6, false);
    animation.add('ud', [2,3], 6, false);
    animation.add('idlelr', [6,5,6,4], 6, false);
    animation.add('idleud', [9,8,9,7], 6, false);

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

    var upButton:Bool = false;
    var downButton:Bool = false;
    var leftButton:Bool = false;
    var rightButton:Bool = false;
    var A:Bool = false;
    var B:Bool = false;
    var X:Bool = false;
    var Y:Bool = false;

    var goingUp:Bool = false;
    var goingDown:Bool = false;
    var goingLeft:Bool = false;
    var goingRight:Bool = false;

    upButton = FlxG.keys.anyPressed(["UP", "W", "Z"]);
    downButton = FlxG.keys.anyPressed(["DOWN", "S"]);
    leftButton = FlxG.keys.anyPressed(["LEFT", "A", "Q"]);
    rightButton = FlxG.keys.anyPressed(["RIGHT", "D"]);
    A = FlxG.keys.anyPressed(["H"]);
    B = FlxG.keys.anyPressed(["J"]);
    X = FlxG.keys.anyPressed(["K"]);
    Y = FlxG.keys.anyPressed(["L"]);

    var mA:Float = 0;


    if( #if flash gamepad.pressed(XboxButtonID.DPAD_LEFT) #else gamepad.dpadLeft #end || leftButton || gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_X) < 0 ){
      goingLeft = true;
      //LEFT
      mA = 180;

      facing = FlxObject.LEFT;

    } else if( #if flash gamepad.pressed(XboxButtonID.DPAD_RIGHT) #else gamepad.dpadRight #end || rightButton || gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_X) > 0 ){
      goingRight = true;
      //RIGHT
      mA = 0;

      facing = FlxObject.RIGHT;
    }

    if( #if flash gamepad.pressed(XboxButtonID.DPAD_UP) #else gamepad.dpadUp #end || upButton || gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_Y) < 0 ){
      goingUp = true;
      //UP
      mA = -90;
      if (goingLeft)
        mA -= 45;
      else if (goingRight)
        mA += 45;

      facing = FlxObject.UP;

    } else if(#if flash gamepad.pressed(XboxButtonID.DPAD_DOWN) #else gamepad.dpadDown #end || downButton || gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_Y) > 0 ){
      goingDown = true;
      //DOWN
      mA = 90;
      if (goingLeft)
        mA += 45;
      else if (goingRight)
        mA -= 45;

      facing = FlxObject.DOWN;
    }

    if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
    {
      switch(facing)
      {
        case FlxObject.LEFT, FlxObject.RIGHT:
          animation.play("lr");
        case FlxObject.UP, FlxObject.DOWN:
          animation.play("ud");
      }
    }

    if ((velocity.x == 0 && velocity.y == 0) && touching == FlxObject.ANY)
    {
      switch(facing)
      {
        case FlxObject.LEFT, FlxObject.RIGHT:
          animation.play("idlelr");
        case FlxObject.UP, FlxObject.DOWN:
          animation.play("idleud");
      }
    }

    if(goingLeft || goingRight || goingUp || goingDown)
    {
      FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity);
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
