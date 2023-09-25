

reads = Channel.fromPath("${params.inputDir}").toList()

// Define the process to run FastQC
process fastqc {
    container params.fastqcImage
    publishDir "/mnt/workflow/pubdir"

    input:
    path fastqfile

    output:
    path '*'

    script:
    """
    fastqc ${fastqfile}
    """
}





// Define the workflow
workflow {

    data = Channel.fromPath(params.inputDir)
    // chromosome_ch = Channel.fromList(params.chromosomes)
    // Run FastQC on all input FASTQ files
    fastqc(data)

}