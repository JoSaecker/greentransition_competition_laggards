% Paper: "Investing in the Green Transition and Competition from Laggards", 
% Johanna Saecker & Philip Schnattinger.

% Description: Small model: the competition effect. 
% This file replicates Figure 4. Create a folder "figures" to save the figures. 
% Author: Johanna Saecker, last update: 8.12.2024, Matlab 2023b.

% Copyright (C) 2024 Johanna Saecker & Philip Schnattinger

% This is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%--------------------------------------------------------------------------

clear all;

%parameters in structure
par.siggma=3;   %Elasticity of substitution parameter
par.f=1;        %Production cost
par.c=2;        %Cost parameter

%define high and low values for n and ng
n_low=5; n_high=10;
ng_low=5; ng_high=10;


%% Figure: increase increase in the green policy probability (kappa)

z_vec=linspace(8,11,20);

%experiment: increase in the green policy probability
par.kappa=0.5;
par.kappa2=0.6;

%calculate curves (benefit-side (LHS), cost-side (RHS))
LHS1=@(z) par.kappa*z*ng_high^(1/(1-par.siggma))-par.f;
LHS2=@(z) par.kappa2*z*ng_high^(1/(1-par.siggma))-par.f;
RHS1=@(z) par.c./(z*(n_high^(1/(1-par.siggma))));

%calculate coordinates of intersections 
diff1=@(h) LHS1(h)-RHS1(h);
diff2=@(h) LHS2(h)-RHS1(h);

solx1=fzero(@(h) diff1(h),10.3);
soly1=LHS1(solx1);

solx2=fzero(@(h) diff2(h),8.5);
soly2=LHS2(solx2);

%x-coordinate for start of arrow
arrowdiff=abs(solx1-solx2);
arrowstart=solx2+0.8*arrowdiff;

figure
plot(z_vec,LHS1(z_vec),'b',z_vec,LHS2(z_vec),'b--',z_vec,RHS1(z_vec),'r','LineWidth',2); 
hold on 
plot([1 1]*solx1, [0 1]*soly1,'k--',[1 1]*solx2, [0 1]*soly2,'k--') 
hold off
legend('exp. profit, \kappa','exp. profit, \kappa \uparrow','cost', 'AutoUpdate','off','Location','northwest')
xlabel('productivity z')
xticks([8 9 10 11]);    %manually chosen (see above)
xticklabels({'0.84','0.95','1.05','1.16'}); %manually chosen as [8 9 10 11]/mean(z_vec)
ylabel('costs, expected profits')
set(gca,'FontSize',18)
%draw arrow
arrow = annotation('arrow');
arrow.Parent = gca;  
arrow.Position = [arrowstart, 0.25, -0.6*arrowdiff, 0];
%save
exportgraphics(gcf, [pwd '/figures/kappa.pdf'], 'ContentType', 'vector'); 



%% Figure: a high degree of current competition from laggards (N high)
 
%calculate curves (benefit-side (LHS), cost-side (RHS))
LHS1=@(z) par.kappa*z*ng_high^(1/(1-par.siggma))-par.f;
RHS1=@(z) par.c./(z*(n_low^(1/(1-par.siggma))));
RHS2=@(z) par.c./(z*(n_high^(1/(1-par.siggma))));

%calculate coordinates of intersections 
diff1=@(h) LHS1(h)-RHS1(h);
diff2=@(h) LHS1(h)-RHS2(h);

solx1=fzero(@(h) diff1(h),9.4);
soly1=LHS1(solx1);

solx2=fzero(@(h) diff2(h),10.2);
soly2=RHS2(solx2);

%x-coordinate for start of arrow
arrowdiff=abs(solx1-solx2);
arrowstart=solx1+0.2*arrowdiff;

figure
plot(z_vec,LHS1(z_vec),'b',z_vec,RHS1(z_vec),'r',z_vec,RHS2(z_vec),'r--','LineWidth',2); 
hold on 
plot([1 1]*solx1, [0 1]*soly1,'k--',[1 1]*solx2, [0 1]*soly2,'k--') 
hold off
legend('exp. profit','cost, N','cost, N \uparrow', 'AutoUpdate','off','Location','southwest')
xlabel('productivity z')
xticks([8 9 10 11]);
xticklabels({'0.84','0.95','1.05','1.16'});
ylabel('costs, expected profits')
set(gca,'FontSize',18)
%draw arrow
arrow = annotation('arrow');
arrow.Parent = gca;  
arrow.Position = [arrowstart, 0.25, 0.6*arrowdiff, 0];
%save
exportgraphics(gcf, [pwd '/figures/n_high.pdf'], 'ContentType', 'vector'); 



%% Figure: lower competition in a green economy (Ng low)

z_vec=linspace(6,12,20);

%calculate curves (benefit-side (LHS), cost-side (RHS))
LHS1=@(z) par.kappa*z*ng_high^(1/(1-par.siggma))-par.f;
LHS2=@(z) par.kappa*z*ng_low^(1/(1-par.siggma))-par.f;
RHS1=@(z) par.c./(z*(n_high^(1/(1-par.siggma))));

%calculate coordinates of intersections 
diff1=@(h) LHS1(h)-RHS1(h);
diff2=@(h) LHS2(h)-RHS1(h);

solx1=fzero(@(h) diff1(h),9.4);
soly1=LHS1(solx1);

solx2=fzero(@(h) diff2(h),10.2);
soly2=LHS2(solx2);

%x-coordinate for start of arrow
arrowdiff=abs(solx1-solx2);
arrowstart=solx2+0.8*arrowdiff;

figure
plot(z_vec,LHS1(z_vec),'b',z_vec,LHS2(z_vec),'b--',z_vec,RHS1(z_vec),'r','LineWidth',2); 
hold on 
plot([1 1]*solx1, [0 1]*soly1,'k--',[1 1]*solx2, [0 1]*soly2,'k--') 
hold off
legend('exp. profit, N_g','exp. profit, N_g \downarrow','cost', 'AutoUpdate','off','Location','northwest')
xlabel('productivity z')
xticks([6 8 10 12]);
xticklabels({'0.67','0.89','1.12','1.34'});     %[6 8 10 12]/mean(z_vec)
ylabel('costs, expected profits')
set(gca,'FontSize',18)
%draw arrow
arrow = annotation('arrow') ;
arrow.Parent = gca;  
arrow.Position = [arrowstart, 0.2, -0.6*arrowdiff, 0] ;
%save
exportgraphics(gcf, [pwd '/figures/ng_falls.pdf'], 'ContentType', 'vector'); 

