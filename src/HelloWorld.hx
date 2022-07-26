import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.Assets;
import feathers.skins.HorizontalLineSkin;
import feathers.skins.PillSkin;
import feathers.skins.ProgrammaticSkin;
import feathers.skins.RectangleSkin;
import feathers.layout.AnchorLayoutData;
import feathers.layout.AnchorLayout;
import openfl.display.Sprite;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.Application;
import feathers.controls.Label;

class CustomSkin extends ProgrammaticSkin {
	public function new() {
		super();
	}

	override private function update():Void {
		graphics.clear();
		graphics.lineStyle(10.0, 0xff6666);
		graphics.beginFill(0xffcccc);
		graphics.moveTo(20.0, 5.0);
		graphics.lineTo(actualWidth - 20.0, 5.0);
		graphics.curveTo(actualWidth - 20.0, 20.0, actualWidth - 5.0, 20.0);
		graphics.lineTo(actualWidth - 5.0, actualHeight - 20.0);
		graphics.curveTo(actualWidth - 20.0, actualHeight - 20.0, actualWidth - 20.0, actualHeight - 5.0);
		graphics.lineTo(20.0, actualHeight - 5.0);
		graphics.curveTo(20.0, actualHeight - 20.0, 5.0, actualHeight - 20.0);
		graphics.lineTo(5.0, 20.0);
		graphics.curveTo(20.0, 20.0, 20.0, 5.0);
	}
}

class DotBackgroundSkin extends ProgrammaticSkin {
	final pattern:BitmapData;

	public function new() {
		super();

		pattern = Assets.getBitmapData("img/rub_s.png");
	}

	override private function update():Void {
		graphics.clear();
	
		graphics.beginFill(0x0a2332);
		graphics.drawRect(0, 0, actualWidth, actualHeight);
		graphics.endFill();
		
		for (i in 0...5000) {
			var a = Math.random();
			if (a < 0.05)
				a = 0.05;

			if (a > 0.1)
				a = 0.1;

			graphics.beginFill(0x333333, a);
			var x = Math.random() * actualWidth;
			var y = Math.random() * actualHeight;
			graphics.drawCircle(x, y, 3);
			graphics.endFill();
		}

		for (i in 0...200) {
			var x = Math.random() * actualWidth;
			var y = Math.random() * actualHeight;

			var matrix = new Matrix();
			matrix.translate(x, y);			
			graphics.beginBitmapFill(pattern, matrix, false);
			graphics.drawRect(x, y, 30, 30);
			graphics.endFill();
		}
	}
}

class HelloWorld extends Application {
	public function new() {
		super();

		backgroundSkin = new DotBackgroundSkin();

		var container = new LayoutGroup();
		this.layout = new AnchorLayout();
		container.layoutData = AnchorLayoutData.fill();

		container.layout = new AnchorLayout();
		addChild(container);

		var panel = new Panel();

		panel.layoutData = AnchorLayoutData.center();

		container.addChild(panel);

		panel.width = 300;
		panel.height = 300;

		panel.backgroundSkin = new CustomSkin();
	}
}
