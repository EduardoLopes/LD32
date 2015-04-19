package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPath;
import flixel.util.FlxPoint;
import flixel.util.FlxAngle;

class Enemy extends FlxSprite {

  private var speed:Int = 200;
  private var brain:FSM;
  private var tilemap:FlxTilemap;
  private var path:FlxPath;
  private var on:Bool = false;
  private var initialPosition:FlxPoint;

  public function new (x:Float = 0, y:Float = 0, Tilemap:FlxTilemap){

    super(x, y);
    loadGraphic(AssetPaths.enemy__png, true, 16, 16);

    initialPosition = new FlxPoint(x,y);

    tilemap = Tilemap;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
    setFacingFlip(FlxObject.UP, false, false);
    setFacingFlip(FlxObject.DOWN, false, true);

    drag.x = drag.y = 1600;

    immovable = true;

    animation.add('lr', [0,1], 6, false);
    animation.add('idle', [4,3,4,2], 6, false);


    brain = new FSM(idle);

    path = new FlxPath();

  }

  public function returnToInitialPosition():Void
  {
    setPosition(initialPosition.x, initialPosition.y);
    path.cancel();
    angle = 0;
  }

  private function onOff():Void
  {
    on = !on;

    if(on){
      brain.activeState = findPlayer;
    } else {
      brain.activeState = idle;
      path.cancel();
    }

  }

  private function findPlayer():Void
  {

    var start:FlxPoint = FlxPoint.get( x + width / 2, y+ height / 2);
    var end:FlxPoint = FlxPoint.get( PlayState.player.x + PlayState.player.width / 2 , PlayState.player.y+ PlayState.player.height / 2);

    var pathPoints:Array<FlxPoint> = tilemap.findPath(start, end);

    if (pathPoints != null && (path != null))
		{
			path.start(this, pathPoints, 100, FlxPath.FORWARD, true);

      brain.activeState = moving;

		} else {

      brain.activeState = findPlayer;
    }

  }

  private function moving():Void
  {
    if (path.finished)
		{

      brain.activeState = idle;

		} else {

      brain.activeState = findPlayer;

      animation.play('lr');

    }

  }

  private function idle():Void
  {
    angle = FlxAngle.angleBetween(PlayState.player, this, true) - 90;
    animation.play('idle');
  }

  override public function destroy():Void
  {
    super.destroy();
  }

  override public function update():Void
  {

    super.update();

    brain.update();

  }

}
