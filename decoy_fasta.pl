#!/usr/bin/perl
# decoy_fasta.pl
# K. Beck
# 02-25-2015
use strict; use warnings;
use Getopt::Std; use FAlite;
use vars qw($opt_h);
getopts('h');


my $USAGE = "\nUsage: decoy_fasta.pl <file.fasta> 
Description: This script will take one FASTA file as an input and reverse the N and C terminal
amino acids. It will return a FASTA formatted file with the input sequences and the
reverse sequences with the header line annotated marking REVERSE

Note: This script requires the FAlite Perl module created by Ian Korf. This can be cloned from this repository:  
https://github.com/KorfLab/Perl_utils

Example Input
	> protein 1
	MCTRHTSS
Example Output
	> protein 1
	MCTRHTSS
	> REVERSE_protein 1
	SSTHRTCM\n";

if ($opt_h) {die $USAGE};

die $USAGE unless @ARGV == 1;

my($FASTA) = @ARGV;

open(my $fh, $FASTA) or die;
my $fasta = new FAlite($fh);
while (my $entry = $fasta->nextEntry) {
	my ($id) = $entry->def; # =~ /^>(\w+)/;
	print "$id\n";
	
	my (@seq) = $entry->seq;
	print @seq, "\n";
	
	$id =~ s/\>/\>REVERSE_/;
	print "$id\n";
	
	print scalar reverse @seq;
	print "\n";

}
close $fh;

# TODO consider only printing 80 lines of sequence per line