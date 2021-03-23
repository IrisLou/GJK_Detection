%% ����GJK�㷨�������
clc;
%% ��������ģ��
ObjectData; %�������嶥��������Ϣ

% �������������λ��ͼ
fig = figure;
hold on

% ������һ������
S1.Vertices = V1;
S1.Faces = F1;
S1.FaceColor = 'green';
S1Obj = patch(S1);

% �����ڶ�������
S2.Vertices = V2;
S2.Faces = F2;
S2.FaceColor = 'red';
S2Obj = patch(S2);

% ��������������
S3.Vertices = V3;
S3.Faces = F3;
S3.FaceColor = 'blue';
S3Obj = patch(S3);

hold off
axis equal
axis([0 5 0 5 0 5])
rotate3d on;

%% ���Կ�ʼ
iterationsAllowed = 10; %���������κ�������ʱ��������Ĵ���
collisionFlag12 = GJK_collision_detection(S1Obj,S2Obj,iterationsAllowed);
collisionFlag13 = GJK_collision_detection(S1Obj,S3Obj,iterationsAllowed);
collisionFlag23 = GJK_collision_detection(S2Obj,S3Obj,iterationsAllowed);
    
if collisionFlag12
   disp("ObjectA��ObjectB��ײ��");
else
   disp("ObjectA��ObjectBû����ײ��");
end

if collisionFlag13
   disp("ObjectA��ObjectC��ײ��");
else
   disp("ObjectA��ObjectCû����ײ��");
end

if collisionFlag23
   disp("ObjectB��ObjectC��ײ��");
else
   disp("ObjectB��ObjectCû����ײ��");
end