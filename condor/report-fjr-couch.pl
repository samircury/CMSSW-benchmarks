#!/usr/bin/perl

use strict;
use warnings;
use XML::Simple;
use CouchDB::Client;

my $input = $ARGV[0] || "FrameworkJobReport.xml";


my $FJR = XMLin($input);

my $proc_report = $FJR->{"PerformanceReport"}[0];
my $timing = $FJR->{"PerformanceReport"}[3];

my $cpu_model = $proc_report->{'PerformanceSummary'}->{'Metric'}[1]->{'Value'};
my $ncores = $proc_report->{'PerformanceSummary'}->{'Metric'}[3]->{'Value'};

my $tpe = $timing->{'PerformanceSummary'}->{'Metric'}[2]->{'Value'};
my $maxevt = $timing->{'PerformanceSummary'}->{'Metric'}[4]->{'Value'};
my $minevt = $timing->{'PerformanceSummary'}->{'Metric'}[6]->{'Value'};


my $payload = {	'CPUModel'	=> $cpu_model, 
		'NCores'	=> $ncores,
		'AvgEventTime'	=> $tpe,
		'MinEventTime'	=> $maxevt,
		'MaxEventTime'	=> $minevt
};


my $c = CouchDB::Client->new(uri => 'http://samircurydev.cloudant.com');
$c->testConnection or die "The server cannot be reached";
my $db = $c->newDB('cmssw-benchmarks');

# TODO : Need to check response code or, in CouchDB::Client terms,
# if the 'rev' field is updated. In our case, created.
my $doc = CouchDB::Client::Doc->new('db' => $db, 'data' => $payload);
$doc->create();

