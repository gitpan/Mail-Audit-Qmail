use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'Mail::Audit::Qmail',
    'VERSION_FROM' => 'Qmail.pm', # finds $VERSION
	'PREREQ_PM' => {
		'Mail::Audit' => 2,
	}
);
