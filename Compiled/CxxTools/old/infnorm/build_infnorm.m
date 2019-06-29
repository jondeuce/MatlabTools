CALLING_DIRECTORY = pwd;
cd(fileparts(mfilename('fullpath')));

%==========================================================================
% infinity norm of array (treats ND arrays as 1D)
%==========================================================================

if ispc
    mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread" ...
        COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
        LDOPTIMFLAGS="-Ofast -flto" ...
        infnorm.c
else
    mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread -fopenmp" ...
        COPTIMFLAGS="-march=native -msse2 -msse3 -Ofast -flto -DNDEBUG" ...
        LDOPTIMFLAGS="-Ofast -flto" ...
        -lgomp infnorm.c
end

cd(CALLING_DIRECTORY)
clear CALLING_DIRECTORY
