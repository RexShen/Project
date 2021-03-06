% Read in CSV file and seperate the data
data = csvread('../read CPEV data/CPEV_Record_2016_08_01_10_10_17.csv');
[m, n] = size(data);
degmat = data(1:2:m, :);
val1 = data(2:16:m, :);
val2 = data(4:16:m, :);
val3 = data(6:16:m, :);
val4 = data(8:16:m, :);

% Set valmat and degmat to proper value
degmat = degmat./(5760).*(pi)+(pi/2);  % Radians
deg1 = degmat(1:8:m/2, :);
deg2 = degmat(2:8:m/2, :);
deg3 = degmat(3:8:m/2, :);
deg4 = degmat(4:8:m/2, :);
val1 = val1/100;
val2 = val2/100;
val3 = val3/100;
val4 = val4/100;

[x1, y1] = pol2cart(deg1, val1);
[x2, y2] = pol2cart(deg2, val2);
[x3, y3] = pol2cart(deg3, val3);
[x4, y4] = pol2cart(deg4, val4);

xd1 = [x1,x2];
yd1 = [y1,y2];
xd2 = [x3,x4];
yd2 = [y3,y4];
x = [x1,x2,x3,x4];
y = [y1,y2,y3,y4];

% Check 2 frames
frame = 511;
preframe = 506;

d1_a = deg1(frame,:);
d2_a = deg2(frame,:);
d3_a = deg3(frame,:);
d4_a = deg4(frame,:);
v1_a = val1(frame,:);
v2_a = val2(frame,:);
v3_a = val3(frame,:);
v4_a = val4(frame,:);
d1_b = deg1(preframe,:);
d2_b = deg2(preframe,:);
d3_b = deg3(preframe,:);
d4_b = deg4(preframe,:);
v1_b = val1(preframe,:);
v2_b = val2(preframe,:);
v3_b = val3(preframe,:);
v4_b = val4(preframe,:);

% Remove origins
d1_a = d1_a(d1_a ~= pi/2);
d2_a = d2_a(d2_a ~= pi/2);
d3_a = d3_a(d3_a ~= pi/2);
d4_a = d4_a(d4_a ~= pi/2);
v1_a = v1_a(d1_a ~= pi/2);
v2_a = v2_a(d2_a ~= pi/2);
v3_a = v3_a(d3_a ~= pi/2);
v4_a = v4_a(d4_a ~= pi/2);
d1_b = d1_b(d1_b ~= pi/2);
d2_b = d2_b(d2_b ~= pi/2);
d3_b = d3_b(d3_b ~= pi/2);
d4_b = d4_b(d4_b ~= pi/2);
v1_b = v1_b(d1_b ~= pi/2);
v2_b = v2_b(d2_b ~= pi/2);
v3_b = v3_b(d3_b ~= pi/2);
v4_b = v4_b(d4_b ~= pi/2);

[x1_a, y1_a] = pol2cart(d1_a, v1_a);
[x2_a, y2_a] = pol2cart(d2_a, v2_a);
[x3_a, y3_a] = pol2cart(d3_a, v3_a);
[x4_a, y4_a] = pol2cart(d4_a, v4_a);
[x1_b, y1_b] = pol2cart(d1_b, v1_b);
[x2_b, y2_b] = pol2cart(d2_b, v2_b);
[x3_b, y3_b] = pol2cart(d3_b, v3_b);
[x4_b, y4_b] = pol2cart(d4_b, v4_b);
pt12_a = union([x1_a;y1_a]',[x2_a;y2_a]','rows')';
xd1_a = pt12_a(1,:);
yd1_a = pt12_a(2,:);
pt34_a = union([x3_a;y3_a]',[x4_a;y4_a]','rows')';
xd2_a = pt34_a(1,:);
yd2_a = pt34_a(2,:);
pt_a = union(pt12_a',pt34_a','rows')';
x_a = pt_a(1,:);
y_a = pt_a(2,:);
pt12_b = union([x1_b;y1_b]',[x2_b;y2_b]','rows')';
xd1_b = pt12_b(1,:);
yd1_b = pt12_b(2,:);
pt34_b = union([x3_b;y3_b]',[x4_b;y4_b]','rows')';
xd2_b = pt34_b(1,:);
yd2_b = pt34_b(2,:);
pt_b = union(pt12_b',pt34_b','rows')';
x_b = pt_b(1,:);
y_b = pt_b(2,:);

