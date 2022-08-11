#include <ctime>
#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <iostream>
#include <stdlib.h>
#include <string>
#include <thrust/copy.h>
#include <thrust/count.h>
#include <thrust/device_vector.h>
#include <thrust/execution_policy.h>
#include <thrust/host_vector.h>

using namespace std;

template <typename T>
struct VectorS
{
    bool GH = false;
    T Array[10];
};

template <typename T>
struct PredicateM
{
    __host__ __device__ bool operator()(const VectorS<T> &x) const
    {
        return x.GH;
    };
};

int main()
{

    thrust::host_vector<VectorS<double>> ARR(10);
    ARR[0].GH = true;
    ARR[5].GH = true;

    int result = thrust::count_if(ARR.begin(), ARR.end(), PredicateM<double>());
    cout << result << endl;
    return 0;
};