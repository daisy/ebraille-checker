Feature: eBraille — Publication resources

  Checks conformance to the "Publication resources" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-resources


  Background:
    Given the test files located at '/ebraille/03-resources/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

  ## 3.2 Core media types

  Rule: the core media types allowed in eBraille are the same as in EPUB

    This is already covered by EPUB checks.

  ## 3.3 Foreign resources

  Rule: fallbacks are provided using intrinsic fallback methods

    This is already covered by EPUB checks.

  ## 3.4 Resource fallbacks

  Rule: eBraille does not support the use of manifest fallbacks

    This is covered in tests for the "Package Document" section.

  ## 3.5 Resource location

  Rule: eBraille publications do not support remote resources

    This is covered in tests for the "eBraille file set" section.

  Rule: eBraille does not support the `file:` URL scheme

    This is already covered by EPUB checks.

  Rule: the `data:` URL scheme MAY be used in content documents

    This is already covered by EPUB checks.

  ## 3.6 Exempt resources

  Rule: (this section if informative)

  ## 3.7 File extensions

  Rule: (this section if informative)

  ## 3.8 XML Conformance

  Rule: UTF-16 MUST NOT be used to encode XML resources

     Example: a package document encoded in UTF-16 is reported
       When checking file 'encoding-utf16-error.opf'
       Then error RSC-028 is reported
       And no other errors or warnings are reported

     Example: a content document encoded in UTF-16 is reported
       When checking file 'encoding-utf16-error.html'
       Then error HTM-058 is reported
       And no other errors or warnings are reported
