Feature: eBraille — eBraille file set

  Checks conformance to the "eBraille file set" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-fileset


  Background:
    Given the test files located at '/ebraille/04-ebraille-file-set/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

  ## 4.2 File and directory structure

  Rule: Publication resources MUST NOT be located outside the publication root

    Example: report references to remote audio content in HTML
      When checking file set 'resources-remote-audio-in-html-error'
      Then error RSC-006 is reported
      And no other errors or warnings are reported

    Example: report references to remote audio content in Media Overlays
      When checking file set 'resources-remote-audio-in-overlay-error'
      Then error RSC-006 is reported
      And no other errors or warnings are reported

    Example: report references to remote fonts
      When checking file set 'resources-remote-font-in-css-error'
      Then error RSC-006 is reported
      And no other errors or warnings are reported

    Example: report references to remote video content in HTML
      When checking file set 'resources-remote-video-in-html-error'
      Then error RSC-006 is reported
      And no other errors or warnings are reported

    Example: report references to remote resources even if not declared in the package document
      (here, the remote content is an audio file used in HTML)
      When checking file set 'resources-remote-item-undeclared-error'
      Then error RSC-006 is reported
      And no other errors or warnings are reported

    Example: report references to remote resources declared in the package document even if not used
      When checking file set 'resources-remote-item-unused-error'
      Then error RSC-006 is reported
      And no other errors or warnings are reported

  Rule: the package document MUST be in the publication root

    Example: report a package document no located in the publication root
      When checking file set 'package-doc-not-in-root-error'
      Then error EBR-003 is reported
      And no other errors or warnings are reported

  Rule: the package document MUST be named 'package.opf'

    Example: report a package document incorrectly named
      When checking file set 'package-doc-incorrect-name-error'
      Then error EBR-004 is reported
      And no other errors or warnings are reported

  Rule: the navigation document MUST be in the publication root

    Example: report a navigation document no located in the publication root
      When checking file set 'nav-doc-not-in-root-error'
      Then error EBR-005 is reported
      And no other errors or warnings are reported

  Rule: the navigation document MUST be named 'index.html'

    Example: report a navigation document incorrectly named
      When checking file set 'nav-doc-incorrect-name-error'
      Then error EBR-006 is reported
      And no other errors or warnings are reported

  ## 4.3 File paths and file names

  Rule: eBraille file paths and file names MUST adhere to the EPUB 3 file naming restrictions

   This is already covered by EPUB checks.

  ## 4.4 URLs in the file set

  Rule: eBraille file paths and file names MUST adhere to the EPUB 3 file naming restrictions

   This is a duplicate statement, already covered by checks for "4.2 File and directory structure".

  Rule: the eBraille file set MUST NOT include file references that use path-absolute-URL strings

   This is statement is redundant, already covered by EPUB (URLs in the OCF abstract container)

  ## 4.5 Multiple renditions

  Rule: an eBraille publication MAY contain multipled renditions of the content

#     Example: TODO
#       When checking file set ''
#       Then error XXX is reported
#       And no other errors or warnings are reported

  Rule: the default rendition MUST be a braille rendition

#     Example: TODO
#       When checking file set ''
#       Then error XXX is reported
#       And no other errors or warnings are reported
