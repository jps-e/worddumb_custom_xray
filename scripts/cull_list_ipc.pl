#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use IPC::Open2;

my $n = 3;
my $out = 'worddumb-custom-x-ray.cull';
GetOptions(
          "n=i" => \$n,
          "out=s" => \$out
          );
my $dbnam = shift @ARGV;
my $pid = open2(\*SQL_OUT, \*SQL_IN, "sqlite3 $dbnam")
   or die "Can't open pipe to sqlite3 $!";
print SQL_IN "select count(*) from entity where count < $n;\n";
my $num = <SQL_OUT>;
print SQL_IN "select label from entity where count < $n;\n";
for ($n=0; $n<$num; $n++) {
  my $cull = <SQL_OUT>; chomp $cull;
  print "[\"$cull\",\"ORG\",\"\",\"\",0,true\],\n";
}
