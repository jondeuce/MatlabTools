#ifndef MAXIMUM_HPP
#define MAXIMUM_HPP

/* Disable debugging */
#ifndef NDEBUG
#define NDEBUG
#endif

#include "mex.h"
#include <math.h>
#include <stdint.h>
#include <omp.h>
#include <iostream>
#include <Eigen/Dense>

/* Eigen typedefs */
inline namespace Eigen {
    typedef Map<ArrayXd> VecXd;
    typedef Map<ArrayXf> VecXf;
}

template <typename Derived>
        inline auto maximum(
            const Eigen::ArrayBase<Derived>& x
        )
{
    omp_set_num_threads(omp_get_max_threads());
    Eigen::initParallel();
    return x.maxCoeff();
}

template <typename Derived>
        inline auto maximum_index(
            const Eigen::ArrayBase<Derived>& xr,
            const Eigen::ArrayBase<Derived>& xi
        )
{
    omp_set_num_threads(omp_get_max_threads());
    Eigen::initParallel();
    
    uint64_t i;
    (xr*xr+xi*xi).maxCoeff(&i);
    
    return i;
}

#endif //MAXIMUM_HPP