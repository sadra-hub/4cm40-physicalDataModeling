%--------------------------------------------------------------
%  FINAL – Electromechanical Bilateral Coupling Block Diagram
%  • Boxes: 2‑units wide, placed 3‑units apart  ⇒ 0.5‑unit gap
%  • Horizontal arrows (→) draw through that gap so they are visible
%  • Only the electromechanical coupling (motor) has vertical double arrows
%  • Layout follows lecture Fig 3.9 / Fig 3.20 conventions:
%        – potentials on top row, flows on bottom row
%--------------------------------------------------------------
figure(1); clf; hold on; axis off equal;

% ---------- LAYOUT PARAMETERS ----------
X = 2:3:14;              % x‑centres (spacing = 3)
W = 2;   H = 1.2;        % box width & height
Yp = 8;  Yf = 2;         % y‑coordinates of rows

% ---------- LABELS ----------
Pot = {'V_r (Voltage)','R_m (Resistance)','L_m (Inductance)', ...
       '\omega_m (Angular Velocity)','Mechanical Load'};
Flo = {'i_m (Current)','\tau_m (Motor Torque)','J (Inertia)', ...
       'k,b (Spring,Damper)','T_e (Load Torque)'};

% ---------- DRAW BOXES & TEXT ----------
for k = 1:5
    rectangle('Position',[X(k)-W/2,Yp-H/2,W,H],'EdgeColor','b','LineWidth',2);
    text(X(k),Yp,Pot{k},'Horiz','center','FontSize',11);
    rectangle('Position',[X(k)-W/2,Yf-H/2,W,H],'EdgeColor','r','LineWidth',2);
    text(X(k),Yf,Flo{k},'Horiz','center','FontSize',11);
end

% ---------- HORIZONTAL ARROWS ----------
for k = 1:4
    % top row
    quiver(X(k)+W/2, Yp, X(k+1)-W/2-(X(k)+W/2), 0, 0, 'k','LineWidth',2,'MaxHeadSize',1);
    % bottom row
    quiver(X(k)+W/2, Yf, X(k+1)-W/2-(X(k)+W/2), 0, 0, 'k','LineWidth',2,'MaxHeadSize',1);
end

% ---------- VERTICAL BILATERAL COUPLING (motor) ----------
MotorIdx = [3 4];                     % L_m ↔ τ_m   and  ω_m ↔ τ_m
for idx = MotorIdx
    xc = X(idx);
    % dashed shaft
    plot([xc xc],[Yf+H/2 Yp-H/2],'k--','LineWidth',1);
    % double arrows
    quiver(xc, Yf+H/2, 0, 0.8, 0,'k','LineWidth',2,'MaxHeadSize',1.2);
    quiver(xc, Yp-H/2, 0,-0.8, 0,'k','LineWidth',2,'MaxHeadSize',1.2);
end

% ---------- ROW TITLES ----------
text(mean(X(1:3)),Yp+1.6,'Electrical Side','Color','b','FontWeight','bold','FontSize',12,'Horiz','center');
text(mean(X(4:5)),Yp+1.6,'Mechanical Side','Color','b','FontWeight','bold','FontSize',12,'Horiz','center');
text(0.5,Yp,'Generalized Potentials','FontWeight','bold','Horiz','right','FontSize',11);
text(0.5,Yf,'Generalized Flows','FontWeight','bold','Horiz','right','FontSize',11);

% ---------- TITLE ----------
title({'Electromechanical System – Bilateral Coupling Block Diagram', ...
       '(Potentials ↑, Flows ↓  •  Horizontal energy transport →)'}, ...
       'FontSize',13,'FontWeight','bold');

% ---------- EXPORT (trim whitespace) ----------
set(gcf,'Color','w');
exportgraphics(gcf,'fig_blockdiagram.pdf', ...
    'ContentType','vector', ...        % keep as PDF vector graphic
    'BackgroundColor','none', ...      % transparent background
    'Bounds','tight');                 % trims all outer margins

hold off;
