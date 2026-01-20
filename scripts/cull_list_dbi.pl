#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use DBI;

my $n = 3;
my $out = 'worddumb-custom-x-ray.cull';
GetOptions(
          "n=i" => \$n,
          "out=s" => \$out
          );
my $driver = 'SQLite';
my $dbnam = shift @ARGV;
my $dsn = "DBI:$driver:dbname=$dbnam";
my $uid = ''; my $pw = '';
my $dbh = DBI->connect($dsn, $uid, $pw, { RaiseError => 1 })
   or die $DBI::errstr;
my $cmd = "select label from entity where count < $n;";
my $sth = $dbh->prepare($cmd);
my $rv = $sth->execute();
if($rv < 0) { print $DBI::errstr; }
while (my @row = $sth->fetchrow_array()) {
  print qq(["@row","ORG","","",0,true\],\n);
}
