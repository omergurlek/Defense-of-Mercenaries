package model
{
	import flash.geom.Point;
	
	import model.Tile;
	import model.Tower;
	
	import starling.display.Sprite;

	public class Map extends Sprite
	{
		private var tiles:Array = null;
		
		public function Map()
		{
			super();
		}
		
		public function insertTower(tower:Tower, x:int, y:int):void
		{
			var tile:Tile = tiles[x + y * 16];
			tile.occupy(tower);
			tower.insert(tile);
		}
		
		public function generateMap():void
		{
			tiles = new Array(16 * 16);
			
			for (var i:int = 0; i < 16; i++)
			{
				for (var j:int = 0; j < 16; j++)
				{
					tiles[i + j * 16] = new Tile(new Point(i, j));
					stage.addChild(tiles[i + j * 16]);
				}
			}
		}
	}
}