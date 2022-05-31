## modern Fortran system commands

Note: Fortran 2008 does not provide a way to capture `stdout` for `execute_command_line`.
The `cmdmsg` dummy variable is only for `stderr`, and only if an error occurs.
That's a bit silly, but that's the way it is.
Redirecting stdout to stderr does not work.
