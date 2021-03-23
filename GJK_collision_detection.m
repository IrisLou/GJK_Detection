%% GJK碰撞检测
function flag = GJK_collision_detection(shape1,shape2,iterations)
direction = [0 0 1];  %初始方向
%构建1-simplex
[A,B] = pickLine(shape2, shape1, direction);
    
%构建2-simplex
[A,B,C,flag] = pickTriangle(A,B,shape2,shape1,iterations);
       
if flag == 1
    %构建3-simplex
    flag = pickTetrahedron(A,B,C,shape2,shape1,iterations);
end
end

%% 构建线段（1-simplex)
function [A,B] = pickLine(shape1,shape2,v)
B = support(shape2,shape1,v);
A = support(shape2,shape1,-v);
end

%% 构建三角形（2-simplex)
function [A,B,C,flag] = pickTriangle(A,B,shape1,shape2,IterationAllowed)
flag = 0; %还未构建出能够包围原点的单纯形

%构建第一个三角形
AB = B - A;
AO = -A;
direction = cross(cross(AB,AO),AB); % 更新方向为垂直于AB，指向原点
C = B;
B = A;
A = support(shape2,shape1,direction); %加入新的点，构成三角形

for i = 1:IterationAllowed 
    %%判断原点位于三角形划分出来的平面的区域中的哪一个区域，从而决定下次增加新点的方向
    AB = B - A;
    AO = -A;
    AC = C - A;
    
    ABC = cross(AB,AC);%三角形的法线  
    ABP = cross(AB,ABC);%垂直于AB，指向三角形外部
    ACP = cross(ABC,AC);%垂直于AC，指向三角形外部
    
    %由于选择点A时，我们已经得知原点在BC边靠近三角形内部一侧，所以只需判断原点在AB边、AC边的哪一侧即可
    if dot(ABP,AO) > 0
        %位于AB边远离三角形侧的区域
        %将该方向上离原点最远的点舍弃，即舍弃C点
        C = B; 
        B = A;
        direction = ABP; %更新方向为垂直于AB，指向三角形外部
    elseif dot(ACP, AO) > 0
            %位于AC边远离三角形侧的区域
            %舍弃B点
            B = A; 
            direction = ACP; %更新方向为垂直于AC，指向三角形外部
    else
        flag = 1; %原点已经位于三角形内部
        break; %判断结束，跳出循环
    end
    A = support(shape2,shape1,direction);
end

end

%% 构建四面体3-simplex
function flag = pickTetrahedron(A,B,C,shape1,shape2,IterationAllowed)
flag = 0;
AB = B-A;
AC = C-A;
ABC = cross(AB,AC); %三角形面的法线
AO = -A;

%构建第一个四面体
%判断原点在上一步检测出的包含原点的三角形的哪个位置，然后更新方向，加入新点构成四面体
if dot(ABC, AO) > 0
    %在三角形的上方
    D = C;
    C = B;
    B = A;
    direction = ABC; %三角形的法线方向为正确的方向
    A = support(shape2,shape1,direction); 
    
else %在三角形的下方
    D = B;
    B = A;
    direction = -ABC; %沿三角形的法线的反方向
    A = support(shape2,shape1,direction); 
end

for i = 1:IterationAllowed 
    %判断目前的四面体是否包含原点
    AB = B-A;
    AO = -A;
    AC = C-A;
    AD = D-A;
    
    ABC = cross(AB,AC); %面ABC的法线
    ACD = cross(AC,AD); %面ACD的法线
    ADB = cross(AD,AB); %面ADB的法线

    %由于选择点A时，我们已经得知原点在BCD面靠近四面体内部一侧，所以只需判断原点在面ABC、面ADB、面ACD的哪一侧即可
    if dot(ABC, AO) > 0 %在面ABC的外侧

    else
        if dot(ACD, AO) > 0 %在面ACD的外侧
            B = C;
            C = D;
            ABC = ACD;
        elseif dot(ACD, AO) < 0 %在面ACD的内侧
            if dot(ADB, AO) > 0 %在面ADB的外侧
                C = B;
                B = D;
                ABC = ADB;
            else
                flag = 1;
                break;
            end
        end
    end
    
%     A = support(shape2, shape1, direction);

    if dot(ABC, AO) > 0
    %在三角形的上方
        D = C;
        C = B;
        B = A;
        direction = ABC; %三角形的法线方向为正确的方向
        A = support(shape2,shape1,direction); 
  
    else %在三角形的下方
        D = B;
        B = A;
        direction = -ABC; %沿三角形的法线的反方向
        A = support(shape2,shape1,direction); 
    end  
end
end
%% 计算给定方向上的支持点
function point = SupportingPoint(shape, direction)
%解决兼容性问题
XData = shape.XData; 
YData = shape.YData;
ZData = shape.ZData;
%将每个点与方向向量做点乘（即在该方向上做投影），找到最大值对应的点
dot = XData*direction(1) + YData*direction(2) + ZData*direction(3);
[col_max,I] = max(dot);
[~,colIdx] = max(col_max);
rowIdx = I(colIdx);
point = [XData(rowIdx,colIdx), YData(rowIdx,colIdx), ZData(rowIdx,colIdx)];
end
%% 计算Minkowski差的边缘点
function point = support(shape1,shape2,v)
point1 = SupportingPoint(shape1, v);
point2 = SupportingPoint(shape2, -v);
point = point1 - point2;
end
