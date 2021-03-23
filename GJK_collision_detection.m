%% GJK��ײ���
function flag = GJK_collision_detection(shape1,shape2,iterations)
direction = [0 0 1];  %��ʼ����
%����1-simplex
[A,B] = pickLine(shape2, shape1, direction);
    
%����2-simplex
[A,B,C,flag] = pickTriangle(A,B,shape2,shape1,iterations);
       
if flag == 1
    %����3-simplex
    flag = pickTetrahedron(A,B,C,shape2,shape1,iterations);
end
end

%% �����߶Σ�1-simplex)
function [A,B] = pickLine(shape1,shape2,v)
B = support(shape2,shape1,v);
A = support(shape2,shape1,-v);
end

%% ���������Σ�2-simplex)
function [A,B,C,flag] = pickTriangle(A,B,shape1,shape2,IterationAllowed)
flag = 0; %��δ�������ܹ���Χԭ��ĵ�����

%������һ��������
AB = B - A;
AO = -A;
direction = cross(cross(AB,AO),AB); % ���·���Ϊ��ֱ��AB��ָ��ԭ��
C = B;
B = A;
A = support(shape2,shape1,direction); %�����µĵ㣬����������

for i = 1:IterationAllowed 
    %%�ж�ԭ��λ�������λ��ֳ�����ƽ��������е���һ�����򣬴Ӷ������´������µ�ķ���
    AB = B - A;
    AO = -A;
    AC = C - A;
    
    ABC = cross(AB,AC);%�����εķ���  
    ABP = cross(AB,ABC);%��ֱ��AB��ָ���������ⲿ
    ACP = cross(ABC,AC);%��ֱ��AC��ָ���������ⲿ
    
    %����ѡ���Aʱ�������Ѿ���֪ԭ����BC�߿����������ڲ�һ�࣬����ֻ���ж�ԭ����AB�ߡ�AC�ߵ���һ�༴��
    if dot(ABP,AO) > 0
        %λ��AB��Զ�������β������
        %���÷�������ԭ����Զ�ĵ�������������C��
        C = B; 
        B = A;
        direction = ABP; %���·���Ϊ��ֱ��AB��ָ���������ⲿ
    elseif dot(ACP, AO) > 0
            %λ��AC��Զ�������β������
            %����B��
            B = A; 
            direction = ACP; %���·���Ϊ��ֱ��AC��ָ���������ⲿ
    else
        flag = 1; %ԭ���Ѿ�λ���������ڲ�
        break; %�жϽ���������ѭ��
    end
    A = support(shape2,shape1,direction);
end

end

%% ����������3-simplex
function flag = pickTetrahedron(A,B,C,shape1,shape2,IterationAllowed)
flag = 0;
AB = B-A;
AC = C-A;
ABC = cross(AB,AC); %��������ķ���
AO = -A;

%������һ��������
%�ж�ԭ������һ�������İ���ԭ��������ε��ĸ�λ�ã�Ȼ����·��򣬼����µ㹹��������
if dot(ABC, AO) > 0
    %�������ε��Ϸ�
    D = C;
    C = B;
    B = A;
    direction = ABC; %�����εķ��߷���Ϊ��ȷ�ķ���
    A = support(shape2,shape1,direction); 
    
else %�������ε��·�
    D = B;
    B = A;
    direction = -ABC; %�������εķ��ߵķ�����
    A = support(shape2,shape1,direction); 
end

for i = 1:IterationAllowed 
    %�ж�Ŀǰ���������Ƿ����ԭ��
    AB = B-A;
    AO = -A;
    AC = C-A;
    AD = D-A;
    
    ABC = cross(AB,AC); %��ABC�ķ���
    ACD = cross(AC,AD); %��ACD�ķ���
    ADB = cross(AD,AB); %��ADB�ķ���

    %����ѡ���Aʱ�������Ѿ���֪ԭ����BCD�濿���������ڲ�һ�࣬����ֻ���ж�ԭ������ABC����ADB����ACD����һ�༴��
    if dot(ABC, AO) > 0 %����ABC�����

    else
        if dot(ACD, AO) > 0 %����ACD�����
            B = C;
            C = D;
            ABC = ACD;
        elseif dot(ACD, AO) < 0 %����ACD���ڲ�
            if dot(ADB, AO) > 0 %����ADB�����
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
    %�������ε��Ϸ�
        D = C;
        C = B;
        B = A;
        direction = ABC; %�����εķ��߷���Ϊ��ȷ�ķ���
        A = support(shape2,shape1,direction); 
  
    else %�������ε��·�
        D = B;
        B = A;
        direction = -ABC; %�������εķ��ߵķ�����
        A = support(shape2,shape1,direction); 
    end  
end
end
%% ������������ϵ�֧�ֵ�
function point = SupportingPoint(shape, direction)
%�������������
XData = shape.XData; 
YData = shape.YData;
ZData = shape.ZData;
%��ÿ�����뷽����������ˣ����ڸ÷�������ͶӰ�����ҵ����ֵ��Ӧ�ĵ�
dot = XData*direction(1) + YData*direction(2) + ZData*direction(3);
[col_max,I] = max(dot);
[~,colIdx] = max(col_max);
rowIdx = I(colIdx);
point = [XData(rowIdx,colIdx), YData(rowIdx,colIdx), ZData(rowIdx,colIdx)];
end
%% ����Minkowski��ı�Ե��
function point = support(shape1,shape2,v)
point1 = SupportingPoint(shape1, v);
point2 = SupportingPoint(shape2, -v);
point = point1 - point2;
end
