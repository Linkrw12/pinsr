process PROTEINMPNN {
    tag "$meta.id"
    label "process_medium"

    container "protein-mpnn:1.0.1"
    // {}.dkr.ecr.us-east-1.amazonaws.com/aws-batch-test

    input:
    tuple val(meta), path(pdb)

    output:
    path "${prefix}/seqs/*.fa", emit: peptides
    path "versions.yml"       , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    python3 protein_mpnn_run.py \
        --pdb_path ${pdb} \
        --pdb_path_chains D \
        --out_folder ${prefix} \
        --seed 255 \
        --num_seq_per_target 5 \
        --sampling_temp 0.15

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        proteinmpnn: v1.0.1-18-g8907e66
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    mkdir -p ${prefix}/seqs
    touch ${prefix}/seqs/${prefix}.fa

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        proteinmpnn: v1.0.1-18-g8907e66
    END_VERSIONS
    """
}
