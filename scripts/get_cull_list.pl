#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;

my $n = 3;
GetOptions(
          "n=i" => \$n
          );
my $dbnam = shift @ARGV;
my $cmd = "'select label from entity where count < $n;'";
my @culls = `sqlite3 -cmd $cmd $dbnam < /dev/null`;
for (@culls) { chomp;
  print "[\"$_\",\"ORG\",\"\",\"\",0,true\],\n";
}
