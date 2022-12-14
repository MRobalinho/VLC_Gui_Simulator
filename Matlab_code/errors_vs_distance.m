function errors = errors_vs_distance(dist_range, power, irradiance_ambient, constants)
% Note that distributions is a function that has some fixed values.
% x1 = [ 'Error vs Distance function: dist_range:', num2str(dist_range),...
%     ' power:', num2str(power), ' irradiance:', num2str(irradiance_ambient),...
%     ' constants:', num2str(constants)];
% disp(x1);

errors = zeros(1, length(dist_range));
i = 1;
for distance = dist_range
    [mu1, sigma1, mu2, sigma2] = noise_and_signal_dist(power, irradiance_ambient, distance, constants);
    errors(i) = calculate_error(mu1, sigma1, mu2, sigma2);
    i = i + 1;
end
end
