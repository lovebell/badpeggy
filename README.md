# Bad Peggy

Bad Peggy scans JPEG and other image formats for damage and other blemishes and shows
the results and images instantly. It allows you to find such broken files quickly,
inspect and then either delete or move them to a different location.

Implemented in Java 8 and SWT. Runs on Windows, MacOS and Linux.

## Development

BadPeggy development is done in Eclipse (Oxygen+). Choose the right SWT project
for your platform, and import it into your workspace. It will show up as
*org.clipse.swt*. On Linux for instance it would be
*swt/4.5/gtk-linux_x86_64/*. You also need the library CLBaseLib, which you can
clone from GitHub and import its Eclipse project.

You can then run Bad Peggy by debugging the class *coderslagoon.badpeggy.GUI*.

For verification the few test cases can also be executed. Notice though that
they might fail due to slightly different image rendering of the test material.
This does usually not present a problem. Frozen reference test material is not
included, due to the huge size of it (3+GB).

## Shipping

For shipping clone the [jre-reduce](https://github.com/coderslagoon/jre-reduce)
repo from GitHub, in parallel to the other projects. Download the appropriate JRE
runtime files, as mentioned in the jre-reduce documentation. Then run *build.sh*
and *build_macos.sh* to create the installer, passing them a version string.

## I18N

New user-facing strings need to be internationalized, meaning being available
in both English and German. New strings have to be added in the NLS files in
*coderslagoon.badpeggy.NLS...*. Please test for both languages, and watch out
for proper format string rendering.
