# xsd2swift

> Command line tool to convert XML schemas to Swift classes.

This tool creates Swift classes from XSD files. The generated Swift classes it produces can be used to deserialize XML on iOS and macOS.

___
**This project is in a broken state at the moment.**
___

## Download a Binary

Binary releases are available on the [releases page](https://github.com/StevenEWright/xsd2swift/releases).

## Build from Source

Building `xsd2swift` requires [Bazel](http://bazel.build).

Clone the repository:

```
git clone https://github.com/StevenEWright/xsd2swift.git xsd2swift && cd xsd2swift
```

**To install** xsd2swift into `/usr/local/bin/`:

```
./install.sh
```

**To only build** xsd2swift:

```
./build.sh
```

### Use

Produce Swift classes for the complex types represented in an XML schema document by invoking `xsd2swift`:

```
xsd2swift -schema [xsd_file_path] -out [existing_directory] (-prefix [prefix])
```

|Option|Description|
|--|--|
|`-schema [path]`|The location of the XML schema.|
|`-out [path]`|The directory in which to place the generated Swift classes.|
|`-prefix [class_prefix]`|Adds the specified `class_prefix` string to the beginning of all class names.|

The generated classes support Swift 4 and only require `libxml2`. They work on macOS, iOS, and tvOS.

When you use these classes in your project, you must make sure to link your build target against `libxml2`.

In Xcode this is done by adding `-lxml2` to your build target's `Other Linker Flags` build setting.

In Bazel this may be done as follows:

```
    sdk_dylibs = [
        "libxml2",
    ],
```

In your bridging header, add:

```
#import <Foundation/Foundation.h>

#import <libxml/xpath.h>
#import <libxml/xmlerror.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlwriter.h>
```

#### Formatting

I like [Nick Lockwood's SwiftFormat](https://github.com/nicklockwood/SwiftFormat), personally.

```
brew update
brew install swiftformat
```

## Notices

** Please take a moment to review the list of [Contributors](CONTRIBUTORS.md)**.

[Copyright Notice](NOTICE.md).

```
xsd2swift: Command line tool to convert XML schemas to Swift classes.
Copyright (C) 2017  Steven E Wright

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
