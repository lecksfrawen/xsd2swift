## Changelog

### 2.0 alpha

- Tentative Swift 4.0 support.
- Removed code formatting and `DDUtils` dependency.
- Removed Objective-C code generation template.
- Added support for building with Bazel.
- Templates and other resources (like XML files) are now embedded directly into the application binary.

### Pre-xsd2swift

**1.6**

- element default type

**1.5**

- objc & swift 2.0 support (generates FORMATTED code)
- handles namespacesd xsd
- Complex type elements
- Simple type elements/attributes (standard and custom)
    - **42/44 types defined by the w3c work**
    outstanding:        base64Binary, hexBinary
- Inheritance by extension

**1.4**

- restrictions with enumeration support (thanks to Alex Smith for the initial trigger)

**1.3**

- Static parsing methods for global elements (a category is generated for a complex type that is used as the root element)
- Mapping xml namespaces to class name prefixes via a specific tag in a template. (without it, namespaces are mapped 1 : 1 to Class prefixes)
- includes and imports of other XSD files
- annotations of elements that are converted to comments

**1.2**

- referencing external files to copy to the destination folder when generating code
- nested sequences & choices
- anonymous 'inner' types (complex and simple)
