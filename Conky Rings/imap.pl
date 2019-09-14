#!/usr/bin/perl
 
# by gxmsgx
# description: get the count of unread messages on imap

use strict;
use Mail::IMAPClient;
use IO::Socket::SSL;

my $username = 'username'; 
my $password = 'password'; 

my $socket = IO::Socket::SSL->new(
  PeerAddr => 'imap.mail.com',
  PeerPort => 993
 )
 or die "socket(): $@";
 
my $client = Mail::IMAPClient->new(
  Socket   => $socket,
  User     => $username,
  Password => $password,
 )
 or die "new(): $@";
 
if ($client->IsAuthenticated()) {
  my $msgct;

  $client->select("INBOX");
  $msgct = $client->unseen_count||'0';
  print "${msgct}";
  print " new"
}

$client->logout();

