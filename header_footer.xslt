<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:hf="urn:schemas-xmulti:header-footer">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="node()" mode="header-footer">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@* | node()" mode="header-footer"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@* | comment() | text()" mode="header-footer">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="header-footer"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="header">
    <xsl:variable name="foo" select="document('header_footer.xml')"/>
    
    <xsl:for-each select="$foo/hf:header-footer/hf:header">
      <xsl:apply-templates mode="header-footer"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="footer">
    <xsl:for-each select="document('header_footer.xml')/hf:header-footer/hf:footer">
      <xsl:apply-templates mode="header-footer"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>