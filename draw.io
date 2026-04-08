<mxfile host="app.diagrams.net" agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36" version="29.2.7">
  <diagram id="xhJ0Q9t7Eb7I13ZTGqnA" name="Trang-1">
    <mxGraphModel dx="1202" dy="612" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="2" parent="1" style="rounded=1;fillColor=#dae8fc;strokeColor=#6c8ebf;fontStyle=1;align=center;" value="Controller&#xa;AuthController" vertex="1">
          <mxGeometry height="60" width="180" x="234" y="140" as="geometry" />
        </mxCell>
        <mxCell id="3" parent="1" style="rounded=1;fillColor=#e1d5e7;strokeColor=#9673a6;fontStyle=1;align=center;" value="Model&#xa;UserModel" vertex="1">
          <mxGeometry height="60" width="160" x="30" y="290" as="geometry" />
        </mxCell>
        <mxCell id="4" parent="1" style="rounded=1;fillColor=#d5e8d4;strokeColor=#82b366;fontStyle=1;align=center;" value="View&#xa;LoginView" vertex="1">
          <mxGeometry height="60" width="180" x="480" y="280" as="geometry" />
        </mxCell>
        <mxCell id="5" parent="1" style="shape=mxgraph.flowchart.start_2;fillColor=#f5f5f5;strokeColor=#666666;fontColor=#333333;" value="Người dùng" vertex="1">
          <mxGeometry height="50" width="50" x="299" y="10" as="geometry" />
        </mxCell>
        <mxCell id="6" parent="1" style="shape=cylinder3;fillColor=#f8cecc;strokeColor=#b85450;fontStyle=1;" value="Database" vertex="1">
          <mxGeometry height="30" width="50" x="200" y="410" as="geometry" />
        </mxCell>
        <mxCell id="7" edge="1" parent="1" source="5" style="edgeStyle=orthogonalEdgeStyle;strokeColor=#185FA5;fontColor=#185FA5;entryX=0.372;entryY=-0.04;entryDx=0;entryDy=0;entryPerimeter=0;exitX=0.145;exitY=0.855;exitDx=0;exitDy=0;exitPerimeter=0;" target="2" value="① Request&#xa;gửi form đăng nhập">
          <mxGeometry relative="1" x="0.1816" y="-11" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="8" edge="1" parent="1" source="2" style="edgeStyle=orthogonalEdgeStyle;strokeColor=#534AB7;fontColor=#534AB7;exitX=0;exitY=0.5;exitDx=0;exitDy=0;" target="3" value="② Demand&#xa;xác thực user/pass">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="110" y="170" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="9" edge="1" parent="1" source="3" style="edgeStyle=orthogonalEdgeStyle;strokeColor=#534AB7;fontColor=#534AB7;exitX=1;exitY=0.25;exitDx=0;exitDy=0;" target="2" value="③ Data&#xa;user hợp lệ / lỗi">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="310" y="305" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="10" edge="1" parent="1" source="2" style="edgeStyle=orthogonalEdgeStyle;strokeColor=#0F6E56;fontColor=#0F6E56;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="4" value="④ Data+Presentation&#xa;dữ liệu để render">
          <mxGeometry relative="1" x="-0.2711" as="geometry">
            <mxPoint as="offset" />
            <Array as="points">
              <mxPoint x="540" y="170" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="11" edge="1" parent="1" source="4" style="edgeStyle=orthogonalEdgeStyle;strokeColor=#0F6E56;fontColor=#0F6E56;exitX=0;exitY=0;" target="2" value="⑤ Presentation&#xa;render giao diện">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="12" edge="1" parent="1" source="2" style="edgeStyle=orthogonalEdgeStyle;strokeColor=#185FA5;fontColor=#185FA5;entryX=0.855;entryY=0.855;entryDx=0;entryDy=0;entryPerimeter=0;exitX=0.704;exitY=-0.006;exitDx=0;exitDy=0;exitPerimeter=0;" target="5" value="⑥ Response&#xa;kết quả đăng nhập">
          <mxGeometry relative="1" x="-0.4403" y="-39" as="geometry">
            <mxPoint as="offset" />
            <mxPoint x="360" y="130" as="sourcePoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="13" edge="1" parent="1" source="3" style="edgeStyle=orthogonalEdgeStyle;exitX=1.01;exitY=0.949;exitDx=0;exitDy=0;exitPerimeter=0;" target="6" value="truy vấn">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="14" edge="1" parent="1" source="6" style="edgeStyle=orthogonalEdgeStyle;" target="3" value="kết quả">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
