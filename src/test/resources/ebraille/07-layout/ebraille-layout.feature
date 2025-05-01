Feature: eBraille — Layout rendering control
  
  Checks conformance to the "Layout rendering control" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-rendering-control


  Background: 
    Given the test files located at '/ebraille/07-layout/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile


  Rule: the publication MUST NOT specify the `rendition:layout` "pre-paginated" property
 
    Example: report a `rendition:layout` "pre-paginated" property in package metadata
      When checking document 'layout-pre-paginated-error.opf'
      Then error EBR-070 is reported
      And no other errors or warning are reported


  Rule: the publication MUST NOT specify the `rendition:layout-pre-paginated` override property

    Example: report a `rendition:layout-pre-paginated` override in a spine item
      When checking document 'layout-pre-paginated-override-error.opf'
      Then error EBR-071 is reported
      And no other errors or warning are reported


  Rule: the publication MUST NOT specify properties or overrides defined in FXL package settings

    Example: report fixed-layout package settings properties in package metadata
      When checking document 'layout-fxl-properties-error.opf'
      Then error EBR-072 is reported 3 times
      And no other errors or warning are reported
