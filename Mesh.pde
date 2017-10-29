class Mesh {
  // radius refers to the mesh 'bounding sphere' redius.
  // see: https://en.wikipedia.org/wiki/Bounding_sphere
  float radius = 200;
  PShape shape;
  // mesh representation
  ArrayList<PVector> vertices;

  // rendering mode
  boolean retained;

  // visual modes
  // 0. Faces and edges
  // 1. Wireframe (only edges)
  // 2. Only faces
  // 3. Only points
  int mode;

  // visual hints
  boolean boundingSphere;

  Mesh() {
    build();
    //use processing style instead of pshape's, see https://processing.org/reference/PShape.html
    shape.disableStyle();
  }

  // compute both mesh vertices and pshape
  // TODO: implement me
  void build() {
    vertices = new ArrayList<PVector>();

    vertices.add(new PVector(-100, -100, -100));
    vertices.add(new PVector( 100, -100, -100));
    vertices.add(new PVector(   0,    0,  100));
    
    vertices.add(new PVector( 100, -100, -100));
    vertices.add(new PVector( 100,  100, -100));
    vertices.add(new PVector(   0,    0,  100));
    
    vertices.add(new PVector( 100, 100, -100));
    vertices.add(new PVector(-100, 100, -100));
    vertices.add(new PVector(   0,   0,  100));
    
    vertices.add(new PVector(-100,  100, -100));
    vertices.add(new PVector(-100, -100, -100));
    vertices.add(new PVector(   0,    0,  100));
    
    // for example if we were to render a quad:
   
    
    shape = createShape();
    shape.beginShape(TRIANGLES);
    //shape.beginShape(QUAD_STRIP);
    for(PVector v : vertices)
      shape.vertex(v.x, v.y ,v.z);
    shape.endShape();


    //don't forget to compute radius too
  }

  // transfer geometry every frame
  // TODO: current implementation targets a quad.
  // Adapt me, as necessary
  void drawImmediate() {
    beginShape(QUADS);
    for(PVector v : vertices)
      vertex(v.x, v.y ,v.z);
    endShape();
  }
  
  void points() {
    translate(0,-100); 
    PShape s =createShape();
    beginShape(POINTS);
    strokeWeight(2);
    stroke(0,255,0);
    int children = shape.getChildCount();
    for (int i = 0; i < children; i++) {
      PShape child = shape.getChild(i);
      int total = child.getVertexCount();
      for (int j = 0; j < total; j++) {
        PVector v = child.getVertex(j);
        //point(v.x, v.y, v.z);
        vertex(v.x, v.y, v.z);
      }
    }
    endShape();
  }

  void draw() {
    pushStyle();

    // mesh visual attributes 
    // manipulate me as you wish
    int strokeWeight = 2; //3
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
    case 3:
      noFill();
      noStroke();
      points();
      break;
    }
    
    // rendering modes
    if (retained){
      shape(shape);
    }else{
      //translate(0,-100);
      drawImmediate();
    }
    popStyle();

    // visual hint
    if (boundingSphere) {
      pushStyle();
      noStroke();
      fill(0, 255, 255, 125);
      sphere(radius);
      popStyle();
    }
  }
}


  