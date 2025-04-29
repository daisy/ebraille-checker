 Feature: eBraille — Publication conformance
  
  Checks conformance to the "eBraille publication conformance" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-pub


  Background: 
    Given the test files located at '/ebraille/02-publication-conformance/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

  # All conformance statements are in more specific subsequent sections