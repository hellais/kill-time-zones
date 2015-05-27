# Kill Time Zones!

The inspiration for this software comes from the frustration with having to
coordinate meeting across ever changing timezones.

In an ideal world we would not have the need for timezones and we would just
all agree on a universal time reference and just use that (UTC anyone?).

Since our world is far from perfect this simple shell CLI tool will assist you
in navigating the complex realm of timezones.

## Usage

To convert 16:20 in UTC to CEST PST and EDT you can use:

```
./ktimez.sh convert 16:20 UTC to CEST PST EDT
```

To produce the output:

```
16:20 UTC
14:20 CEST
08:20 PST
12:20 EDT
```

## Supported platforms

It should work on any system that has a `/bin/sh` compatible shell (bash, zsh,
dash should all work fine) and either GNU date or BSD date.

It is known to work on:

* Mac OS X: 10.10

* Debian GNU/Linux

## Design goals

This tool is designed to be as POSIX friendly as possible. For this reason it
is implemented as a `/bin/sh` script (no bash, zsh, etc.) and neatly fits
inside of just 1 file.

If you have plans to extend it further please keep this in mind.

