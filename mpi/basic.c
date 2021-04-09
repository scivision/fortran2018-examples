#include <stdio.h>
#include <mpi.h>

int main(int argc, char **argv)
{
   int ierr;

   printf("going to init MPI\n");

   ierr = MPI_Init(&argc,&argv);
   if(ierr != 0) {
      perror("could not init MPI\n");
      return 1;
   }
   printf("MPI Init OK\n");

   ierr = MPI_Finalize();
   if(ierr != 0) {
      perror("could not close MPI\n");
      return 1;
   }

   printf("MPI closed\n");

   return 0;
}
