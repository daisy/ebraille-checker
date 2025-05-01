Feature: eBraille — Primary entry page
  
  Checks conformance to the "Primary entry page" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-nav


  Background: 
    Given the test files located at '/ebraille/08-primary-entry-page/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile


  ## 8.2 General requirements

  Rule: the primary entry page MUST be a conforming EPUB navigation document

    Example: allow a minimally valid navigation document
      Given EPUBCheck configured to check a navigation document
      When checking document 'index.html'
      Then no errors or warnings are reported

  Rule: the primary entry page MUST include a link element with a 'rel' attribute set to 'publication'

    Example: report a navigation document with no link element to the package document
      Given EPUBCheck configured to check a navigation document
      When checking document 'index-publication-link-missing-error.html'
      Then error EBR-080 is reported
      And no other errors or warnings are reported

  Rule: the publication link `href` attribute MUST specify the package document

    Example: report a publication link that does not point to the package document
      Given EPUBCheck configured to check a navigation document
      When checking document 'index-publication-link-href-incorrect-error.html'
      Then error EBR-081 is reported
      And no other errors or warnings are reported

  Rule: the publication link `type` attribute MUST contain the package document media type

    Example: report a publication link with a wrong media type
      Given EPUBCheck configured to check a navigation document
      When checking document 'index-publication-link-type-incorrect-error.html'
      Then error EBR-082 is reported
      And no other errors or warnings are reported

  Rule: the primary entry page SHOULD NOT be in the spine

    Example: report if the primary entry page is in the spine
      When checking file set 'index-in-spine-warning'
      Then warning EBR-083 is reported
      And no other errors or warnings are reported

  Rule: the primary entry page MAY include `script` elements if it is out of spine

    Example: allow a `script` element if the navigation is not in the spine
      When checking file set 'script-out-of-spine-valid'
      Then no other errors or warnings are reported

    Example: report a `script` element if the navigation is in the spine
      When checking file set 'script-when-in-spine-error'
      Then error EBR-040 is reported
      And warning EBR-083 is reported (side effect of index being in spine)
      And no other errors or warnings are reported


  ## 8.3 Navigation

  ## 8.3.1 Table of contents

  Rule: the table of contents MUST also be identified by the role "doc-toc"

    Example: report a table of content with no "doc-toc" role
      Given EPUBCheck configured to check a navigation document
      When checking file set 'index-toc-no-role-error.html'
      Then error EBR-084 is reported
      And no other errors or warnings are reported

  ## 8.3.2 Page list

  Rule: the table of contents MUST also be identified by the role "doc-pagelist"

    Example: allow a conforming page list
      Given EPUBCheck configured to check a navigation document
      When checking file set 'index-pagelist-valid.html'
      Then no errors or warnings are reported

    Example: report a page list with no "doc-pagelist" role
      Given EPUBCheck configured to check a navigation document
      When checking file set 'index-pagelist-no-role-error.html'
      Then error EBR-085 is reported
      And no other errors or warnings are reported

  Rule: Each entry in the page list MUST include the print page number equivalent in a title attribute

    Example: report missing 'title' attributes on page list entries
      Given EPUBCheck configured to check a navigation document
      When checking file set 'index-pagelist-a-no-title-error.html'
      Then error EBR-086 is reported
      And no other errors or warnings are reported

