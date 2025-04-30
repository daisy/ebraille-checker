package org.daisy.ebraille;

import static com.adobe.epubcheck.vocab.AccessibilityVocab.META_PROPERTIES.BRAILLE_CELL_TYPE;
import static com.adobe.epubcheck.vocab.AccessibilityVocab.META_PROPERTIES.BRAILLE_SYSTEM;
import static com.adobe.epubcheck.vocab.AccessibilityVocab.META_PROPERTIES.COMPLETE_TRANSCRIPTION;
import static com.adobe.epubcheck.vocab.AccessibilityVocab.META_PROPERTIES.PRODUCER;
import static com.adobe.epubcheck.vocab.AccessibilityVocab.META_PROPERTIES.TACTILE_GRAPHICS;
import static com.adobe.epubcheck.vocab.DCMESVocab.PROPERTIES.CREATOR;
import static com.adobe.epubcheck.vocab.DCMESVocab.PROPERTIES.DATE;
import static com.adobe.epubcheck.vocab.DCMESVocab.PROPERTIES.FORMAT;
import static com.adobe.epubcheck.vocab.DCMESVocab.PROPERTIES.IDENTIFIER;
import static com.adobe.epubcheck.vocab.DCMESVocab.PROPERTIES.LANGUAGE;

import java.time.chrono.IsoChronology;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.DateTimeParseException;
import java.time.format.ResolverStyle;
import java.time.temporal.ChronoField;
import java.util.IllformedLocaleException;
import java.util.List;
import java.util.Locale;
import java.util.regex.Pattern;
import java.util.stream.Stream;

import org.w3c.epubcheck.core.AbstractChecker;
import org.w3c.epubcheck.core.Checker;

import com.adobe.epubcheck.api.EPUBLocation;
import com.adobe.epubcheck.api.EPUBProfile;
import com.adobe.epubcheck.messages.MessageId;
import com.adobe.epubcheck.opf.MetadataSet;
import com.adobe.epubcheck.opf.MetadataSet.Metadata;
import com.adobe.epubcheck.opf.ValidationContext;
import com.adobe.epubcheck.vocab.AccessibilityVocab;
import com.adobe.epubcheck.vocab.DCMESVocab;
import com.adobe.epubcheck.vocab.ForeignVocabs;
import com.adobe.epubcheck.vocab.Property;
import com.google.common.base.Preconditions;

public class EBrailleMetadataChecker extends AbstractChecker implements Checker
{

  private static DateTimeFormatter ISO_8601_SIMPLE = new DateTimeFormatterBuilder()
      .appendPattern("yyyy[-MM[-dd]]")
      .parseDefaulting(ChronoField.ERA, 1)
      .toFormatter()
      .withChronology(IsoChronology.INSTANCE)
      .withResolverStyle(ResolverStyle.STRICT);
  private static Pattern BRAILLE_CELL_TYPE_VALUE = Pattern
      .compile("6|8|(6\\s*,\\s*8)|(8\\s*,\\s*6)");

  private final EPUBLocation location;
  private final MetadataSet metadata;

  public EBrailleMetadataChecker(ValidationContext context, MetadataSet metadata)
  {
    super(context);
    this.location = EPUBLocation.of(context);
    this.metadata = Preconditions.checkNotNull(metadata);
    Preconditions.checkState(context.profile == EPUBProfile.EBRAILLE);
  }

