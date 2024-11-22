/*  
 *  Copyright 2020 Francesco Gozzini < gozzini AT cpt.univ-mrs.fr >
 *
 *  This file is part of SL2CFOAM-NEXT.
 *
 *  SL2CFOAM-NEXT is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU Lesser General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  SL2CFOAM-NEXT is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *  See the GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with SL2CFOAM-NEXT. If not, see <http://www.gnu.org/licenses/>.
 */

///////////////////////////////////////////////////////////////
// Setup functions.
// Initialize various configurataions at start.
///////////////////////////////////////////////////////////////

#include <dirent.h> 
#include <string.h>
#include <sys/stat.h>
#include <mpfr.h>
#include <omp.h>

#include "common.h"
#include "sl2cfoam.h"
#include "sl2cfoam_tensors.h"
#include "wigxjpf.h"
#include "utils.h"
#include "error.h"
#include "mpi_utils.h"


#ifdef USE_MPI
// stores if MPI was found to be initialized outside the library
static bool __mpi_managed_outside;
#endif



void sl2cfoam_init_conf(char* root_folder, double Immirzi, struct sl2cfoam_config* conf) {

    // check root folder is accessible
    DIR *d = opendir(root_folder);
    if (d == NULL) error("error opening root folder");
    closedir(d);

    DATA_ROOT = strdup(root_folder);

    memcpy(&CONFIG, conf, sizeof(struct sl2cfoam_config));

    // set Immirzi and create folder structure
    sl2cfoam_set_Immirzi(Immirzi);

    sl2cfoam_set_verbosity(conf->verbosity);
    sl2cfoam_set_accuracy(conf->accuracy);
    
    // initialize wigxjpf
    wig_table_init(conf->max_two_spin, 6);


    // enable OMP parallelization by default
    OMP_PARALLELIZE = true;

    // no nested parallelism
    omp_set_max_active_levels(1);

    // setup BLAS libraries
    #ifdef USE_MKL

    // 64bit interface
    mkl_set_interface_layer(MKL_INTERFACE_ILP64);

    // disable builtin threading
    mkl_set_threading_layer(MKL_THREADING_SEQUENTIAL);

    #elif USE_SYSBLAS

    #ifdef OPENBLAS_THREAD
    openblas_set_num_threads(1)
    #endif

    #endif

    // if library is compiled for MPI
    // initialize MPI if it's not already initialized
    // needed for using as shared library
    // runs on a single node if not called with mpirun
    #ifdef USE_MPI

    int mpi_initialized;
    MPI_Initialized(&mpi_initialized);
    if (!mpi_initialized) {
        MPI_Init(NULL, NULL);
        __mpi_managed_outside = false;
    } else {
        __mpi_managed_outside = true;
    }

    #endif

}

void sl2cfoam_init(char* root_folder, double Immirzi) {
	
    struct sl2cfoam_config def;
    def.verbosity = SL2CFOAM_VERBOSE_OFF;
    def.accuracy = SL2CFOAM_ACCURACY_NORMAL;
    def.max_two_spin = 3 * 2 * 50;

    sl2cfoam_init_conf(root_folder, Immirzi, &def);

}

void sl2cfoam_free() {
	
    // wigxjpf
    wig_table_free();

    // free paths
    free(DATA_ROOT);
    free(DIR_BOOSTERS);
    free(DIR_AMPLS);

    #ifdef USE_MPI

    if (!__mpi_managed_outside) {
        MPI_Finalize();
    }
    
    #endif

}
