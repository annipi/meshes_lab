class VertexX2_Mesh extends Basic_Mesh{

  ArrayList<IntList> vertex_list;

  VertexX2_Mesh() {
    build();
    shape.disableStyle();
    s_points.disableStyle();
  }

  void build() {
    vertices = new ArrayList<PVector>();
    vertex_list = new ArrayList<IntList>();
    
    PShape s = loadShape("wolf.obj");
    
    int children = s.getChildCount();
    for (int i = 0; i < children; i++) {
      PShape child = s.getChild(i);
      IntList next_vertex = new IntList();
      int total = child.getVertexCount();
      for(int j=0; j< total;j++){
        vertices.add(child.getVertex(j));
        next_vertex.append(vertices.size()-1);
      }
      vertex_list.add(next_vertex);
    }
    
    shape = createShape();
    s_points = createShape();
    shape.beginShape(TRIANGLES);
    s_points.beginShape(POINTS);
    for(int i =0; i < vertex_list.size();i++) {
      PVector cvertex;
      for(int nxt: vertex_list.get(i)) {
        cvertex = vertices.get(nxt);
        shape.vertex(cvertex.x, cvertex.y, cvertex.z);
        s_points.vertex(cvertex.x, cvertex.y, cvertex.z);
      }
    }
    s_points.endShape();
    shape.endShape();
  }

  void drawImmediate() {
    if(mode == 3){
      PShape s = createShape();
      s.beginShape(POINTS);
      for(int i =0; i < vertex_list.size();i++) {
        PVector cvertex;
        for(int nxt: vertex_list.get(i)) {
          cvertex = vertices.get(nxt);
          s.vertex(cvertex.x, cvertex.y, cvertex.z);
        }
      }
      s.endShape();
      shape(s, 0, -100);
    }else{
      PShape s = createShape();
      s.beginShape(TRIANGLES);
      for(int i =0; i < vertex_list.size();i++) {
        PVector cvertex;
        for(int nxt: vertex_list.get(i)) {
          cvertex = vertices.get(nxt);
          s.vertex(cvertex.x, cvertex.y, cvertex.z);
        }
      }
      s.endShape();
      shape(s, 0, -100);
    }
  }
}


  