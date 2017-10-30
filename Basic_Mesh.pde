abstract class Basic_Mesh {
  float radius;
  PShape shape;
  PShape s_points;
   // rendering
  boolean retained;

  // visual modes
  // 0. Faces and edges
  // 1. Wireframe (only edges)
  // 2. Only faces
  // 3. Only points
  int mode;
  
  String type;
  // visual hints
  boolean boundingSphere;
  ArrayList<PVector> vertices;
  
  Basic_Mesh() {
    build();
    //use processing style instead of pshape's, see https://processing.org/reference/PShape.html
  }

  // compute both solid vertices and pshape
  abstract void build();

  // transfer geometry every frame
  abstract void drawImmediate();
  
  void draw() {
    pushStyle();

    // mesh visual attributes 
    // manipulate me as you wish
    int strokeWeight = 1; //3
    color lineColor = color(255, retained ? 0 : 255, 0);
    color faceColor = color(0, retained ? 0 : 255, 255, 100);

    strokeWeight(strokeWeight);
    stroke(lineColor);
    fill(faceColor);
    // visual modes
    switch(mode) {
    case 1:
      noFill();
      break;
    case 2:
      noStroke();
      break;
    }
    
    // rendering modes
    if (retained){
      if (mode == 3){
        shape(s_points,0,-100);
      }else{
        shape(shape,0,-100);
      }
    }else
      drawImmediate();
    popStyle();

    // visual hint
    if (boundingSphere) {
      pushStyle();
      noStroke();
      fill(0, 255, 0, 50);
      sphere(radius);
      popStyle();
    }
  }
}