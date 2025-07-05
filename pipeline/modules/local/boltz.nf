process BOLTZ {
    tag "$meta.id"
    // label 'process_gpu'
    label 'batch_gpu_queue'

    container "${params.aws_account_id}.dkr.ecr.${params.region}.amazonaws.com/boltz:2.0.2"

    input:
    tuple val(meta), path(chain_config)

    output:
    tuple val(meta), path("${prefix}"), emit: peptides
    path "versions.yml"               , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    boltz predict \\
        $args \\
        --out_dir ${prefix} \\
        $chain_config

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Boltz: \$(python3 -c "import boltz; print(boltz.__version__)")
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    touch ${prefix}/foo.txt

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Boltz: \$(python3 -c "import boltz; print(boltz.__version__)")
    END_VERSIONS
    """
}
