package Mail::Audit::Qmail;
use Mail::Audit;
use vars q($VERSION);
$VERSION = '0.90';
1;

package Mail::Audit;
use strict;

sub qmail_resend {
  my ($self, $to) = (shift, shift);
  my %opts = @_;

  $to =~ tr/A-Za-z:,.-@//cd;

  _log(2, "qmail resending to $to");

  my $h = do { local *H; *H; };
  open $h, "|/var/qmail/bin/qmail-inject -a $to"
    or die "Can't open pipe to 'qmail-inject': $!";
   print $h $self->{obj}->as_string
     or die "Can't write to pipe to 'qmail-inject': $!";
  close $h
    or die "Can't close pipe to 'qmail-inject': $!";

  return 1;
}

1;
__END__

=pod

=head1 NAME

Mail::Audit::Qmail - Mail::Audit plugin to resend using qmail-inject

=head1 SYNOPSIS

    use Mail::Audit qw(Qmail);
	my $mail = Mail::Audit->new;
    ...
        $mail->qmail_resend($to);

=head1 DESCRIPTION

Resends the message using qmail-inject.  Preserves the envelope sender.

Dies if anything goes wrong, so you might want to wrap it in an eval.

=head2 METHODS

=over 4

=item qmail_resend($to)

well, duh.

=head1 AUTHOR

Ask Bjoern Hansen <ask@develooper.com>

=head1 SEE ALSO

L<Mail::Audit>
