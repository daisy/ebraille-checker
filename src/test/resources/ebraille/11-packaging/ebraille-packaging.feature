Feature: eBraille — Packaging
  
  Checks conformance to the "Packaging" section of eBraille:
    https://daisy.github.io/ebraille/published/1.0/#ebrl-packaging


  Background: 
    Given the test files located at '/ebraille/11-packaging/files/'
    And EPUBCheck configured with the 'EBRAILLE' profile

   Rule: 'mimetype' and 'container.xml' MAY be omitted if an eBraille publication is not packaged

     Example: an unpackaged file set with no meta files is conforming
       When checking file set 'fileset-no-meta-files'
       Then no errors or warnings are reported

     Example: an unpackaged file set with meta files is conforming
       When checking file set 'fileset-with-meta-files'
       Then no errors or warnings are reported

   Rule: a package eBraille publication MUST be a conforming OCF ZIP container

     Example: a minimal packaged ebraille is conforming
       When checking file 'minimal.ebrl'
       Then no errors or warnings are reported

     Example: a packaged ebraille must contain a 'mimetype' file
       When checking file 'ocf-mimetype-file-missing-error.ebrl'
       Then error PKG-006 is reported
       And no other errors or warnings are reported

     Example: a packaged ebraille must contain a conforming 'mimetype' file
       When checking file 'ocf-mimetype-file-incorrect-value-error.ebrl'
       Then error PKG-007 is reported
       And no other errors or warnings are reported

     Example:  a packaged ebraille must contain a 'META-INF/container' file
       When checking file 'ocf-container-file-missing-error.ebrl'
       Then fatal error RSC-002 is reported
       And no other errors or warnings are reported

   Rule: a package eBraille publication MUST use the extension '.ebrl'

     Example: a packaged ebraille with the '.ebrl' extension is conforming
       Given the reporting level is set to USAGE
       When checking file 'minimal.ebrl'
       Then no other usage is reported

     Example: a packaged ebraille with the '.epub' extension is reported
       When checking file 'extension-invalid.epub'
       Then error EBR-001 is reported
       And no other errors or warnings are reported

     Example: a packaged ebraille with the no extension is reported
       When checking file 'extension-missing'
       Then error EBR-001 is reported
       And no other errors or warnings are reported
