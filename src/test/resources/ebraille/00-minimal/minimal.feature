 Feature: EBraille — Minimal Publications
  
  Checks minimal publications against the eBraille specification:
    https://daisy.org/s/ebraille/


  Background: 
    Given the test files located at '/ebraille/00-minimal/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

  Scenario: Verify a minimal eBraille file set
    When checking file set 'minimal'
    Then no errors or warnings are reported

#  Scenario: Verify a minimal eBraille package
#    When checking EPUB 'minimal.epub'
#    Then no errors or warnings are reported

#  Scenario: Verify a minimal package document 
#    When checking file 'minimal.opf'
#    Then no errors or warnings are reported

#  Scenario: Verify a minimal XHTML content document 
#    When checking file 'minimal.xhtml'
#    Then no errors or warnings are reported
