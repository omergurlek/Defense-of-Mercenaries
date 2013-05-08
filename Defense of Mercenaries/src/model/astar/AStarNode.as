package model.astar
{
	import flash.geom.Point;
	
	import model.tile.Tile;

	public class AStarNode
	{
		public var h:int, f:int, g:int;
		public var visited:Boolean, closed:Boolean, isWall:Boolean;
		public var position:Point;
		public var parent:AStarNode, next:AStarNode;
		
		public function AStarNode() {}
	}
}