#!/usr/bin/perl
# CreatePost.pl
# Geoffrey Hannigan
# Pat Schloss Lab
# University of Michigan

# Use this to create a properly formatted notebook post.

# Set use
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
# And because I like timing myself
my $start_run = time();

my $opt_help;
my $output;

# Set the options
GetOptions(
	'h|help' => \$opt_help,
	'o|output=s' => \$output,
);

pod2usage(-verbose => 1) && exit if defined $opt_help;

# Open the output file for writing
open(OUT, ">$output") || die "Unable to write to $output: $!";

my $day = (localtime)[3];
my $month = (localtime)[4] + 1;
my $year = 1900 + (localtime)[5];

print OUT "---
file: $year-$month-$day.md
layout: post
date: $year-$month-$day.md
---

#Summary
* Add Bullet Points for Advances Today
* These should be copied for contents as well

#Contents
##Add Bullet Points for Advances Today
Write your summary for this section.

##These should be copied for contents as well
And your summary for this section too.
";

close(OUT);

# How long did it take
my $end_run = time();
my $run_time = $end_run - $start_run;
print STDERR "Processed the files in $run_time seconds.\n";

=head1 NAME

CreatePost.pl

=head1 SYNOPSIS

This script quickly creates a notebook post template for today.

=head1 OPTIONS

CreatePost.pl -o <output file as: $year-$month-$day.md> [OPTIONS]

=head1 ARGUMENTS

-h | --help	Print this helpful help menu.

-o | --output	Post file name using format $year-$month-$day.md

=cut


