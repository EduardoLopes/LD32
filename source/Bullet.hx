package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.system.FlxSound;


class Bullet extends FlxSprite {

  private var speed:Int = 300;
  public static var COUNT:Int = 0;

  public function new (x:Float = 0, y:Float = 0){
    super(x, y);
    loadGraphic(AssetPaths.bullet__png, true, 16, 16);

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
    setFacingFlip(FlxObject.UP, false, true);
    setFacingFlip(FlxObject.DOWN, true, true);
  }

  private function horizontalHitbox():Void
  {
    width = 12;
    height = 6;
    offset.set(2, 5);
  }

  private function verticalHitbox():Void
  {
    width = 6;
    height = 12;
    offset.set(5, 2);
  }

  public function shootRight(x:Float, y:Float){

    velocity.x = speed;
    velocity.y = 0;
    angle = 0;
    facing = FlxObject.LEFT;
    horizontalHitbox();
    setPosition(x, y - 3);
    COUNT++;

  }

  public function shootLeft(x:Float,y:Float){

    velocity.x = -speed;
    velocity.y = 0;
    angle = 0;
    facing = FlxObject.RIGHT;
    horizontalHitbox();
    setPosition(x - 10, y - 3);
    COUNT++;
  }

  public function shootUp(x:Float, y:Float){

    velocity.x = 0;
    velocity.y = -speed;
    angle = 90;
    facing = FlxObject.UP;
    verticalHitbox();
    setPosition(x - 3, y - 10);
    COUNT++;

  }

  public function shootDown(x:Float, y:Float){

    velocity.x = 0;
    velocity.y = speed;
    angle = 90;
    facing = FlxObject.DOWN;
    verticalHitbox();
    setPosition(x - 3, y);
    COUNT++;

  }

  override function kill():Void
  {
    super.kill();
    COUNT--;
  }

  override function update():Void
  {
    super.update();

    if(!isOnScreen())
    {
      kill();
    }
  }

}
