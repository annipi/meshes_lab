class FaceVertex_Mesh extends Basic_Mesh{

  ArrayList<IntList> vertex_list;
  ArrayList<IntList> face_list;
  HashMap<PVector, Integer> vertex_id;
  
  FaceVertex_Mesh() {
    build();
    shape.disableStyle();
    s_points.disableStyle();
  }

  void build() {
    vertices = new ArrayList<PVector>();
    vertex_list = new ArrayList<IntList>();
    face_list = new ArrayList<IntList>();
    vertex_id = new HashMap<PVector, Integer>();
    
    PShape s = loadShape("wolf.obj");
    
    int children = s.getChildCount();
    for (int i = 0; i < children; i++) {
      PShape child = s.getChild(i);
      IntList next_vertex = new IntList();
      IntList next_face = new IntList();
      int total = child.getVertexCount();
      for(int j=0; j< total;j++){
        vertices.add(child.getVertex(j));
        vertex_list.add(next_vertex);
        int next_id;
        if (vertex_id.containsKey(child.getVertex(j))) {
          next_id = vertex_id.get(child.getVertex(j));
        } else {
          vertex_id.put(child.getVertex(j), vertices.size()-1);
          next_id = vertices.size()-1;
        }
        next_face.append(next_id);
        vertex_list.get(next_id).append(j);
        }
      face_list.add(next_face);
    }
    
    shape = createShape();
    s_points = createShape();
    shape.beginShape(TRIANGLES);
    s_points.beginShape(POINTS);
    int cnt =0 ;
    for(int i =0; i < face_list.size();i++) {
      PVector cvertex;
      for(int nxt: face_list.get(i)) {
        cvertex = vertices.get(nxt);
        cnt ++;
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
      for(int i =0; i < face_list.size();i++) {
        PVector cvertex;
        for(int nxt: face_list.get(i)) {
          cvertex = vertices.get(nxt);
          s.vertex(cvertex.x, cvertex.y, cvertex.z);
        }
      }
      s.endShape();
      shape(s, 0, -100);
    }else{
      PShape s = createShape();
      s.beginShape(TRIANGLES);
      for(int i =0; i < face_list.size();i++) {
        PVector cvertex;
        for(int nxt: face_list.get(i)) {
          cvertex = vertices.get(nxt);
          s.vertex(cvertex.x, cvertex.y, cvertex.z);
        }
      }
      s.endShape();
      shape(s, 0, -100);
    }
  }
}


  