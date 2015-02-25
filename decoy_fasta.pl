#!/usr/bin/perl
# decoy_fasta.pl
# K. Beck
# 02-25-2015
use strict; use warnings;
use Getopt::Std; use FAlite;
use vars qw($opt_h);
getopts('h');


my $USAGE = "\nUsage: this file will take one FASTA file as an input and reverse the N and C terminal
amino acids. It will return a FASTA formatted file with the input sequences and the
reverse sequences with the header line annotated marking REVERSE

Example Input
	> protein 1
	MCTRHTSS
Example Output
	> protein 1
	MCTRHTSS
	> REVERSE_protein 1
	SSTHRTCM\n";

if ($opt_h) {die $USAGE};

print "hello world";

