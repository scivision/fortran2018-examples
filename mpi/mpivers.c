#include <stdio.h>
#include <mpi.h>

int main(int argc, char **argv)
{
   int id, Nimg, ierr, L;
   char version[MPI_MAX_LIBRARY_VERSION_STRING];

   ierr = MPI_Init(&argc,&argv);
   if(ierr != 0) {
      perror("could not init MPI");
      return 1;
   }

   ierr = MPI_Comm_rank(MPI_COMM_WORLD, &id);
   if(ierr != 0) {
      perror("could not get MPI rank");
      return 1;
   }
   MPI_Comm_size(MPI_COMM_WORLD, &Nimg);
   MPI_Get_library_version(version, &L);

   printf("MPI: Image %d / %d : %s",id, Nimg, version);

   ierr = MPI_Finalize();
   if(ierr != 0) {
      perror("could not close MPI");
      return 1;
   }

   return 0;
}
