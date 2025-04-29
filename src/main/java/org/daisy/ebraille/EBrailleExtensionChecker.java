package org.daisy.ebraille;

import org.w3c.epubcheck.core.Checker;

import com.adobe.epubcheck.api.EPUBLocation;
import com.adobe.epubcheck.api.Report;
import com.adobe.epubcheck.messages.MessageId;
import com.adobe.epubcheck.ocf.OCFContainer;
import com.adobe.epubcheck.opf.ValidationContext;
import com.adobe.epubcheck.util.ResourceUtil;
import com.google.common.base.Preconditions;

public class EBrailleExtensionChecker implements Checker
{
  private final ValidationContext context;
  private final OCFContainer container;
  private final Report report;
  private final String extension;

  public EBrailleExtensionChecker(ValidationContext context)
  {
    this.context = Preconditions.checkNotNull(context);
    this.report = Preconditions.checkNotNull(context.report);
    this.extension = ResourceUtil.getExtension(Preconditions.checkNotNull(context.path));
    this.container = Preconditions.checkNotNull(context.container.get());
  }

  @Override
  public void check()
  {
    if (container.isPackaged() && !"ebrl".equals(extension))
    {
      report.message(MessageId.EBR_001, EPUBLocation.of(context).context(extension));
    }
  }

}
