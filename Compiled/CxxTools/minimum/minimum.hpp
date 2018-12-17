#ifndef MINIMUM_HPP
#define MINIMUM_HPP

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
using VecXd = Eigen::Map<Eigen::ArrayXd>;
using VecXf = Eigen::Map<Eigen::ArrayXf>;
// inline namespace Eigen {
//     typedef Map<ArrayXd> VecXd;
//     typedef Map<ArrayXf> VecXf;
// }

template <typename Derived>
        inline auto minimum(
            const Eigen::ArrayBase<Derived>& x
        )
{
    omp_set_num_threads(omp_get_max_threads());
    Eigen::initParallel();
    return x.minCoeff();
}

template <typename Derived>
        inline auto minimum_index(
            const Eigen::ArrayBase<Derived>& xr,
            const Eigen::ArrayBase<Derived>& xi
        )
{
    omp_set_num_threads(omp_get_max_threads());
    Eigen::initParallel();
    
    uint64_t i;
    (xr*xr+xi*xi).minCoeff(&i);
    
    return i;
}

#endif //MINIMUM_HPP