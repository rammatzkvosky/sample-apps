
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

use Cwd qw( abs_path );
use Test::More;

BEGIN {
    plan skip_all =>
        'Must set DATETIME_LOCALE_TEST_DEPS to true in order to run these tests'
        unless $ENV{DATETIME_LOCALE_TEST_DEPS};
}

use Test::DependentModules qw( test_all_dependents );

## no critic (Variables::RequireLocalizedPunctuationVars)
$ENV{PERL_TEST_DM_LOG_DIR} = abs_path('.');
## use critic

test_all_dependents(
    'DateTime::Locale',
    {
        filter => sub {

            # Fails tests for reasons unrelated to DateTime-Locale
            return 0 if $_[0] =~ /Jifty/;

            # Is having issues with installing its Pg schema
            return 0 if $_[0] =~ /Silki/;

            # hangs installing prereqs (probably SOAP::Lite for both)
            return 0 if $_[0] =~ /Plagger/;
            return 0 if $_[0] =~ /WSRF-Lite/;
            return 1;
        },
    },
);

done_testing();