% Matching Filter
% Find the unique-target degrees
isUnique1a = true(1,length(d1_a));
isUnique2a = true(1,length(d2_a));
isUnique3a = true(1,length(d3_a));
isUnique4a = true(1,length(d4_a));
isUnique1b = true(1,length(d1_b));
isUnique2b = true(1,length(d2_b));
isUnique3b = true(1,length(d3_b));
isUnique4b = true(1,length(d4_b));
for i=2:length(d1_a)
    if d1_a(i) == d1_a(i-1)
        isUnique1a(i) = false;
        isUnique1a(i-1) = false;
    end
end
for i=2:length(d2_a)
    if d2_a(i) == d2_a(i-1)
        isUnique2a(i) = false;
        isUnique2a(i-1) = false;
    end
end
for i=2:length(d3_a)
    if d3_a(i) == d3_a(i-1)
        isUnique3a(i) = false;
        isUnique3a(i-1) = false;
    end
end
for i=2:length(d4_a)
    if d4_a(i) == d4_a(i-1)
        isUnique4a(i) = false;
        isUnique4a(i-1) = false;
    end
end 
for i=2:length(d1_b)
    if d1_b(i) == d1_b(i-1)
        isUnique1b(i) = false;
        isUnique1b(i-1) = false;
    end
end
for i=2:length(d2_b)
    if d2_b(i) == d2_b(i-1)
        isUnique2b(i) = false;
        isUnique2b(i-1) = false;
    end
end
for i=2:length(d3_b)
    if d3_b(i) == d3_b(i-1)
        isUnique3b(i) = false;
        isUnique3b(i-1) = false;
    end
end
for i=2:length(d4_b)
    if d4_b(i) == d4_b(i-1)
        isUnique4b(i) = false;
        isUnique4b(i-1) = false;
    end
end    

% Degrees and values of unique-target
d1_a = d1_a(isUnique1a);
d2_a = d2_a(isUnique2a);
d3_a = d3_a(isUnique3a);
d4_a = d4_a(isUnique4a);
v1_a = v1_a(isUnique1a);
v2_a = v2_a(isUnique2a);
v3_a = v3_a(isUnique3a);
v4_a = v4_a(isUnique4a);
d1_b = d1_b(isUnique1b);
d2_b = d2_b(isUnique2b);
d3_b = d3_b(isUnique3b);
d4_b = d4_b(isUnique4b);
v1_b = v1_b(isUnique1b);
v2_b = v2_b(isUnique2b);
v3_b = v3_b(isUnique3b);
v4_b = v4_b(isUnique4b);

% Intersection of L1/L2 and L3/L4
[~,id1_a,id2_a] = intersect(d1_a,d2_a);
[~,id3_a,id4_a] = intersect(d3_a,d4_a);
[~,id1_b,id2_b] = intersect(d1_b,d2_b);
[~,id3_b,id4_b] = intersect(d3_b,d4_b);

% Matching and unique-target points in L1/L2 and L3/L4
d1_a = d1_a(id1_a);
d2_a = d2_a(id2_a);
d3_a = d3_a(id3_a);
d4_a = d4_a(id4_a);
v1_a = v1_a(id1_a);
v2_a = v2_a(id2_a);
v3_a = v3_a(id3_a);
v4_a = v4_a(id4_a);
d1_b = d1_b(id1_b);
d2_b = d2_b(id2_b);
d3_b = d3_b(id3_b);
d4_b = d4_b(id4_b);
v1_b = v1_b(id1_b);
v2_b = v2_b(id2_b);
v3_b = v3_b(id3_b);
v4_b = v4_b(id4_b);

