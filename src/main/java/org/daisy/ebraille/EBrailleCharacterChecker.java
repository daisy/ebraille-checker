package org.daisy.ebraille;

import org.w3c.epubcheck.core.AbstractChecker;

import com.adobe.epubcheck.api.EPUBLocation;
import com.adobe.epubcheck.messages.MessageId;
import com.adobe.epubcheck.opf.ValidationContext;
import com.google.common.base.Preconditions;
import com.ibm.icu.lang.UCharacter;
import com.ibm.icu.text.UCharacterIterator;
import com.ibm.icu.text.UForwardCharacterIterator;
import com.ibm.icu.text.UnicodeSet;

public class EBrailleCharacterChecker extends AbstractChecker
{

  private final EPUBLocation location;
  private final char[] charray;
  private final int start;
  private final int length;

  public EBrailleCharacterChecker(ValidationContext context, String string,
      EPUBLocation location)
  {
    this(context, Preconditions.checkNotNull(string).toCharArray(), 0, string.length(), location);
  }

  public EBrailleCharacterChecker(ValidationContext context, char[] chars, int start, int length,
      EPUBLocation location)
  {
    super(context);
    this.charray = chars;
    this.start = start;
    this.length = length;
    this.location = location;
  }

  private static final UnicodeSet ALLOWED = new UnicodeSet()
      .addAll(0x2800, 0x28FF) // Braille patterns
      .add(0x0009) // TAB
      .add(0x000A) // LF
      .add(0x000D) // CR
      .add(0x0020) // SPACE
      .add(0x00A0) // NO-BREAK SPACE
      .add(0x00AD) // SOFT HYPHEN
      .freeze();

  @Override
  public void check()
  {
    StringBuilder disallowedString = new StringBuilder();

    UCharacterIterator chars = UCharacterIterator.getInstance(charray, start, start + length);
    int contextSize = 15;
    int countdown = contextSize;
    int codepoint;
    while (countdown > 0 && (codepoint = chars.nextCodePoint()) != UForwardCharacterIterator.DONE)
    {
      if (countdown < contextSize || !ALLOWED.contains(codepoint))
      {
        disallowedString.append(UCharacter.toString(codepoint));
        countdown--;
      }
    }

    if (disallowedString.length() > 0)
    {
      if (countdown == 0) disallowedString.append("(…)");
      report.message(MessageId.EBR_030, location, disallowedString.toString());
    }

  }

}
