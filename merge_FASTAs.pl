#!/usr/bin/perl
# selectProteinsfromFASTA.pl
use strict; use warnings;
use Getopt::Std;
use FAlite;
use vars qw ($opt_l $opt_r $opt_h $opt_m);
getopts('lrhm');

## Set up ##
my  $USAGE = "usage: selectProteinsFromFASTA.pl <query> <fasta file>
	<query>		one accession or protein name per line, header optional see below
	<fasta>		standard fasta database, headers specified by '>' at the begining of the line
	**Options**
	-l		use this option if first line is a header
	-r		use this option if fasta database contains a reverse sequence for each protein
	-h		use this option for human uniprot files
	-m		use this option for macaque uniprot files\n";
die $USAGE unless @ARGV == 2;
my ($QUERY, $FASTADB) = @ARGV;

printf STDERR "Warning: This script does not quality control accession numbers, so make sure your input is what you think it is.\n";



## Set up for look up table ##
my %accessions;
open (IN, "$QUERY") or die "Cannot open $QUERY for reading\n";
my $fileHeader;
if($opt_l) { # If header has a query, do not store it in the accessions array
	$fileHeader = <IN>; # with two files must specify which one you're taking the first line from
	# printf STDERR "header is $fileHeader\n";
}
while (<IN>){
	chomp; # must remove newline character for matching below
	$accessions{$_} = 1; # set each accession to a key and the value to be 1, sets them all to true
}
close (IN);

# use DataBrowser; browse \%accessions; # checkpoint
my $nQueries = scalar(keys %accessions);
printf STDERR "$nQueries query terms have been detected\n";



## Check to see if the accession is present in a FASTA header ##
open(my $input, "<", $FASTADB) or die "Can't open $FASTADB for reading\n";
my $fasta = new FAlite(\*$input);

my $count = 0;
my $extra = 0;
while (my $entry = $fasta->nextEntry) {

	my $id;
		
	if($opt_m) {
		if ($count == 0) {printf STDERR "Searching macaque formatted fasta\n"};
		my ($tmpid) = $entry->def =~ /^>(\S+)\|/; # remove my post debugging
		$id = $tmpid;
	}  
	if($opt_h) {
 		if ($count == 0) {printf STDERR "Searching human formatted fasta\n"};
 		if($opt_r) {
 			next if $entry->def =~ /REVERSE/; # skip all reverse sequences
 		}
 		my ($tmpid) = $entry->def =~ /^>\S+\|(\S+)\|/; # allows sp or tr proteins
 		$id = $tmpid;
 	}
 	
	# printf STDOUT $entry if $accessions{$id}; # ian's one liner
		
	if ($accessions{$id}) {
		$accessions{$id} = 2;
		printf STDOUT $entry;
	} else {
		$extra++; # prints the extra ids in the fasta
	}
	
	$count++;
}

my $missing = 0;
my $present = 0;
while (my ($accession, $status) = each %accessions) {
	if ($status != 2) {
		printf STDERR "$accession\n";
		$missing++;
	} else { 
		$present++;
	}
}

printf STDERR "There were $missing missing accession and $present present accessions\n";

printf STDERR "$count proteins in FASTA db have been searched\n";
printf STDERR "$extra proteins that are extra in the FASTA file\n";

close ($input);



__END__
# alternative way to check if a substring is contained in a larger string
if (index($id, $tmpID) != -1) { # also doesn't work as expected
	print "We've got a bingo\n";
}


### OLD VERSION WITH NESTED LOOPS AKA VERY INEFFICIENT ###
## Slurp each accession into its own element in an array ##
my @accessions;
open (IN, "$QUERY") or die "Cannot open $QUERY for reading\n";

# If header has a query, do not store it in the accessions array
my $fileHeader;
if($opt_h) { 
	$fileHeader = <IN>; # with two files must specify which one you're taking the first line from
	# printf STDERR "header is $fileHeader\n";
}

while (<IN>){
	chomp; # must remove newline character for matching below
	my $line = $_;	
	push (@accessions, $line);
}
close (IN);

# print "@accessions\n"; # print each accession number
my $nQueries = scalar(@accessions);
printf STDERR "$nQueries query terms have been detected\n";


## Check to see if the accession is present in a FASTA header ##
open(my $input, "<", $FASTADB) or die "Can't open $FASTADB for reading\n";
my $fasta = new FAlite(\*$input);

my $count = 0;
while (my $entry = $fasta->nextEntry) {
 	for (my $i = 0; $i < scalar(@accessions); $i++) {
		if ($entry->def =~ m/$accessions[$i]/) { # alternative way to do it
 			printf STDOUT "$entry";			
		}
	}
	$count++;
}

printf STDERR "$count proteins in FASTA db have been searched\n";

close ($input);