[ux1_a, uy1_a] = pol2cart(d1_a, v1_a);
[ux2_a, uy2_a] = pol2cart(d2_a, v2_a);
[ux3_a, uy3_a] = pol2cart(d3_a, v3_a);
[ux4_a, uy4_a] = pol2cart(d4_a, v4_a);  
[ux1_b, uy1_b] = pol2cart(d1_b, v1_b);
[ux2_b, uy2_b] = pol2cart(d2_b, v2_b);
[ux3_b, uy3_b] = pol2cart(d3_b, v3_b);
[ux4_b, uy4_b] = pol2cart(d4_b, v4_b); 


% ICP
af = [x_a;y_a;zeros(size(x_a))];
bf = [x_b;y_b;zeros(size(x_b))];
afd1 = [xd1_a;yd1_a;zeros(size(xd1_a))];
bfd1 = [xd1_b;yd1_b;zeros(size(xd1_b))];
afd2 = [xd2_a;yd2_a;zeros(size(xd2_a))];
bfd2 = [xd2_b;yd2_b;zeros(size(xd2_b))];
afd1MF = [ux1_a;uy1_a;zeros(size(ux1_a))];
bfd1MF = [ux1_b;uy1_b;zeros(size(ux1_b))];
afd2MF = [ux3_a;uy3_a;zeros(size(ux3_a))];
bfd2MF = [ux3_b;uy3_b;zeros(size(ux3_b))];

[TR, TT, ER] = icp(af, bf, iter, 'Matching', 'kDtree', 'WorstRejection', wr);
[TRd1, TTd1, ERd1] = icp(afd1, bfd1, iter, 'Matching', 'kDtree', 'WorstRejection', wr);
[TRd2, TTd2, ERd2] = icp(afd2, bfd2, iter, 'Matching', 'kDtree', 'WorstRejection', wr);
[TRd1MF,TTd1MF,~] = icp(afd1MF,bfd1MF,iter,'Matching', 'kDtree', 'WorstRejection', wr);
[TRd2MF,TTd2MF,~] = icp(afd2MF,bfd2MF,iter,'Matching', 'kDtree', 'WorstRejection', wr);

lim = 40;

figure
scatter(xd1_a, yd1_a,'filled','MarkerFaceColor','r')
hold on
scatter(xd1_b, yd1_b,'filled','MarkerFaceColor','k')
hold off
xlim([-lim lim])
ylim([0 2*lim])
title('without matching filter')


figure
scatter(afd1MF(1,:), afd1MF(2,:),'filled','MarkerFaceColor','r')
hold on
scatter(bfd1MF(1,:), bfd1MF(2,:),'filled','MarkerFaceColor','k')
hold off
xlim([-lim lim])
ylim([0 2*lim])
title('with matching filter')

sz = size(bfd1);
sz_MF = size(bfd1MF);
d1_tf = TRd1*bfd1+TTd1*ones(1,sz(2));
d1_tf_MF = TRd1MF*bfd1MF+TTd1MF*ones(1,sz_MF(2));

figure
scatter(xd1_a, yd1_a,'filled','MarkerFaceColor','r')
hold on
scatter(d1_tf(1,:), d1_tf(2,:),'filled','MarkerFaceColor','b')
hold off
xlim([-lim lim])
ylim([0 2*lim])
title('without matching filter')


figure
scatter(afd1MF(1,:), afd1MF(2,:),'filled','MarkerFaceColor','r')
hold on
scatter(d1_tf_MF(1,:), d1_tf_MF(2,:),'filled','MarkerFaceColor','b')
hold off
xlim([-lim lim])
ylim([0 2*lim])
title('with matching filter')
