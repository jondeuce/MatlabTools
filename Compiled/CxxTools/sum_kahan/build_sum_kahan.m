CALLING_DIRECTORY = pwd;
cd(fileparts(mfilename('fullpath')));

%==========================================================================
% Summing by Kahan summation (treats ND arrays as 1D)
%==========================================================================

if ispc
    % Optimizations on
    mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -lpthread" ...
        COPTIMFLAGS="-march=native -msse2 -msse3 -O3 -flto -DNDEBUG" ...
        LDOPTIMFLAGS="-O3 -flto" ...
        sum_kahan.c
else
    % Optimizations on
    mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -lpthread -fopenmp" ...
        COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
        LDOPTIMFLAGS="-Ofast -flto" ...
        -lgomp sum_kahan.c
end

cd(CALLING_DIRECTORY)
clear CALLING_DIRECTORY
