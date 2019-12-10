// NOTE: extern "C" is necessary to get the function name in the library to be "timestwo"
// as seen by
// nm libcxx.a
// or whatever you name this library file.

extern "C" void timestwo(double x[], double x2[], int N){
  for (auto i=0; i<N; i++)
    x2[i] = x[i] * 2;
}
