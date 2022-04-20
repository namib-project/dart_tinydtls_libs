# dart_tinydtls_libs

Provides tinyDTLS binaries for adding DTLS support to Flutter apps.

## Usage

This library can be used to distribute [tinyDTLS](https://github.com/eclipse/tinydtls)
binaries with Flutter apps which can be used by the
[dart_tinydtls](https://pub.dev/packages/dart_tinydtls) client and server wrappers.

This library contains only pre-compiled dynamic libraries which can be used on Linux,
Android, and Windows.
More information on how to use this library can be found in the
[dart_tinydtls documentation](https://pub.dev/documentation/dart_tinydtls/latest/).

## Installation

Simply run

```sh
flutter pub add dart_tinydtls_libs
```

in the terminal of your choice. In order to actually use the library,
you also need to install
[dart_tinydtls](https://pub.dev/packages/dart_tinydtls) which provides
ffi bindings and idiomatic wrappers around tinyDTLS.

## Third-Party Code

This library contains compiled binaries of tinyDTLS for Linux, Android,
and Windows.
See the next section for licensing information.

## License

Matching the license of the tinydtls C library, this library is made available both under
the terms of the Eclipse Public License v1.0 and 3-Clause BSD License (which the
Eclipse Distribution License v1.0 that is used for tinydtls is based on).
Additionally, the tinydtls C library contains third party code that might be included
in compiled binaries that link to tinydtls.
For information on third-party code and its licenses, see
https://github.com/eclipse/tinydtls/blob/develop/ABOUT.md.
See https://github.com/eclipse/tinydtls/blob/develop/LICENSE for more information on the
tinydtls licensing terms and https://www.eclipse.org/legal/eplfaq.php for more information
on the EPL 1.0.

Note: This library is neither supported nor endorsed by the Eclipse Foundation.

## Maintainers

This project is currently maintained by the following developers:

|      Name      |      Email Address       |            GitHub Username            |
|:--------------:|:------------------------:|:-------------------------------------:|
|   Jan Romann   | jan.romann@uni-bremen.de |   [JKRhb](https://github.com/JKRhb)   |
| Falko Galperin |   falko1@uni-bremen.de   | [falko17](https://github.com/falko17) |
