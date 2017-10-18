class Mesh {
  // radius refers to the mesh 'bounding sphere' redius.
  // see: https://en.wikipedia.org/wiki/Bounding_sphere
  float radius = 200;
  PShape shape, triShape, quadShape;
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
    shape = loadShape("wolf.obj");        
    
    vertices = new ArrayList<PVector>();

    // for example if we were to render a quad:
    int children = shape.getChildCount();
    println(children);
    for (int i = 0; i < children; i++) {
      PShape child = shape.getChild(i);
      int total = child.getVertexCount();
      for (int j = 0; j < total; j++) {
        PVector v = child.getVertex(0);
        vertices.add(v);
      }
    }
    

    shape = createShape();
    shape.beginShape();
    for(PVector v : vertices)
      shape.vertex(v.x, v.y ,v.z);
    shape.endShape();
        
    //don't forget to compute radius too
  }

  // transfer geometry every frame
  // TODO: current implementation targets a quad.
  // Adapt me, as necessary
  void drawImmediate() { 
    translate(0,-100);
    beginShape(TRIANGLE);
    for(PVector v : vertices)
      vertex(v.x, v.y ,v.z);
    endShape();
  }

  void draw() {
    pushStyle();

    // mesh visual attributes 
    // manipulate me as you wish
    int strokeWeight = 3;
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
      points(shape);
      break;
    }

    // rendering modes
    if (retained){
      //translate(0,-100);
      shape(shape,0,-100);
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

PShape points(PShape r) {
  PShape s = createShape();
  translate(0,-100);
  s.beginShape(POINTS);
  s.noFill();
  s.stroke(0,255,0);
  int children = r.getChildCount();
  println(children);
  for (int i = 0; i < children; i++) {
    PShape child = r.getChild(i);
    int total = child.getVertexCount();
    for (int j = 0; j < total; j++) {
      PVector v = child.getVertex(j);
      point(v.x, v.y, v.z);
    }
  }
  s.endShape();
  return s;
}
  

PShape createShapeQuad(PShape r) {
  PShape s = createShape();
  s.beginShape(QUADS);
  s.noStroke();
  for (int i=100; i<r.getChildCount (); i++) {
    if (r.getChild(i).getVertexCount() ==4) {
      for (int j=0; j<r.getChild (i).getVertexCount(); j++) {
        PVector p = r.getChild(i).getVertex(j);
        PVector n = r.getChild(i).getNormal(j);
        float u = r.getChild(i).getTextureU(j);
        float v = r.getChild(i).getTextureV(j);
        s.normal(n.x, n.y, n.z);
        s.vertex(p.x, p.y, p.z, u, v);
      }
    }
  }
  s.endShape();
  return s;
}

PShape createShapeTri(PShape r) {
  PShape s = createShape();
  s.beginShape(TRIANGLES);
  s.noStroke();
  for (int i=100; i<r.getChildCount (); i++) {
    if (r.getChild(i).getVertexCount() ==3) {
      for (int j=0; j<r.getChild (i).getVertexCount(); j++) {
        PVector p = r.getChild(i).getVertex(j);
        PVector n = r.getChild(i).getNormal(j);
        float u = r.getChild(i).getTextureU(j);
        float v = r.getChild(i).getTextureV(j);
        s.normal(n.x, n.y, n.z);
        s.vertex(p.x, p.y, p.z, u, v);
      }
    }
  }
  s.endShape();
  return s;
}