  @Override
  public void check()
  {
    Property property;
    // dc:creator
    checkRequiredElement(DCMESVocab.VOCAB.get(CREATOR));

    // dc:date
    checkRequiredElement(DCMESVocab.VOCAB.get(DATE));

    // dc:format
    property = DCMESVocab.VOCAB.get(FORMAT);
    if (checkRequiredElementNoRepeat(property))
    {
      String value = metadata.getPrimary(property).iterator().next().getValue().trim();
      if (!"eBraille 1.0".equals(value))
      {
        report.message(MessageId.EBR_012, location, value);
      }
    }

    // dc:identifier
    property = DCMESVocab.VOCAB.get(IDENTIFIER);
    if (checkRequiredElement(property))
    {
      metadata.getPrimary(property).stream().map(meta -> meta.getValue()).forEach(value -> {
        // TODO ebraille check the value is a URN
      });
    }

    // dc:language
    property = DCMESVocab.VOCAB.get(LANGUAGE);
    for (Metadata language : metadata.getPrimary(property))
    {
      try
      {
        Locale locale = new Locale.Builder().setLanguageTag(language.getValue()).build();
        if (!"Brai".equals(locale.getScript()))
        {
          report.message(MessageId.EBR_014, location, language.getValue());
        }
      } catch (IllformedLocaleException exception)
      {
        // do nothing, already reported
      }
    }

    // dc:title
    // covered by EPUB checks

    // dcterms:dateCopyrighted
    property = ForeignVocabs.DCTERMS_VOCAB.lookup("dateCopyrighted").get();
    if (checkRequiredProperty(property))
    {
      String value = metadata.getPrimary(property).iterator().next().getValue().trim();
      try
      {
        ISO_8601_SIMPLE.parse(value);
      } catch (DateTimeParseException e)
      {
        report.message(MessageId.EBR_015, location, value);
      }
    }

    // dcterms:modified
    // covered by EPUB checks

    // a11y:brailleCellType
    property = AccessibilityVocab.META_VOCAB.get(BRAILLE_CELL_TYPE);
    if (checkRequiredPropertyNoRepeat(property))
    {
      String value = metadata.getPrimary(property).iterator().next().getValue().trim();
      if (!BRAILLE_CELL_TYPE_VALUE.matcher(value).matches())
      {
        report.message(MessageId.EBR_016, location, value);
      }
    }

    // a11y:brailleSystem
    property = AccessibilityVocab.META_VOCAB.get(BRAILLE_SYSTEM);
    if (checkRequiredProperty(property))
    {
      // String value =
      // metadata.getPrimary(property).iterator().next().getValue().trim();
      // TODO ebraille check a11y:brailleSystem value
    }

    // a11y:completeTranscription
    property = AccessibilityVocab.META_VOCAB.get(COMPLETE_TRANSCRIPTION);
    if (checkRequiredPropertyNoRepeat(property))
    {
      String value = metadata.getPrimary(property).iterator().next().getValue().trim();
      if (!("true".equals(value) || "false".equals(value)))
      {
        report.message(MessageId.EBR_017, location, value);
      }
    }

    // a11y:producer
    property = AccessibilityVocab.META_VOCAB.get(PRODUCER);
    checkRequiredProperty(property);

    // a11y:tactileGraphics
    property = AccessibilityVocab.META_VOCAB.get(TACTILE_GRAPHICS);
    if (checkRequiredPropertyNoRepeat(property))
    {
      String value = metadata.getPrimary(property).iterator().next().getValue().trim();
      if (!(value.equals("none") || Pattern.compile(",").splitAsStream(value).map(s -> s.trim())
          .allMatch(s -> Stream.of("PNG", "SVG", "PDF", "JPG").anyMatch(s::equals))))
      {
        report.message(MessageId.EBR_018, location, value);
      }
    }
  }

  private boolean checkRequiredElement(Property property)
  {
    return checkRequired(property, true, true);
  }

  private boolean checkRequiredElementNoRepeat(Property property)
  {
    return checkRequired(property, false, true);
  }

  private boolean checkRequiredProperty(Property property)
  {
    return checkRequired(property, true, false);
  }

  private boolean checkRequiredPropertyNoRepeat(Property property)
  {
    return checkRequired(property, false, false);
  }

  private boolean checkRequired(Property property, boolean canRepeat, boolean isElement)
  {
    List<Metadata> result = metadata.getPrimary(property);
    if (result.isEmpty())
    {
      report.message((isElement) ? MessageId.EBR_007 : MessageId.EBR_009, EPUBLocation.of(context),
          property.getPrefixedName());
      return false;
    }
    if (!canRepeat && result.size() > 1)
    {
      report.message((isElement) ? MessageId.EBR_008 : MessageId.EBR_010, location,
          property.getPrefixedName());
    }
    return true;
  }

}
