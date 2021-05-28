function plot_q(qdk,qmin,qmax, name, save)
figure('Name', name)
subplot(3,2,1);
% plot 1 here
x = [0 0 length(qdk(1,:)) length(qdk(1,:))];
Ymax = [0 qmin(1) qmin(1) 0];
Ymin = [0 qmax(1) qmax(1) 0];
area(x,Ymax,'FaceColor','#11d154','LineStyle', 'none')
hold on;
area(x,Ymin,'FaceColor','#11d154','LineStyle', 'none')
hold on;
alpha(0.25)
grid on;

plot(linspace(1,length(qdk(1,:)),length(qdk(1,:))), qdk(1,:),'Color','r');
title('Trajectory q_1')

subplot(3,2,2);
% plot 2 here
x = [0 0 length(qdk(2,:)) length(qdk(2,:))];
Ymax = [0 qmin(2) qmin(2) 0];
Ymin = [0 qmax(2) qmax(2) 0];
area(x,Ymax,'FaceColor','#11d154','LineStyle', 'none')
hold on;
area(x,Ymin,'FaceColor','#11d154','LineStyle', 'none')
hold on;
alpha(0.25)
grid on;

plot(linspace(1,length(qdk(2,:)),length(qdk(2,:))), qdk(2,:),'Color','r');
title('Trajectory q_2')


subplot(3,2,3);
% plot 3 here
x = [0 0 length(qdk(3,:)) length(qdk(3,:))];
Ymax = [0 qmin(3) qmin(3) 0];
Ymin = [0 qmax(3) qmax(3) 0];
area(x,Ymax,'FaceColor','#11d154','LineStyle', 'none')
hold on;
area(x,Ymin,'FaceColor','#11d154','LineStyle', 'none')
hold on;
alpha(0.25)
grid on;

plot(linspace(1,length(qdk(3,:)),length(qdk(3,:))), qdk(3,:),'Color','r');
title('Trajectory q_3')


subplot(3,2,4);
% plot 4 here
x = [0 0 length(qdk(4,:)) length(qdk(4,:))];
Ymax = [0 qmin(4) qmin(4) 0];
Ymin = [0 qmax(4) qmax(4) 0];
area(x,Ymax,'FaceColor','#11d154','LineStyle', 'none')
hold on;
area(x,Ymin,'FaceColor','#11d154','LineStyle', 'none')
hold on;
alpha(0.25)
grid on;

plot(linspace(1,length(qdk(4,:)),length(qdk(4,:))), qdk(4,:),'Color','r');
title('Trajectory q_4')


subplot(3,2,5);
% plot 5 here
x = [0 0 length(qdk(5,:)) length(qdk(5,:))];
Ymax = [0 qmin(5) qmin(5) 0];
Ymin = [0 qmax(5) qmax(5) 0];
area(x,Ymax,'FaceColor','#11d154','LineStyle', 'none')
hold on;
area(x,Ymin,'FaceColor','#11d154','LineStyle', 'none')
hold on;
alpha(0.25)
grid on;

plot(linspace(1,length(qdk(5,:)),length(qdk(5,:))), qdk(5,:),'Color','r');
title('Trajectory q_5')


subplot(3,2,6);
% plot 6 here
x = [0 0 length(qdk(6,:)) length(qdk(6,:))];
Ymax = [0 qmin(6) qmin(6) 0];
Ymin = [0 qmax(6) qmax(6) 0];
area(x,Ymax,'FaceColor','#11d154','LineStyle', 'none')
hold on;
area(x,Ymin,'FaceColor','#11d154','LineStyle', 'none')
hold on;
alpha(0.25)
grid on;

plot(linspace(1,length(qdk(6,:)),length(qdk(6,:))), qdk(6,:),'Color','r');
title('Trajectory q_6')

hold off


if (save)
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
saveas(gcf,[name '.pdf'])
end
end

