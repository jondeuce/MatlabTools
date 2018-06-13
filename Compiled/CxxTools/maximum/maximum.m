function c=maximum(x)
%MAXIMUM

% Build maximum.cpp on first call
currentpath = cd;
cd(fileparts(mfilename('fullpath')));
build_maximum;
cd(currentpath);

% Call compiled code
c=maximum(x);

end

function build_maximum

EigenPath = what('Eigen');
libincludes = {['-I"',EigenPath(1).path,'"']};
% BlazePath = what('blaze-3.2');
% libincludes = {['-I"',EigenPath(1).path,'"'],['-I"',BlazePath(1).path,'"']};
Cflags = '-O3 -mavx -mfma -DNDEBUG';
if isunix; Cflags = [Cflags,' -lgomp -fopenmp']; end

if ispc
    CFLAGS = ['CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread ',Cflags,'"'];
    COPTIMFLAGS = ['COPTIMFLAGS="-march=native -msse2 -msse3 -O3 -flto -DNDEBUG ',Cflags,'"'];
    CXXFLAGS = ['CXXFLAGS="\$CXXFLAGS ',Cflags,'"'];
    LDOPTIMFLAGS = ['LDOPTIMFLAGS="-O3 -flto ',Cflags,'"'];
elseif isunix
    CFLAGS = ['CFLAGS="-fexceptions -fPIC -fno-omit-frame-pointer -pthread -fopenmp ',Cflags,'"'];
    COPTIMFLAGS = ['COPTIMFLAGS="-march=native -msse2 -msse3 -O3 -flto -DNDEBUG ',Cflags,'"'];
    CXXFLAGS = ['CXXFLAGS="\$CXXFLAGS -std=c++1y"'];
    LDOPTIMFLAGS = ['LDOPTIMFLAGS="-O3 -flto ',Cflags,'"'];
end

mex(CFLAGS,COPTIMFLAGS,CXXFLAGS,LDOPTIMFLAGS,libincludes{:},'maximum.cpp');
%'OMP_NUM_THREADS=4',
end