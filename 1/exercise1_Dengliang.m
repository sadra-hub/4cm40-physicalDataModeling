% Excercise 1.a
% Extract time and signal data from 'out'
time = out.tout;  % Simulation time
phi_i_data = out.scope_phi_i.signals.values;  % φ_i(t) data
phi_o_data = out.scope_phi_o.signals.values;  % φ_o(t) data
h_data = out.scope_h.signals.values;  % h(t) data
p_i_data = out.scope_p_i.signals.values;  % p_i(t) data
m_data = out.scope_m.signals.values;  % m(t) data

% Create the figure
figure;

% First plot (top left)
subplot(3,2,1);  % Row 1, Column 1
plot(time, phi_i_data, 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('\phi_i(t) [m^3/s]'); title('Flow In'); grid on;
xlim([0, max(time)]); ylim([min(phi_i_data)-1e-4, max(phi_i_data)+1e-4]);  % Add margin

% Second plot (top right)
subplot(3,2,2);  % Row 1, Column 2
plot(time, h_data, 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('h(t) [m]'); title('Fluid Level'); grid on;
xlim([0, max(time)]); ylim([min(h_data)-0.2, max(h_data)+0.2]);  % Add margin

% Third plot (bottom left)
subplot(3,2,3);  % Row 2, Column 1
plot(time, phi_o_data, 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('\phi_o(t) [m^3/s]'); title('Flow Out'); grid on;
xlim([0, max(time)]); ylim([min(phi_o_data)-1e-4, max(phi_o_data)+1e-4]);  % Add margin

% Fourth plot (bottom right)
subplot(3,2,4);  % Row 2, Column 2
plot(time, p_i_data, 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('p_i(t) [Pa]'); title('Valve Inlet Pressure'); grid on;
xlim([0, max(time)]); ylim([min(p_i_data)-1000, max(p_i_data)+1000]);  % Add margin

% Fifth plot (bottom left)
subplot(3,2,5);  % Row 3, Column 1 (bottom left)
plot(time, m_data, 'LineWidth', 1.5);
xlabel('Time [s]'); ylabel('m(t) [kg]'); title('Mass m(t)'); grid on;
xlim([0, max(time)]); ylim([min(m_data)-100, max(m_data)+100]);  % Add margin

% Main title for the entire figure
sgtitle('Response of fluid buffering vessel on step in inlet flow, valve opening fixed');

% Adjust the size of the entire figure window
set(gcf, 'Position', [100, 100, 800, 800]);

% Adjust the position of each subplot to ensure they do not overlap
set(gca, 'Position', [0.1, 0.7, 0.35, 0.25]);  % First plot
set(gca, 'Position', [0.55, 0.7, 0.35, 0.25]);  % Second plot
set(gca, 'Position', [0.1, 0.35, 0.35, 0.25]);  % Third plot
set(gca, 'Position', [0.55, 0.35, 0.35, 0.25]);  % Fourth plot
set(gca, 'Position', [0.3, 0.05, 0.35, 0.25]);  % Fifth plot, bottom left

% Excercise 1.c

% Extract time and signal data from 'out'
t1 = out.Delta_m.time;
Delta_m_1 = out.Delta_m.signals.values;
m_diff_1 = out.m_nl.signals.values - out.m_star.signals.values;

t2 = out.Delta_m_large.time;
Delta_m_2 = out.Delta_m_large.signals.values;
m_diff_2 = out.m_nl_large.signals.values - out.m_star.signals.values;

% Plot
figure;

% 1st subplot (Av = 1e-5)
subplot(2,1,1);
plot(t1, m_diff_1, 'b', 'LineWidth', 1.5); hold on;
plot(t1, Delta_m_1, 'r--', 'LineWidth', 1.5);
title('Deviation in m(t) for A_v amplitude = 10^{-5} m^2', 'FontSize', 14);
ylabel('\Delta m(t) [kg]', 'FontSize', 12);
legend('m_{nl} - m^*', 'Linearized \Delta m', 'FontSize', 12, 'Location', 'best');
grid on;

% 2nd subplot (Av = 1e-4)
subplot(2,1,2);
plot(t2, m_diff_2, 'b', 'LineWidth', 1.5); hold on;
plot(t2, Delta_m_2, 'r--', 'LineWidth', 1.5);
title('Deviation in m(t) for A_v amplitude = 10^{-4} m^2', 'FontSize', 14);
xlabel('Time [s]', 'FontSize', 12);
ylabel('\Delta m(t) [kg]', 'FontSize', 12);
legend('m_{nl} - m^*', 'Linearized \Delta m', 'FontSize', 12, 'Location', 'best');
grid on;

% Excercise 1.d
t = out.tout;

h_nl_affine = out.h_nl_affine.signals.values;       % nonlinear response with affine A(h)
h_star_afiine = out.h_star_affine.signals.values;   % nominal response with affine A(h)
h_lin_old = out.h_lin_original.signals.values;  % original linearized prediction
h_lin_new = out.h_lin_affine.signals.values;    % updated linearized prediction

% Plot comparison
figure;
plot(t, h_nl_affine - h_star_afiine, 'k', 'LineWidth', 1.5); hold on;
plot(t, h_lin_old, 'r--', 'LineWidth', 1.5);
plot(t, h_lin_new, 'b:', 'LineWidth', 1.5);
legend('True \Delta h = h_{nl} - h^*', 'Linearized (original)', 'Linearized (affine A(h))');
xlabel('Time [s]');
ylabel('\Delta h(t) [m]');
title('Comparison of Deviation Trajectories');
grid on;

