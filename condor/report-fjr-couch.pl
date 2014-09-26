#!/usr/bin/perl

use strict;
use warnings;
use XML::Simple;
use CouchDB::Client;
use App::Rad;

App::Rad->run();

# -bash-4.1$ ./report-fjr-couch.pl --fjr=FrameworkJobReport.xml  --couchurl=http://samircurydev.cloudant.com --db=cmssw-benchmarks

sub default  {

	my $rad = shift;
       
	my $server = $rad->options->{'couchurl'};
	my $database = $rad->options->{'db'};
	my $fjr = $rad->options->{'fjr'};
	
	my $input = $fjr;
       

       #my $input = $ARGV[0] || "FrameworkJobReport.xml";
       ##my $input = $ARGV[0];
       ##my $server = $ARGV[1];
       ##my $database = $ARGV[2];

       die "Had no input (FJR). Nothing to do" if not $input;

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
       
       
       my $c = CouchDB::Client->new(uri => $server);
       $c->testConnection or die "The server cannot be reached";
       my $db = $c->newDB($database);
       
       # TODO : Need to check response code or, in CouchDB::Client terms,
       # if the 'rev' field is updated. In our case, created.
       # Good news is that we already test the connection to the server.
       my $doc = CouchDB::Client::Doc->new('db' => $db, 'data' => $payload);
       $doc->create();

}
