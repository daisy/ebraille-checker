eBraille Checker
================

The eBraille Checker is a conformance checker for [eBraille](https://daisy.org/s/ebraille/) publications.
It can be run as a standalone command-line tool or used as a Java library.

This project is open source software, made by the [DAISY Consortium](http://www.daisy.org). It is based on a fork of [EPUBCheck](https://www.w3.org/publishing/epubcheck/), the official conformance checker for EPUB.


## Building

To build from the sources you need Java Development Kit (JDK) 1.7 or above and [Apache Maven](http://maven.apache.org/) 3.0 or above installed.

Build and run tests:

```
$ mvn clean install
```
Will copy `*.jar` files and packages to `target/` folder...

## License

The eBraille Checker is made available under the terms of the [3-Clause BSD License](http://opensource.org/licenses/BSD-3-Clause)
