#!/usr/bin/bash

nextflow run \
    main.nf \
    --input ../data/dev_samplesheet.csv \
    --outdir ./results \
    -profile awsbatch,docker,gpu \
    -w s3://link-nextflow-workdir \
    -resume \
    -stub-run
    
