package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPath;
import flixel.util.FlxPoint;
import flixel.util.FlxAngle;

class Teleport extends FlxSprite {


  public function new (x:Float = 0, y:Float = 0){

    super(x, y);
    loadGraphic(AssetPaths.teleport__png, true, 32, 32);

  }

}
