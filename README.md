# GJK_Detection
GJK Collision Detection

The coordinates of 8 vertices of Object A in a 3D space are given as (0 0 0), (1 0 0), (1 1 0), (0 1 0), (0 0 1), (0 0 1), (1 0 1), (1 1 1), (0 1 1);  
Object B's 8 vertex coordinates are (1 1 1), (2 1 1), (2 2 1), (1 2 1), (1 1 2), (1 1 2), (2 1 2), (2 2 2), (1 2 2);  
The four vertex coordinates of Object C are (3 3 2), (5 3 2), (4 5 2), (4 4 4 4).   
The spatial position relationship of the three objects is shown in the following figure.  
![image](https://user-images.githubusercontent.com/54589090/112149415-e80a6b00-8c19-11eb-9b3b-4583a1590018.png)
Please choose two algorithms among LC algorithm, GJK algorithm and bounding box algorithm and implement them in Python or Matlab.  
Besides, use those two algorithms to determine whether these three objects collide in pairs or not.  

已知三维空间中 Object A 的 8 个顶点坐标为(0 0 0), (1 0 0), (1 1 0), (0 1 0), (0 0 1), (1 0 1), (1 1 1), (0 1 1);  
Object B 的 8 个顶点坐标为(1 1 1), (2 1 1), (2 2 1), (1 2 1), (1 1 2), (2 1 2), (2 2 2), (1 2 2);   
Object C 的 4 个顶点坐标为(3 3 2), (5 3 2), (4 5 2), (4 4 4)。  
三个物体的空间位置关系如下图所示。  

请利用 python/matlab 实现碰撞检测 LC 算法、GJK 算法、包围盒算法三个中的两个，并利用算法判断出这三个物体两两之间是否碰撞。  
