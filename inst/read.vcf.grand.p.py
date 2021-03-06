#!/usr/bin/env python3

import re  # regular expression
import sys
import gzip
import argparse
import os

parser = argparse.ArgumentParser(description='Create a file containing the parental and offspring genotypes')
parser.add_argument('--ID_of', help='A list of offsprings names', type=str, nargs='+')
parser.add_argument('Fid_h', help='A grand parent: Side:Father, Pheno: High', type=str)
parser.add_argument('Mid_h', help='A grand parent: Side:Mother, Pheno: High', type=str)
parser.add_argument('Fid_l', help='A grand parent: Side:Father, Pheno: Low', type=str)
parser.add_argument('Mid_l', help='A grand parent: Side:Mother, Pheno: Low', type=str)

parser.add_argument('vcf_file', help='The gVCF with all the SNPs for all individuals', type=str)
parser.add_argument('out_folder', help='A folder to put the outputs ', type=str)
args = parser.parse_args()

ID_of_List = args.ID_of
Fid_h = args.Fid_h
Mid_h = args.Mid_h
Fid_l = args.Fid_l
Mid_l = args.Mid_l
vcf_file = args.vcf_file

out_folder = args.out_folder 

out_files = dict()
for ID_of in ID_of_List:
    out_files[ID_of] =  open(os.path.join(out_folder, ID_of + ".vcf"), "wt")

# outFile = open(out_file, "wt")

# TODO ASK YANJUN WHY A LIST
def find_index(name, line):
    indices = []
    for i, elem in enumerate(line):
        if re.match(name, elem):
            indices.append(i)
    return indices


def get_geno(x):
    tmp = x.split(":")[0].split("/")
    if tmp[0] == ".":
        return [5, 5]
    else:
        return tmp

with gzip.open(vcf_file, "rb") as vcf:
    for line in vcf:
        if line[0:2] == b"##":
            continue
        elif line[0] == b"\n":
            continue
        elif b"#CHROM" in line:
            line = line.decode().rstrip("\n")
            header = line.split("\t")
            index_off_Dict = dict()
            for ID_of in ID_of_List:
                index_off_Dict[ID_of] = find_index(ID_of, header)
            index_F_h = find_index(Fid_h, header)
            index_M_h = find_index(Mid_h, header)
            index_F_l = find_index(Fid_l, header)
            index_M_l = find_index(Mid_l, header)
        elif line == b"\n":
            continue
        else:
            line = line.decode().rstrip("\n")
            con = line.split("\t")
            Chr = con[0]
            Pos = con[1]
            ID = con[2]
            REF = con[3]
            ALT = con[4]
            if len(REF) > 1 or len(ALT) > 1:
                continue
            else:
                geno_F1_h = int(get_geno(con[index_F_h[0]])[0])
                geno_F2_h = int(get_geno(con[index_F_h[0]])[1])
                # geno_F1_h, geno_F2_h = [ int(e) for e in get_geno(con[index_F_h[0]])]
                geno_M1_h = int(get_geno(con[index_M_h[0]])[0])
                geno_M2_h = int(get_geno(con[index_M_h[0]])[1])
                geno_F1_l = int(get_geno(con[index_F_l[0]])[0])
                geno_F2_l = int(get_geno(con[index_F_l[0]])[1])
                geno_M1_l = int(get_geno(con[index_M_l[0]])[0])
                geno_M2_l = int(get_geno(con[index_M_l[0]])[1])
                # Check if the (4 great parents * 2 alleles = 8) alleles are fixed in the High (0 or 4 in the 2nd part) and fixed the other way in Low (total = 4)
                if sum([geno_F1_h, geno_F2_h, geno_M1_h, geno_M2_h, geno_F1_l, geno_F2_l, geno_M1_l, geno_M2_l]) == 4  and (sum([geno_F1_h, geno_F2_h, geno_M1_h, geno_M2_h]) == 0 or sum([geno_F1_h, geno_F2_h, geno_M1_h, geno_M2_h]) == 4 ):
                    for ID_of in ID_of_List:
                        geno_of1 = int(get_geno(con[index_off_Dict[ID_of][0]])[0])
                        geno_of2 = int(get_geno(con[index_off_Dict[ID_of][0]])[1])
                        if geno_of1 == 5 or geno_of2 == 5:
                            continue
                        else:
                            print(Chr, Pos, REF, ALT, geno_F1_h, geno_M2_h, geno_F1_l, geno_M2_l, geno_of1, geno_of2, sep="\t", file = out_files[ID_of])

[outFile.close() for outFile in out_files.values()]
