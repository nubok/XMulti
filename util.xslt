﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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

  <xsl:template name="categories-from-article">
    <xsl:param name="categories"/>

    <categories>
      <xsl:for-each select="document('categories.xml')/categories/category">
        <xsl:sort select="."/>

        <xsl:variable name="act_category" select="."/>

        <xsl:for-each select="$categories/categories/category">
          <xsl:if test="@id=$act_category/@id">
            <category>
              <xsl:attribute name="id">
                <xsl:value-of select="$act_category/@id"/>
              </xsl:attribute>
              <category>
                <xsl:value-of select="$act_category"/>
              </category>
            </category>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </categories>
  </xsl:template>

  <xsl:template name="authors-from-article">
    <xsl:param name="authors"/>

    <authors>
      <xsl:for-each select="document('authors.xml')/authors/author">
        <xsl:sort select="surname"/>
        <xsl:sort select="prename"/>

        <xsl:variable name="act_author" select="."/>

        <xsl:for-each select="$authors/authors/author">
          <xsl:if test="@id=$act_author/@id">
            <author>
              <xsl:attribute name="id">
                <xsl:value-of select="$act_author/@id"/>
              </xsl:attribute>
              <prename>
                <xsl:value-of select="$act_author/prename"/>
              </prename>
              <surname>
                <xsl:value-of select="$act_author/surname"/>
              </surname>
            </author>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </authors>
  </xsl:template>

  <xsl:template name="show_all_articles_of_author_a">
    <xsl:param name="prename"/>
    <xsl:param name="surname"/>
    <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="href">#</xsl:attribute>
      <xsl:attribute name="title">
        <xsl:text>Alle Artikel von </xsl:text>
        <xsl:value-of select="$prename"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$surname"/>
        <xsl:text> anzeigen</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$prename"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$surname"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="show_all_articles_of_category_a">
    <xsl:param name="category"/>

    <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="href">#</xsl:attribute>
      <xsl:attribute name="title">
        <xsl:text>Alle in '</xsl:text>
        <xsl:value-of select="$category"/>
        <xsl:text>' gespeicherten Artikel anzeigen</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$category"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
