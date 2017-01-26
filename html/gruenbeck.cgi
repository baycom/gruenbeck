#!/usr/bin/perl
use strict;
use POSIX;
use CGI;
use Data::Dumper;
use IO::Socket::INET;
use Time::HiRes qw(usleep);
use DBI;
use JSON;

$CGI::PARAM_UTF8=1;
$| = 1;

my $host_name = "localhost";
my $db_name = "dbname";
my $dsn = "DBI:mysql:host=$host_name;database=$db_name";
my $db_user = "username";
my $db_pass = "password";
my $step = 60;

my $q = new CGI();

my $item=$q->param('item');
my $limit=$q->param('limit');

if ($item eq '') {
    $item = 'current_flow';
}

if ($limit eq '') {
    $limit = '`updated` > timestampadd(day, -90, now())';
} else {
    $limit = -int($limit);
    $limit = "and `updated` > timestampadd(day, $limit, now())";
}

my $dbh=DBI->connect ($dsn, $db_user, $db_pass, {PrintError => 1, RaiseError => 0, mysql_enable_utf8 => 1});
$item = "`$item`";
my $array = $dbh->selectall_arrayref("select UNIX_TIMESTAMP(updated), ROUND($item,3) from gruenbeck where $limit order by updated desc;");
print $q->header( -type=>'application/json', -charset=>'UTF-8');

my @values = reverse(@$array);
my @newarray;
my $outarray = \@values;
my $lastval = 0;
my $lasttime = 0;

foreach my $vals (@values) {
    my @out = ( @$vals[0]*1.0, @$vals[1]*1.0);
    my $timenow = @$vals[0]*1.0;
    my $valnow = @$vals[1]*1.0;
    if($lasttime > 0) {
        my $timediff = $timenow - $lasttime;
        if($timediff > $step ) {
            while(($lasttime + $step) < $timenow) {
                $lasttime += $step;
                my @fill = ($lasttime, $lastval);
                push(@newarray, \@fill);
            } 
        }
    }
    
    push(@newarray, \@out);
    $lasttime = $timenow;
    $lastval  = $valnow;
}
my @out = ( time(), $lastval);
push(@newarray, \@out);
$outarray = \@newarray;

my $json_str = encode_json($outarray);

print "$json_str\n";

