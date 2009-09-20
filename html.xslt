<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="yes"/>

  <!-- Text in paragraph in article -->
  <xsl:template match="p/text()" mode="html">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="p/a/@href" mode="html">
    <xsl:copy />
  </xsl:template>

  <!-- Links in paragraph in article -->
  <xsl:template match="p/a" mode="html">
    <a>
      <xsl:apply-templates select="@* | node()" mode="html" />
    </a>
  </xsl:template>
  
  <xsl:template match="p" mode="html">
    <p>
      <xsl:apply-templates select="@* | node()" mode="html" />
    </p>
  </xsl:template>
</xsl:stylesheet>
