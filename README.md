# proteomics_utilites
A small toolkit for processing files necessary for proteomics analysis including making a decoy FASTA file.

# Description
This script takes one FASTA file as an input and reverses the N and C terminus amino acids. It returns a FASTA formatted file using the header information provided. It returns a combined file with the original and reverse sequences. The reverse sequences have a header line annotated ">REVERSE_..."

# Usage: decoy_fasta.pl <file.fasta> 

##Example Input  
	```>sp|P62258|1433E_HUMAN 14-3-3 protein epsilon OS=Homo sapiens GN=YWHAE PE=1 SV=1
	MDDREDLVYQAKLAEQAERYDEMVESMKKVAGMDVELTVEERNLLSVAYKNVIGARRASWRIISSIEQKE
	ENKGGEDKLKMIREYRQMVETELKLICCDILDVLDKHLIPAANTGESKVFYYKMKGDYHRYLAEFATGND
	RKEAAENSLVAYKAASDIAMTELPPTHPIRLGLALNFSVFYYEILNSPDRACRLAKAAFDDAIAELDTLS
	EESYKDSTLIMQLLRDNLTLWTSDMQGDGEEQNKEALQDVEDENQ```

##Example Output  
	```>sp|P62258|1433E_HUMAN 14-3-3 protein epsilon OS=Homo sapiens GN=YWHAE PE=1 SV=1
	MDDREDLVYQAKLAEQAERYDEMVESMKKVAGMDVELTVEERNLLSVAYKNVIGARRASWRIISSIEQKEENKGGEDKLKMIREYRQMVETELKLICCDILDVLDKHLIPAANTGESKVFYYKMKGDYHRYLAEFATGNDRKEAAENSLVAYKAASDIAMTELPPTHPIRLGLALNFSVFYYEILNSPDRACRLAKAAFDDAIAELDTLSEESYKDSTLIMQLLRDNLTLWTSDMQGDGEEQNKEALQDVEDENQ
	>REVERSE_sp|P62258|1433E_HUMAN 14-3-3 protein epsilon OS=Homo sapiens GN=YWHAE PE=1 SV=1
	QNEDEVDQLAEKNQEEGDGQMDSTWLTLNDRLLQMILTSDKYSEESLTDLEAIADDFAAKALRCARDPSNLIEYYFVSFNLALGLRIPHTPPLETMAIDSAAKYAVLSNEAAEKRDNGTAFEALYRHYDGKMKYYFVKSEGTNAAPILHKDLVDLIDCCILKLETEVMQRYERIMKLKDEGGKNEEKQEISSIIRWSARRAGIVNKYAVSLLNREEVTLEVDMGAVKKMSEVMEDYREAQEALKAQYVLDERDDM```
	
# TODO or Requests
At this point the script returns the full protein sequence on one line, instead of the often formatted 80 character sequence per line. If the shorter sequence formatting is of interest, please create a new issue on this repository and I will work to include the feature.