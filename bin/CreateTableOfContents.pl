#!/usr/bin/perl
# CreateTableOfContents.pl
# Geoffrey Hannigan
# Pat Schloss Lab
# University of Michigan

# Use this simple script to automatically create the
# table of contents.

# Set use
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
# And because I like timing myself
my $start_run = time();

my @input;
my $opt_help;
my $output;

# Set the options
GetOptions(
	'h|help' => \$opt_help,
	'o|output=s' => \$output,
	'i|input=s{,}' => \@input
);

pod2usage(-verbose => 1) && exit if defined $opt_help;

# Open the output file for writing
open(OUT, ">$output") || die "Unable to write to $output: $!";

# Set flag variable
my $flag = 0;

# Set the first line for the table of contents
print OUT "\# Summary
Lab notebook entires\.

\# Table of Contents\n";

foreach my $inFile (@input) {
	open(ITFILE, "<$inFile");
	foreach my $line (<ITFILE>) {
		chomp $line;
		# First print the date
		if ($line =~ /date:\s/) {
			$line =~ s/date:\s+//;
			print OUT "\n\#\#\ $line\n";
		}
		if ($flag = 0 & $line =~ /#\ Summary/) {
			$flag = 1;
			next;
		} elsif ($flag = 1 & $line =~ /^\*/) {
			print OUT "$line\n";
		} elsif ($flag = 1 & $line =~ /#\ Contents/) {
			$flag = 0;
			last;
		} else {
			next;
		}
		$flag = 0;
	}
}

close(OUT);

# How long did it take
my $end_run = time();
my $run_time = $end_run - $start_run;
print STDERR "Processed the files in $run_time seconds.\n";

=head1 NAME

CreateTableOfContents.pl

=head1 SYNOPSIS

This script allows you to create a README file using the standard format notebook posts.

=head1 OPTIONS

CreateTableOfContents.pl -i <glob of input files> -o <output file> [OPTIONS]

=head1 ARGUMENTS

-h | --help	Print this helpful help menu.

-i | --input	Glob of notebook post input files

-o | --output	README file for output

=cut
