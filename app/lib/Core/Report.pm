package Core::Report;

use v5.14;
use parent 'Core::Base';
use Core::Base;

sub add_error {
    my $self = shift;
    my @msg = @_;
    my $msg;
    if (ref $msg[0]) {
        $msg = $msg[0];
    } else {
        $msg = join(' ', @msg);
    }
    logger->warning( $msg );
    push @{ $self->{errors}||=[] }, $msg;
}

sub errors {
    my $self = shift;
    my $ret = $self->{errors} ? delete $self->{errors} : [];
    return wantarray ? @{ $ret } : $ret;
}

sub is_success {
    my $self = shift;
    return scalar @{ $self->{errors} || [] } ? 0 : 1;
}

1;
