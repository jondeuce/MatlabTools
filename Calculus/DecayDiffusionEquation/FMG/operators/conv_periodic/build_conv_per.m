%==========================================================================
% periodic convolution
%==========================================================================

CALLING_DIRECTORY = pwd;
cd(fileparts(mfilename('fullpath')));

%--------------------------------------------------------------------------
% With OpenMP
%--------------------------------------------------------------------------

% complex double version
mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread -fopenmp" ...
    LD_PRELOAD="/usr/lib/gcc/x86_64-linux-gnu/4.9/libgomp.so" ...
    COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
    LDOPTIMFLAGS="-Ofast -flto" ...
    -lgomp conv_per_d.c

% complex double version
mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread -fopenmp" ...
    LD_PRELOAD="/usr/lib/gcc/x86_64-linux-gnu/4.9/libgomp.so" ...
    COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
    LDOPTIMFLAGS="-Ofast -flto" ...
    -lgomp conv_per_cd.c

%--------------------------------------------------------------------------
% Without OpenMP
%--------------------------------------------------------------------------

% % complex double version
% mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread" ...
%     COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
%     LDOPTIMFLAGS="-Ofast -flto" ...
%     conv_per_d.c
% 
% % complex double version
% mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread" ...
%     COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
%     LDOPTIMFLAGS="-Ofast -flto" ...
%     conv_per_cd.c

cd(CALLING_DIRECTORY)
clear CALLING_DIRECTORY
