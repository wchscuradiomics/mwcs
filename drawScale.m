function drawScale(x,y,scale)

if nargin == 2
  scale = x;
end
  
for i=1:length(x)
  hold on;
  p1 = [x(i) x(i)];
  p2 = [y y+8];
  line(p1,p2,'color','k');
  text(x(i)-0.1,y-8,num2str(scale(i),'%3.2f'),'fontSize',8);
end