#!/usr/bin/python

import re
import sys
import gzip
import argparse
import os

parser = argparse.ArgumentParser(description='Create a file containing the parental and offspring genotypes')
parser.add_argument('--ID_of', help='A list of offsprings names', type=str, nargs='+')
parser.add_argument('Fid', help='A grand parent: Side:Father, Pheno: High', type=str)
parser.add_argument('Mid', help='A grand parent: Side: Mother, Pheno: low', type=str)
parser.add_argument('vcf_file', help='The gVCF with all the SNPs for all individuals', type=str)
parser.add_argument('out_folder', help='A folder to put the outputs ', type=str)
args = parser.parse_args()

ID_of_List = args.ID_of
Fid = args.Fid
Mid = args.Mid

vcf_file = args.vcf_file
out_folder = args.out_folder

out_files = dict()
for ID_of in ID_of_List:
    out_files[ID_of] =  open(os.path.join(out_folder, ID_of + ".vcf"), "wt")


def find_index(name, lines):
    indices = []
    for i, elem in enumerate(lines):
        if re.match(name, elem):
            indices.append(i)
    return indices


def get_geno(x):
    if re.match("^\.", x):
        return [5, 5]
    else:
        out = re.match("(\d{1}).{1}(\d{1}).*", x)
        return out.group(1, 2)


with gzip.open(vcf_file, "rb") as vcf:
    for line in vcf:
        if re.match(b"^##", line):
            continue
        elif re.match(b"^#CHROM", line):
            line = line.decode().rstrip("\n")
            header = re.split("\t", line)
            index_off_Dict = dict()
            for ID_of in ID_of_List:
                index_off_Dict[ID_of] = find_index(ID_of, header)
            index_F = find_index(Fid, header)
            index_M = find_index(Mid, header)
            #  print(index_off, index_F, index_M)
        elif line == b"\n":
            continue
        else:
            line = line.decode().rstrip("\n")
            con = re.split("\t", line)
            Chr = con[0]
            Pos = con[1]
            ID = con[2]
            REF = con[3]
            ALT = con[4]
            if len(REF) > 1 or len(ALT) > 1:
                pass
            elif re.match("\.", con[index_F[0]]):
                pass
            elif re.match("\.", con[index_M[0]]):
                pass
            else:
                #geno_of1 = int(get_geno(con[index_off[0]])[0])
                #geno_of2 = int(get_geno(con[index_off[0]])[1])
                geno_F1 = int(get_geno(con[index_F[0]])[0])
                geno_F2 = int(get_geno(con[index_F[0]])[1])
                geno_M1 = int(get_geno(con[index_M[0]])[0])
                geno_M2 = int(get_geno(con[index_M[0]])[1])
                if not (sum([geno_F1, geno_F2, geno_M1, geno_M2]) == 0 or sum([geno_F1, geno_F2, geno_M1, geno_M1]) == 4):
                    for ID_of in ID_of_List:
                        geno_of1 = int(get_geno(con[index_off_Dict[ID_of][0]])[0])
                        geno_of2 = int(get_geno(con[index_off_Dict[ID_of][0]])[1])
                        if geno_of1 == 5 or geno_of2 == 5:
                            continue
                        else:
                            print(Chr, Pos, REF, ALT, geno_F1, geno_F2, geno_M1, geno_M2, geno_of1, geno_of2,
                                  sep="\t", file=out_files[ID_of])

[outFile.close() for outFile in out_files.values()]

