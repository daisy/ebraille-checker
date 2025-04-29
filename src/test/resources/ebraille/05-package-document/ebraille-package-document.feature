Feature: eBraille — Package document
  
  Checks conformance to the "Package document" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-package-doc


  Background: 
    Given the test files located at '/ebraille/05-package-document/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

  ## 5.4 Manifest

  Rule: item property 'remote-resources' is not supported

    Example: ignore a missing 'remote-resources' property for HTML
      (as the remote resource itself is reported anyway)
      When checking file set 'item-property-remote-resources-undeclared-for-html-error'
      Then error RSC-006 is reported (for using remote content)
      But no other errors or warnings are reported

    Example: ignore a missing 'remote-resources' property for media overlays
      (as the remote resource itself is reported anyway)
      When checking file set 'item-property-remote-resources-undeclared-for-overlay-error'
      Then error RSC-006 is reported (for using remote content)
      But no other errors or warnings are reported

    Example: ignore a missing 'remote-resources' property for CSS
      (as the remote resource itself is reported anyway)
      When checking file set 'item-property-remote-resources-undeclared-for-css-error'
      Then error RSC-006 is reported (for using remote content)
      But no other errors or warnings are reported

    Example: report when item property 'remote-resources' is set on HTML
      (even when the HTML has no references to remote resources)
      When checking file set 'item-property-remote-resources-unwarranted-for-html-warning'
      Then warning EBR-002 is reported
      And no other errors or warnings are reported

    Example: report when item property 'remote-resources' is set on CSS
      (even when the CSS has no references to remote resources)
      When checking file set 'item-property-remote-resources-unwarranted-for-css-warning'
      Then warning EBR-002 is reported
      And no other errors or warnings are reported

