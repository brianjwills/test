#!/usr/bin/perl

use strict;
use DBI;

my $dsn = '';
my $user = '';
my $password = '';

$dbh = DBI->connect($dsn, $user, $password,
                    { RaiseError => 1, AutoCommit => 0 });
$sth = $dbh->prepare("SELECT `pos_upload_directory` FROM `store` WHERE `active_pos_uploader` = 1");
$sth->execute();
while ( my @row = $sth->fetchrow_array ) {
  `rsync -va $row[0] aiq@saiq:$row[0]`;
}
