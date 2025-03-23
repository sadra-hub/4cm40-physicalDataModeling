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