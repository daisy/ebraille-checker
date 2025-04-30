Feature: eBraille — Content documents
  
  Checks conformance to the "Cascading Style Sheets" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#html-css


  Background: 
    Given the test files located at '/ebraille/06-content-document/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

  ## 6.3 Cascading Style Sheets

  Rule: eBraille may use CSS

    Example: allow a minimally valid eBraille publication with CSS file
      When checking file set 'minimal-css'
      Then no errors or warnings are reported

    Example: allow a minimally valid eBraille content document with inline CSS
      When checking document 'minimal-css.html'
      Then no errors or warnings are reported

  ## 6.3.2 CSS requirements

  Rule: eBraille creators MUST NOT use `-epub-` prefixed properties

    Example: report '-epub' prefixe properties
      When checking document 'css-epub-prefixed-properties-error.html'
      Then error EBR-050 is reported 11 times
      And warning EBR-051 is reported (side effect due to the `text-transform` property)
      But no other errors or warnings are reported

  Rule: CSS style sheets MUST be UTF-8 encoded

    Example: report a stylesheet encoded in UTF-16
      When checking file set 'css-encoding-utf16-error'
      Then error CSS-004 is reported
      And no other errors or warnings are reported

  Rule: eBraille creators SHOUD NOT use properties that affect the text's font

    Example: report various font-related properties
      When checking document 'css-font-styling-warning.html'
      Then warning EBR-051 is reported 17 times
      And no other errors or warnings are reported

  Rule: eBraille creators SHOUD use font-relative lenghts only

    Example: report various non-font-relative lenghts units
      When checking document 'css-unit-length-warning.html'
      Then warning EBR-052 is reported 12 times
      And no other errors or warnings are reported
