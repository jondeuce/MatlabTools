% Successive over-relaxation smoothing for the transmag-diffusion problem

if ispc
    % complex double version
    % mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread -fopenmp" ...
    %     COPTIMFLAGS="-march=native -msse2 -msse3 -O3 -flto -DNDEBUG" ...
    %     LDOPTIMFLAGS="-O3 -flto" ...
    %     -I'C:\Users\Jonathan\TDM-GCC\lib\gcc\x86_64-w64-mingw32\5.1.0' ...
    %     -L'C:\Users\Jonathan\TDM-GCC\lib\gcc\x86_64-w64-mingw32\5.1.0\libgomp.a' ...
    %     sor_diffuse_cd.c
    
    mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread" ...
        COPTIMFLAGS="-march=native -msse2 -msse3 -O3 -flto -DNDEBUG" ...
        LDOPTIMFLAGS="-O3 -flto" ...
        sor_diffuse_cd.c
else
    % complex double version
    mex CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread -fopenmp" ...
        COPTIMFLAGS="-march=native -msse2 -msse3 -O3 -flto -DNDEBUG" ...
        LDOPTIMFLAGS="-O3 -flto" ...
        -lgomp sor_diffuse_cd.c
end