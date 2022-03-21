# ff_del_nk

C program to selectively delete cookies from a Firefox profile using sqlite3.

## Description

The program deletes all cookies and application data items from a Firefox
profile, except those with "base domain" name belongs to a "keep list".
The program first performs a test to check if the profile is busy, which
it will be if Firefox is running using the profile.

## Use

In this simple version, the profile directory and the keep list must be
"hard coded" into ff_del_nk.c.  Once this is done, ff_del_nk may be created
by compiling and linking.  The executable may be placed in a convenient
location.  It may then be invoked from the command line.

Recent versions of Firefox seem no longer to delete the lock file.
ff_del_nk should be called from a script which checks if firefox is running.
An example is provided in source code comments.

## Requirements

In addition to a Linux system with a C compiler, the sqlite3 C library is
required.  Note, though, that sqlite3 is available for Windows,
and it's not unlikely that ff_del_nk can be compiled for Windows Firefox.
The Firefox version needs to be compatible.  The version ff_del_nk was
tested with is 91.5.1esr.

## Documentation

The source code is "self-documenting".

## Slackware 14.2 version.

The format of the firefox cookies database changed somewhere between
firefox version 68 and version 90, necessitating changes to ff_del_nk.c.
The old version is included in the repository, as ff_del_nk.c.14.2.
