class Mesh {
  // radius refers to the mesh 'bounding sphere' redius.
  // see: https://en.wikipedia.org/wiki/Bounding_sphere
  float radius = 200;
  PShape shape;
  PShape s_points;
   float str_y;
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
    s_points.disableStyle();
  }

  // compute both mesh vertices and pshape
  void build() {
    vertices = new ArrayList<PVector>();
    
    PShape s = loadShape("wolf.obj");
    
    int children = s.getChildCount();
    for (int i = 0; i < children; i++) {
      PShape child = s.getChild(i);
      int total = child.getVertexCount();
      for(int j=0; j< total;j++){
        vertices.add(child.getVertex(j));
      }
    }
    
    shape = createShape();
    s_points = createShape();
    shape.beginShape(TRIANGLES);
    s_points.beginShape(POINTS);
    for(PVector v : vertices) {
      shape.vertex(v.x, v.y ,v.z);
      s_points.vertex(v.x, v.y, v.z);
    }
    s_points.endShape();
    shape.endShape();
  }

  // transfer geometry every frame
  // TODO: current implementation targets a quad.
  // Adapt me, as necessary
  void drawImmediate() {
    if(mode == 3){
      PShape s = createShape();
      s.beginShape(POINTS);
      for(PVector v : vertices)
        s.vertex(v.x, v.y ,v.z);
      s.endShape();
      shape(s, 0, -100);
    }else{
      PShape s = createShape();
      s.beginShape(TRIANGLES);
      for(PVector v : vertices)
        s.vertex(v.x, v.y ,v.z);
      s.endShape();
      shape(s, 0, -100);
    }
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
      translate(0, str_y);
      sphere(radius);
      popStyle();
    }
  }
}


  