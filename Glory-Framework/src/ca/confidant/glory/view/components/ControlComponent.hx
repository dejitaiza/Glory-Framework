package ca.confidant.glory.view.components;
import format.SVG;

import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapDataChannel;
/**
 * @author Allan Dowdeswell
 * ControlComponents persist on screen and are used to control display.
 * @param bMap The bare minimum to create this. This may be beefed up in future.
 */
class ControlComponent extends Sprite {
	private var defaultBitmap:Bitmap;
	public var action:String;


	public function new (action:String) {
		super ();
		//this.defaultBitmap=bMap;
		this.action=action;
		//addChild(bMap);
	}
	public function addBitmap(bMap:Bitmap){
		this.defaultBitmap=bMap;
		addChild(bMap);
	}
	public function addSVG(t:String):Void {
		var svg = new SVG (t); 
		svg.render(this.graphics);
	}
}
