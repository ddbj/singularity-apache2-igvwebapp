#!/bin/bash

module load singularity/3.5.2

CONTAINER="apache_igvwebapp"

singularity instance stop ${CONTAINER}
