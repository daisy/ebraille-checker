 Feature: eBraille — Content documents
  
  Checks conformance to the "eBraille content documents" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-content-docs


  Background: 
    Given the test files located at '/ebraille/06-content-document/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

  ## 6.2 XHTML

  Rule: An eBraille content document MUST be an XHTML content document

    Example: allow a minimally valid eBraille content document
      When checking document 'minimal.html'
      Then no errors or warnings are reported

  ### 6.2.1 Character encoding

  Rule: the text content of eBraille content documents SHOULD consist only of braille characters

    Example: report laitn characters used in HTML content
      When checking document 'content-latin-error.html'
      Then warning EBR-030 is reported
      And no other errors or warnings are reported

    Example: report latin characters used in user-oriented attributes
      When checking document 'content-latin-in-abbr-title-error.html'
      Then warning EBR-030 is reported
      And no other errors or warnings are reported