HDrawablePool pool;
HColorPool colors;
HCanvas canvas;
HShape d;
PShader flipHalf;
PShader flipHalfY;

void setup(){
	size(1000,1000, P3D);
	frameRate(24);
	H.init(this).background(#e4f6f8).use3D(true);
	smooth();

	canvas = (HCanvas) H.add(new HCanvas(P3D).autoClear(false).background(#000000));
	H.add(canvas);

	flipHalf = loadShader("flipHalf.glsl");
	flipHalfY = loadShader("flipHalfY.glsl");


	colors = new HColorPool()

		.add(#ef4723,3)
		.add(#2d4081,2)
		.add(#f8b33e,2)
		.add(#168666,2)
		.add(#ffffff,2)
	;

	pool = new HDrawablePool(500); //Shapes
	pool.autoParent(canvas)

		.add(new HShape("vectors-1.svg"))
		.add(new HShape("vectors-2.svg"))
		.add(new HShape("vectors-3.svg"))
		.add(new HShape("vectors-4.svg"))
		.add(new HShape("vectors-5.svg"))
		.add(new HShape("vectors-6.svg"))

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.stroke(#000000)
						.strokeWeight(3)
						.fill(colors.getColor())
						.x(random(0,width/2))
						.y(random(0,width/2))
						.size( ( (int)random(2,10) * 200 ) ) // 50, 100, 150, 200
					;


					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.range((int)random(1,2)*100, 1500)
						.speed(.5)
						.freq(PI*3)
						.waveform(H.TRIANGLE)
						.currentStep(i+100*PI)
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(-2000, 2000)
						.speed(.5)
						.freq(2)
						.waveform(H.SAW)
						.currentStep(i+20)
					;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(width/2+2000, -2000/PI)
						.speed(random(3))
						.freq(random(2))
						.waveform(H.SAW)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(width/2+2000, -2000/PI)
						.speed(random(3))
						.freq(random(2))
						.waveform(H.SAW)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(0, 760/PI)
						.speed(.1)
						.freq(random(2))
						.waveform(H.TRIANGLE)
						.currentStep(i+100)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(0, 360)
						.speed(.1)
						.freq(3)
						.waveform(H.SAW)
						.currentStep(i)
					;


				}
			}
		)
		.requestAll()
	;


}

 
void draw() {

	H.drawStage();

	filter(flipHalfY); //flip half composition with glsl shader
	filter(flipHalf); //flip half composition with glsl shader

}

void keyPressed() {
  if (key == 's') {
    //stop();
    saveFrame();
  }
}

