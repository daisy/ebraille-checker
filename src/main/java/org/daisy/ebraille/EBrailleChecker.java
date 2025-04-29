package org.daisy.ebraille;

import java.io.File;

import org.w3c.epubcheck.constants.MIMEType;
import org.w3c.epubcheck.core.Checker;
import org.w3c.epubcheck.util.url.URLUtils;

import com.adobe.epubcheck.api.EPUBProfile;
import com.adobe.epubcheck.api.Report;
import com.adobe.epubcheck.ocf.OCFChecker;
import com.adobe.epubcheck.opf.ValidationContext.ValidationContextBuilder;
import com.adobe.epubcheck.util.FileResourceProvider;

public class EBrailleChecker implements Checker
{

  private File file;
  private Report report;


  /**
   * Create an epub validator to validate the given file and report issues to a
   * given Report object. Can validate a specific EPUB profile (e.g. EDUPUB,
   * DICT, IDX, etc).
   * 
   */
  public EBrailleChecker(File file, Report report)
  {
    this.file = file;
    this.report = report;
  }
  
  @Override
  public void check()
  {
    OCFChecker checker = new OCFChecker(new ValidationContextBuilder().url(URLUtils.toURL(file))
        .mimetype(MIMEType.EPUB.toString())
        .resourceProvider(new FileResourceProvider(file)).report(report).profile(EPUBProfile.EBRAILLE)
        .build());
    checker.check();
  }

}
