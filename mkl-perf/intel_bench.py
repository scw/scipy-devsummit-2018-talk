# Note this should be taken with a large grain of salt as it compares an
# entirely unoptimized build (e.g. no BLAS / LAPACK) to Intel's offering.
# from: https://software.intel.com/en-us/articles/numpyscipy-with-intel-mkl
import numpy as np
import time
N = 6000
M = 10000

k_list = [64, 80, 96, 104, 112, 120, 128, 144, 160,
          176, 192, 200, 208, 224, 240, 256, 384]


def get_gflops(m, n, k):
    return m*n*(2.0*k-1.0) / 1000**3

np.show_config()

# optionally control the number of threads:
# import os
# os.environ['OMP_NUM_THREADS'] = '1'

for K in k_list:
    a = np.array(np.random.random((M, N)), dtype=np.double, order='C', copy=False)
    b = np.array(np.random.random((N, K)), dtype=np.double, order='C', copy=False)
    A = np.matrix(a, dtype=np.double, copy=False)
    B = np.matrix(b, dtype=np.double, copy=False)

    C = A*B

    start = time.time()

    C = A*B
    C = A*B
    C = A*B
    C = A*B
    C = A*B

    end = time.time()

    tm = (end-start) / 5.0

    print ('{0:4}, {1:9.7}, {2:9.7}'.format(K, tm, get_gflops(M, N, K) / tm))
