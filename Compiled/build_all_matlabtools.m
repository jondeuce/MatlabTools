try
    build_diffusion_problem;
catch e
    warning(e.message);
end

try
    build_conv_even_per;
catch e
    warning(e.message);
end

try
    build_conv_per;
catch e
    warning(e.message);
end

try
    build_fmg_lap_per;
catch e
    warning(e.message);
end

try
    build_prolong;
catch e
    warning(e.message);
end

try
    build_sor_diffuse;
catch e
    warning(e.message);
end

try
    build_sum_kahan;
catch e
    warning(e.message);
end

try
    build_sum_pw;
catch e
    warning(e.message);
end

% Not necessary - MATLAB version is fast enough
% try
%     build_infnorm;
% catch e
%     warning(e.message);
% end
