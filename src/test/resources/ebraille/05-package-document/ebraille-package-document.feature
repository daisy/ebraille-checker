Feature: eBraille — Package document
  
  Checks conformance to the "Package document" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-package-doc


  Background: 
    Given the test files located at '/ebraille/05-package-document/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

  ## 5.2 The `package` element

  Rule: the package element must conform to the requirements in EPUB

    This is covered by EPUB checks.

  ## 5.3 Metadata
  
  ### 5.3.3 Required metadata

  Rule: The REQUIRED `dc:creator` element identifies the name(s) of the primary author, editor, etc

    Example: allow multiple `dc:creator` elements
      When checking file set 'metadata-dc-creator-valid'
      Then no errors or warnings are reported

    Example: report when `dc:creator` metadata is missing
      When checking file set 'metadata-dc-creator-missing-error'
      Then error EBR-007 is reported
      And no other errors or warnings are reported

  Rule: The REQUIRED `dc:date` element defines the publication date

    Example: report when `dc:date` metadata is missing
      When checking file set 'metadata-dc-date-missing-error'
      Then error EBR-007 is reported
      And no other errors or warnings are reported

    Example: report when `dc:date` metadata occurs more than once
      When checking file set 'metadata-dc-date-many-error'
      Then error RSC-005 is reported
      And no other errors or warnings are reported

  Rule: The `dc:date` value SHOULD BE conforming to IS0 8601
  
    Example: TODO

  Rule: The REQUIRED `dc:format` element identifies version of the eBraille standard an publication conforms to. The value MUST contain both the case-sensitive name "eBraille" and the version number.

    Example: report when `dc:date` metadata is missing
      When checking file set 'metadata-dc-format-missing-error'
      Then error EBR-007 is reported
      And no other errors or warnings are reported

    Example: report `dc:format` metadata to occur more than once
      When checking file set 'metadata-dc-format-many-error'
      Then error EBR-008 is reported
      And no other errors or warnings are reported

  Rule: the `dc:format` value must be 'eBraille 1.0'

    Example: report when the `dc:format` value is not 'eBraille 1.0'
      When checking file set 'metadata-dc-format-value-error'
      Then error EBR-012 is reported
      And no other errors or warnings are reported

  Rule: The REQUIRED `dc:identifier` element contains an identifier for an eBraille publication, such as a UUID, DOI, or ISBN.

    Missing `dc:identifier` metadata is covered by EPUB checks

    Example: allow `dc:identifier` metadata to occur more than once
      When checking file set 'metadata-dc-identifier-many-valid'
      Then no errors or warnings are reported

  Rule: The `dc:identifier` value SHOULD be formatted using a Uniform Resource Name.

    Example: TODO

  Rule: The REQUIRED `dc:language` element identifies the language(s) of the eBraille publication.

    Example: report when `dc:language` metadata is missing
      Note: this is covered by EPUB checks
      When checking file set 'metadata-dc-language-missing-error'
      Then error RSC-005 is reported
      And no other errors or warnings are reported

    Example: allow `dc:language` metadata to occur more than once
      When checking file set 'metadata-dc-language-many-valid'
      Then no errors or warnings are reported

  Rule: The `dc:language` value MUST be a well-formed language tag.

    Example: report `dc:language` value not conforming to BCP47
      Note: this is covered by EPUB checks
      When checking file set 'metadata-dc-language-value-malformed-error'
      Then error OPF-092 is reported
      And no other errors or warnings are reported

  Rule: The `dc:language` language tag MUST include the script subtag Brai

    Example: report `dc:language` value with no 'Brai' subtag
      When checking file set 'metadata-dc-language-value-not-braille-error'
      Then error EBR-014 is reported
      And no other errors or warnings are reported

  Rule: The REQUIRED `dc:title` element identifies the title of the source material.

    Example: report when `dc:language` metadata is missing
      Note: this is covered by EPUB checks
      When checking file set 'metadata-dc-title-missing-error'
      Then error RSC-005 is reported
      And no other errors or warnings are reported

  Rule: The REQUIRED `dcterms:dateCopyrighted` property identifies the copyright date of the work being transcribed.

    Example: report when `dcterms:dateCopyrighted` metadata is missing
      When checking file set 'metadata-dcterms-dateCopyrighted-missing-error'
      Then error EBR-009 is reported
      And no other errors or warnings are reported

  Rule: The `dcterms:dateCopyrighted` value MUST be an ISO 8601-1 conformant date of the form YYYY-MM-DD, YYYY-MM, or YYYY

    Example: report when `dcterms:dateCopyrighted` metadata value is malformed
      When checking file set 'metadata-dcterms-dateCopyrighted-value-malformed-error'
      Then error EBR-015 is reported
      And no other errors or warnings are reported

  Rule: The REQUIRED `dcterms:modified` property identifies the date, in Coordinated Universal Time (UTC), on which an eBraille publication was last modified.

     This is covered by EPUB checks

  Rule: The REQUIRED `a11y:brailleCellType` property identifies whether the text of the eBraille publication is encoded using 6- or 8-dot braille characters.

    Example: report when `a11y:brailleCellType` metadata is missing
      When checking file set 'metadata-a11y-brailleCellType-missing-error'
      Then error EBR-009 is reported
      And no other errors or warnings are reported

    Example: report when `a11y:brailleCellType` metadata occurs more than once
      When checking file set 'metadata-a11y-brailleCellType-many-error'
      Then error EBR-010 is reported
      And no other errors or warnings are reported

  Rule: The `a11y:brailleCellType` value MUST be '6', '8', '6, 8', or '8, 6'

    Example: report when `a11y:brailleCellType` metadata value is malformed
      When checking file set 'metadata-a11y-brailleCellType-value-malformed-error'
      Then error EBR-016 is reported
      And no other errors or warnings are reported

  Rule: The REQUIRED `a11y:brailleSystem` property identifies the name of the braille system an eBraille publication has been formatted in conformance with.

    Example: report when `a11y:brailleSystem` metadata is missing
      When checking file set 'metadata-a11y-brailleSystem-missing-error'
      Then error EBR-009 is reported
      And no other errors or warnings are reported

    Example: allow `a11y:brailleSystem` metadata to occur more than once
      When checking file set 'metadata-a11y-brailleSystem-many-valid'
      Then no other errors or warnings are reported

  Rule: The `a11y:brailleSystem` value SHOULD be from the eBraille Braille Codes Registry

    Example: TODO

  Rule: The REQUIRED `a11y:completeTranscription` indicates whether the complete original work has been transcribed or not.

    Example: report when `a11y:completeTranscription` metadata is missing
      When checking file set 'metadata-a11y-completeTranscription-missing-error'
      Then error EBR-009 is reported
      And no other errors or warnings are reported

    Example: report when `a11y:completeTranscription` metadata occurs more than once
      When checking file set 'metadata-a11y-completeTranscription-many-error'
      Then error EBR-010 is reported
      And no other errors or warnings are reported

  Rule: the `a11y:completeTranscription` value MUST be true or false

    Example: report when `a11y:completeTranscription` metadata value is malformed
      When checking file set 'metadata-a11y-completeTranscription-value-malformed-error'
      Then error EBR-017 is reported
      And no other errors or warnings are reported

  Rule: The `a11y:producer` property identifies the name(s) of the organization(s) or individual(s) that produced the braille publication.

    Example: report when `a11y:producer` metadata is missing
      When checking file set 'metadata-a11y-producer-missing-error'
      Then error EBR-009 is reported
      And no other errors or warnings are reported

    Example: allow `a11y:producer` metadata to occur more than once
      When checking file set 'metadata-a11y-producer-many-valid'
      Then no other errors or warnings are reported

  Rule: The `a11y:tactileGraphics` property identifies whether an eBraille publication contains tactile graphics.

    Example: report when `a11y:tactileGraphics` metadata is missing
      When checking file set 'metadata-a11y-tactileGraphics-missing-error'
      Then error EBR-009 is reported
      And no other errors or warnings are reported

    Example: report when `a11y:tactileGraphics` metadata occurs more than once
      When checking file set 'metadata-a11y-tactileGraphics-many-error'
      Then error EBR-010 is reported
      And no other errors or warnings are reported

  Rule: The `a11y:tactileGraphics` value is 'none' or a list of known formats.

    Example: allow `a11y:tactileGraphics` metadata value "none"
      When checking file set 'metadata-a11y-tactileGraphics-value-none-valid'
      Then no other errors or warnings are reported

    Example: allow `a11y:tactileGraphics` metadata value "PNG"
      When checking file set 'metadata-a11y-tactileGraphics-value-single-valid'
      Then no other errors or warnings are reported

    Example: allow `a11y:tactileGraphics` metadata value "PNG, SVG, JPG, PDF "
      When checking file set 'metadata-a11y-tactileGraphics-value-list-valid'
      Then no other errors or warnings are reported

    Example: report when `a11y:tactileGraphics` metadata value is malformed
      When checking file set 'metadata-a11y-tactileGraphics-value-malformed-error'
      Then error EBR-018 is reported
      And no other errors or warnings are reported

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

