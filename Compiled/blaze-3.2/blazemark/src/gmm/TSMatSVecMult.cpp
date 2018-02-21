//=================================================================================================
/*!
//  \file src/gmm/TSMatSVecMult.cpp
//  \brief Source file for the GMM++ transpose sparse matrix/sparse vector multiplication kernel
//
//  Copyright (C) 2012-2017 Klaus Iglberger - All Rights Reserved
//
//  This file is part of the Blaze library. You can redistribute it and/or modify it under
//  the terms of the New (Revised) BSD License. Redistribution and use in source and binary
//  forms, with or without modification, are permitted provided that the following conditions
//  are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of
//     conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice, this list
//     of conditions and the following disclaimer in the documentation and/or other materials
//     provided with the distribution.
//  3. Neither the names of the Blaze development group nor the names of its contributors
//     may be used to endorse or promote products derived from this software without specific
//     prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
//  SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
//  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
//  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
//  DAMAGE.
*/
//=================================================================================================


//*************************************************************************************************
// Includes
//*************************************************************************************************

#include <iostream>
#include <gmm/gmm.h>
#include <blaze/util/Timing.h>
#include <blazemark/gmm/init/CSCMatrix.h>
#include <blazemark/gmm/init/RSVector.h>
#include <blazemark/gmm/TSMatSVecMult.h>
#include <blazemark/system/Config.h>


namespace blazemark {

namespace gmm {

//=================================================================================================
//
//  KERNEL FUNCTIONS
//
//=================================================================================================

//*************************************************************************************************
/*!\brief GMM++ transpose sparse matrix/sparse vector multiplication kernel.
//
// \param N The number of rows and columns of the matrix and the size of the vector.
// \param F The number of non-zero elements in each column of the sparse matrix and in the sparse vector.
// \param steps The number of iteration steps to perform.
// \return Minimum runtime of the kernel function.
//
// This kernel function implements the transpose sparse matrix/sparse vector multiplication by
// means of the GMM++ functionality.
*/
double tsmatsvecmult( size_t N, size_t F, size_t steps )
{
   using ::blazemark::element_t;

   ::blaze::setSeed( seed );

   ::gmm::csc_matrix<element_t> A( N, N );
   ::gmm::rsvector<element_t> a( N ), b( N );
   ::blaze::timing::WcTimer timer;

   init( A, F );
   init( a, F );

   mult( A, a, b );

   for( size_t rep=0UL; rep<reps; ++rep )
   {
      timer.start();
      for( size_t step=0UL; step<steps; ++step ) {
         mult( A, a, b );
      }
      timer.end();

      if( vect_size(b) != N )
         std::cerr << " Line " << __LINE__ << ": ERROR detected!!!\n";

      if( timer.last() > maxtime )
         break;
   }

   const double minTime( timer.min()     );
   const double avgTime( timer.average() );

   if( minTime * ( 1.0 + deviation*0.01 ) < avgTime )
      std::cerr << " GMM++ kernel 'tsmatsvecmult': Time deviation too large!!!\n";

   return minTime;
}
//*************************************************************************************************

} // namespace gmm

} // namespace blazemark
