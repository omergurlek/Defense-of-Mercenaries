package game
{
	import flash.geom.Point;
	
	import game.enemy.Enemy;
	import game.projectile.Projectile;
	import game.tile.Grass;
	import game.tile.Tile;
	import game.tower.Tower;
	
	import starling.display.Sprite;
	
	public class Map extends Sprite
	{
		private var tiles:Vector.<Vector.<Tile>>;
		private var enemiesAndOccupiers:Sprite = new Sprite();
		
		public function Map()
		{
			super();
		}
		
		public function insertGate(gate:Gate, column:int, row:int):void
		{
			var tile:Tile = tiles[column][row];
			gate.insert(tile);
			addChild(gate);
		}
		
		public function insertOccupierToTile(occupier:Occupier, tile:Tile):void
		{
			tile.occupy(occupier);
			occupier.insert(tile);
			enemiesAndOccupiers.addChild(occupier);
		}
		
		public function insertOccupier(occupier:Occupier, column:int, row:int):void
		{
			var tile:Tile = tiles[column][row];
			tile.occupy(occupier);
			occupier.insert(tile);
			enemiesAndOccupiers.addChild(occupier);
		}
		
		public function removeOccupierFromTile(occupier:Occupier, tile:Tile):void
		{
			tile.deoccupy();
			occupier.removeFromParent(true);
		}
		
		public function insertEnemy(enemy:Enemy):void
		{
			enemiesAndOccupiers.addChildAt(enemy, 0);
		}
		
		public function generateMap():void
		{
			tiles = new Vector.<Vector.<Tile>>();
			
			for (var column:uint = 0; column < GlobalState.mapSize; column++)
			{
				tiles[column] = new Vector.<Tile>();
				
				for (var row:uint = 0; row < GlobalState.mapSize; row++)
				{
					tiles[column][row] = new Grass(new Point(column, row));
					addChild(tiles[column][row]);
				}
			}
		}
		
		public function addLayer():void
		{
			addChild(enemiesAndOccupiers);
		}
		
		public function getTiles():Vector.<Vector.<Tile>>
		{
			return tiles;
		}
		
		public function isEnemiesPresent():Boolean
		{
			var result:Boolean = false;
			
			for (var i:int = 0; i < enemiesAndOccupiers.numChildren; i++)
			{
				var child:Object = enemiesAndOccupiers.getChildAt(i);
				
				if (child is Enemy)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		public function getTileFromCoordinates(x:Number, y:Number):Tile
		{	
			var tileX:int = x / GlobalState.tileSize;
			var tileY:int = (y - GlobalState.tileSize) / GlobalState.tileSize;
			
			if (tileX >= 0 && tileX < 16 && tileY >= 0 && tileY < 16)
				return getTile(tileX, tileY);
			else
				return null;
		}
		
		public function getSnapCoordinates(x:Number, y:Number):Array
		{
			var snapCoordinates:Array = new Array(2);
			
			var tileX:int = x / GlobalState.tileSize;
			var tileY:int = (y - GlobalState.tileSize) / GlobalState.tileSize;
			
			snapCoordinates[0] = tileX * GlobalState.tileSize;
			snapCoordinates[1] = tileY * GlobalState.tileSize;
			
			return snapCoordinates;
		}
		
		public function getTile(column:int, row:int):Tile
		{
			return tiles[column][row];
		}
		
		public function getEnemiesAndOccupiers():Sprite
		{
			return enemiesAndOccupiers;
		}
		
		public function childrenSort():void
		{
			enemiesAndOccupiers.sortChildren(function sortByY(a:Object, b:Object):int
			{
				if (a.y > b.y)
					return 1;
				else if(a.y < b.y)
					return -1;
				else
				{
					if((a is Enemy) && (b is Enemy))
					{
						if ((a as Enemy).getDistanceMoved() < (b as Enemy).getDistanceMoved())
							return -1;
						else
							return 1;
					}
					else
						return 0;
				}
			});
		}
	}
}