Mini Notifier
=============

Mini Notifier is a commandline tool to send notification to OS X
notification center.

## Installation

Build the program by running `make` in the same directory as the
`Makefile` is at.  The binary will be moved to the current directory,
and a script `notify.sh` will be created.  Copy this script to
somewhere in your `$PATH`, and run it like you usually would with a
command-line program.

## Some Remarks

`NSUserNotification` and its friends require an application bundle.
So it is probably impossible to just write a “unix programm”.
