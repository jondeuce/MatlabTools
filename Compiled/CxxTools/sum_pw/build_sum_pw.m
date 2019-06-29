CALLING_DIRECTORY = pwd;
cd(fileparts(mfilename('fullpath')));

%==========================================================================
% Summing by Pairwise summation (treats ND arrays as 1D)
%==========================================================================

if ispc
    mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -lpthread" ...
        COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
        LDOPTIMFLAGS="-Ofast -flto" ...
        sum_pw.c
else
    % Optimizations on
    mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -lpthread -fopenmp" ...
        COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
        LDOPTIMFLAGS="-Ofast -flto" ...
        -lgomp sum_pw.c
end

cd(CALLING_DIRECTORY)
clear CALLING_DIRECTORY
