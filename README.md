# xsd2swift

> Command line tool to convert XML schemas to Swift classes.

This tool creates Swift classes from XSD files. The generated Swift classes it produces can be used to deserialize XML on iOS and macOS.

## Instructions

### Get the Code

```
git clone https://github.com/StevenEWright/xsd2swift.git && cd xsd2swift
```

### Build the Command Line tool

Building `xsd2swift` requires [Bazel](http://bazel.build).

From the root of the repository, run:

```
tools/build.sh
```

The built command-line tools will be placed in:

```
out/xsd2swift
```

### Use

Produce Swift classes for the complex types represented in an XML schema document by invoking `xsd2swift` from the command line and redirecting the output to a file.

```
xsd2swift -schema [path] (-prefix [prefix])
```

|Option|Description|
|--|--|
|`-schema [path]`|The location of the XML schema.|
|`-prefix [class_prefix]`|Adds the specified `class_prefix` string to the beginning of all class names.|

The generated classes only require `libxml2` and work on macOS, iOS, and tvOS.

When you use these classes in your project, you must make sure to link your build target against `libxml2`.

In Bazel this may be done as follows:

```
    sdk_dylibs = [
        "libxml2",
    ],
```

### Hack

Pull requests are welcome.

#### Code Style

All new code submissions should, wherever possible, adhere to the
[Google Objective-C Style Guide](https://google.github.io/styleguide/objcguide.xml).

Please run `tools/format.sh` from the root of the repository before sending a pull request.

#### Tests

New code should be tested by unit tests that pass as submission time.

## Status

### Working

- element default type
- objc & swift 2.0 support (generates FORMATTED code) ** 1.5 **
- handles namespacesd xsd ** 1.5 **
- Complex type elements
- Simple type elements/attributes (standard and custom)
	- **42/44 types defined by the w3c work**<br/>
	outstanding: 		base64Binary, hexBinary
- Inheritance by extension
- restrictions with enumeration support (thanks to Alex Smith for the initial trigger) ** 1.4 **
- Static parsing methods for global elements (a category is generated for a complex type that is used as the root element)
- Mapping xml namespaces to class name prefixes via a specific tag in a template. (without it, namespaces are mapped 1 : 1 to Class prefixes)
- referencing external files to copy to the destination folder when generating code ** 1.2 **
- nested sequences & choices
- includes and imports of other XSD files ** 1.3 **
- annotations of elements that are converted to comments ** 1.3 **
- anonymous 'inner' types (complex and simple)

### Not Working

- References to elements/attributes via the ref= attribute.
- The min & maxOccurences of elements inside a sequence/choice must be specified on element itself as opposed to the sequence itself.

## Directory Structure

### xsd2swift

Project source code.

### tests

Source code for project tests.

### tools

Scripts for building, cleaning, and other development-time activities.

### third_party

Submodules for third-party code.

At the moment these submodules are all forks of upstream repositories to deal with version control.

## License

Please review the [Copyright Notices](NOTICE.md).

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
