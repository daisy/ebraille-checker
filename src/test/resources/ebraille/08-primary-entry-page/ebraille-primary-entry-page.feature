Feature: eBraille — Primary entry page
  
  Checks conformance to the "Primary entry page" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-nav


  Background: 
    Given the test files located at '/ebraille/08-primary-entry-page/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

#   Rule:

#     Example:
#       When checking file set ''
#       Then error XXX is reported
#       And no other errors or warnings are reported
