%% 利用GJK算法进行求解
clc;
%% 构建物体模型
ObjectData; %导入物体顶点和面的信息

% 画出三个物体的位置图
fig = figure;
hold on

% 构建第一个物体
S1.Vertices = V1;
S1.Faces = F1;
S1.FaceColor = 'green';
S1Obj = patch(S1);

% 构建第二个物体
S2.Vertices = V2;
S2.Faces = F2;
S2.FaceColor = 'red';
S2Obj = patch(S2);

% 构建第三个物体
S3.Vertices = V3;
S3.Faces = F3;
S3.FaceColor = 'blue';
S3Obj = patch(S3);

hold off
axis equal
axis([0 5 0 5 0 5])
rotate3d on;

%% 测试开始
iterationsAllowed = 10; %构建三角形和四面体时允许迭代的次数
collisionFlag12 = GJK_collision_detection(S1Obj,S2Obj,iterationsAllowed);
collisionFlag13 = GJK_collision_detection(S1Obj,S3Obj,iterationsAllowed);
collisionFlag23 = GJK_collision_detection(S2Obj,S3Obj,iterationsAllowed);
    
if collisionFlag12
   disp("ObjectA和ObjectB相撞。");
else
   disp("ObjectA和ObjectB没有碰撞。");
end

if collisionFlag13
   disp("ObjectA和ObjectC相撞。");
else
   disp("ObjectA和ObjectC没有碰撞。");
end

if collisionFlag23
   disp("ObjectB和ObjectC相撞。");
else
   disp("ObjectB和ObjectC没有碰撞。");
end