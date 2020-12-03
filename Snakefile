import pandas as pd

SRA_IDS=pd.read_csv("SRA_list.tsv", sep="\t")

rule all:
    input:
        expand("/touch/{sra}", sra = SRA_IDS),
        expand("/output/{sra}_metadata.tsv", sra = SRA_IDS)


rule touch:
    output:
        expand("/touch/{sra}", sra = SRA_IDS)
    shell:
        """
        touch {output}
        """


rule get_metadata:
    input:
        "/touch/{sra}"
    output:
        "/output/{sra}_metadata.tsv"
    shell:
        """
        pysradb metadata --db SRAmetadb.sqlite {input} --detailed --desc --expand --saveto {output}
        """

