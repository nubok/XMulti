<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template name="format-date">
    <xsl:param name="year"/>
    <xsl:param name="month"/>
    <xsl:param name="day"/>
    <xsl:value-of select="$day"/>
    <xsl:text>. </xsl:text>
    <xsl:choose>
      <xsl:when test="$month=1">Januar</xsl:when>
      <xsl:when test="$month=2">Februar</xsl:when>
      <xsl:when test="$month=3">März</xsl:when>
      <xsl:when test="$month=4">April</xsl:when>
      <xsl:when test="$month=5">Mai</xsl:when>
      <xsl:when test="$month=6">Juni</xsl:when>
      <xsl:when test="$month=7">Juli</xsl:when>
      <xsl:when test="$month=8">August</xsl:when>
      <xsl:when test="$month=9">September</xsl:when>
      <xsl:when test="$month=10">Oktober</xsl:when>
      <xsl:when test="$month=11">November</xsl:when>
      <xsl:when test="$month=12">Dezember</xsl:when>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$year"/>
  </xsl:template>

  <!-- Generates an author name from author id -->
  <xsl:template name="format-author">
    <xsl:param name="author-id"/>
    <xsl:param name="authors"/>

    <xsl:for-each select="$authors/authors/author">
      <xsl:if test="@id=$author-id">
        <a href="#">
          <xsl:value-of select="prename"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="surname"/>
        </a>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- From given author ids this template generated an
  ordered list -->
  <xsl:template name="create-sorted-author-list">
    <!-- author-ids: <authors><author id="..."/><author id="..."/>...</authors> -->
    <xsl:param name="author-ids"/>
    <!-- author-ids: <authors><author id="...">properties</author><author id="...">properties</author>...</authors> -->
    <xsl:param name="authors"/>

    <xsl:variable name="authors-with-ids">
      <authors>
        <xsl:for-each select="$authors/authors/author">
          <xsl:sort select="surname"/>
          <xsl:sort select="prename"/>
          <xsl:variable name="act-author" select="."/>
          <xsl:for-each select="$author-ids/authors/author">
            <xsl:if test="@id=$act-author/@id">
              <author>
                <xsl:value-of select="."/>
              </author>
            </xsl:if>
          </xsl:for-each>
        </xsl:for-each>
      </authors>
    </xsl:variable>
  </xsl:template>
</xsl:stylesheet>
