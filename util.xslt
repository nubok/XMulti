﻿<?xml version="1.0" encoding="utf-8"?>
<!--
Copyright (c) 2009-2010, Wolfgang Keller
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    3. The name of the author may not be used to endorse or promote products derived from this software without specific prior written permission. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:include href="util_language.xslt"/>

  <xsl:template name="format-date">
    <xsl:param name="year"/>
    <xsl:param name="month"/>
    <xsl:param name="day"/>
    <xsl:param name="lang"/>
    
    <xsl:value-of select="$day"/>
    <xsl:text>. </xsl:text>
    <xsl:call-template name="print-string">
      <xsl:with-param name="id" select="concat('month_', $month)"/>
      <xsl:with-param name="lang" select="$lang"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$year"/>
  </xsl:template>

  <xsl:template name="category-names-from-category-ids">
    <xsl:param name="category-ids"/>

    <categories>
      <xsl:for-each select="document('categories.xml')/categories/category">
        <xsl:sort select="."/>

        <xsl:variable name="act_category" select="."/>

        <xsl:for-each select="$category-ids/categories/category[@id=$act_category/@id]">
          <category>
            <xsl:attribute name="id">
              <xsl:value-of select="$act_category/@id"/>
            </xsl:attribute>
            <category>
              <xsl:value-of select="$act_category"/>
            </category>
          </category>
        </xsl:for-each>
      </xsl:for-each>
    </categories>
  </xsl:template>

  <xsl:template name="author-names-from-author-ids">
    <xsl:param name="authors-ids"/>

    <authors>
      <xsl:for-each select="document('authors.xml')/authors/author">
        <xsl:sort select="surname"/>
        <xsl:sort select="prename"/>

        <xsl:variable name="act_author" select="."/>

        <xsl:for-each select="$authors-ids/authors/author[@id=$act_author/@id]">
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
        </xsl:for-each>
      </xsl:for-each>
    </authors>
  </xsl:template>

  <xsl:template name="articles-from-category-id">
    <xsl:param name="category-id"/>

    <articles>
      <xsl:for-each select="document('articles.xml')/articles/article">
        <xsl:variable name="act-category">
          <xsl:copy-of select="."/>
        </xsl:variable>
        <xsl:for-each select="categories/category[@id=$category-id]">
          <xsl:copy-of select="$act-category"/>
        </xsl:for-each>
      </xsl:for-each>
    </articles>
  </xsl:template>

  <xsl:template name="articles-from-author-id">
    <xsl:param name="author-id"/>

    <articles>
      <xsl:for-each select="document('articles.xml')/articles/article">
        <xsl:variable name="act-article">
          <xsl:copy-of select="."/>
        </xsl:variable>
        <xsl:for-each select="authors/author[@id=$author-id]">
          <xsl:copy-of select="$act-article"/>
        </xsl:for-each>
      </xsl:for-each>
    </articles>
  </xsl:template>

  <xsl:template name="create-navigation-link">
    <xsl:param name="type"/><!-- empty string, article, category etc. -->
    <xsl:param name="type-value"/><!-- empty string, article, category etc. -->
    <xsl:param name="title"/><!-- the title of the link -->
    <xsl:param name="text"/><!-- the text to appear in the link (already translated) -->
    <xsl:param name="lang"/>

    <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="href">#</xsl:attribute>
      <xsl:attribute name="onclick">
        <xsl:text>javascript:createContent(this, '</xsl:text>
        <xsl:value-of select="$type"/>
        <xsl:text>', '</xsl:text>
        <xsl:value-of select="$type-value"/>
        <xsl:text>', '</xsl:text>
        <xsl:value-of select="$lang"/>
        <xsl:text>');</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:value-of select="$title"/>
      </xsl:attribute>
      <xsl:value-of select="$text"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="show_home_a">
    <xsl:param name="lang"/>

    <xsl:call-template name="create-navigation-link">
      <xsl:with-param name="title">
        <xsl:call-template name="print-string">
          <xsl:with-param name="id">to_start_page</xsl:with-param>
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="text">
        <xsl:call-template name="print-string">
          <xsl:with-param name="id">home</xsl:with-param>
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="lang" select="$lang"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="show_all_articles_of_author_a">
    <xsl:param name="id"/>
    <xsl:param name="prename"/>
    <xsl:param name="surname"/>
    <xsl:param name="lang"/>

    <xsl:call-template name="create-navigation-link">
      <xsl:with-param name="type">author</xsl:with-param>
      <xsl:with-param name="type-value" select="$id"/>
      <xsl:with-param name="title">
        <xsl:call-template name="print-string">
          <xsl:with-param name="id">show_all_articles_of_author_1</xsl:with-param>
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>
        <xsl:value-of select="$prename"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$surname"/>
        <xsl:call-template name="print-string">
          <xsl:with-param name="id">show_all_articles_of_author_2</xsl:with-param>
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="text">
        <xsl:value-of select="$prename"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$surname"/>
      </xsl:with-param>
      <xsl:with-param name="lang" select="$lang"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="show_all_articles_of_category_a">
    <xsl:param name="id"/>
    <xsl:param name="category"/>
    <xsl:param name="lang"/>

    <xsl:call-template name="create-navigation-link">
      <xsl:with-param name="type">category</xsl:with-param>
      <xsl:with-param name="type-value" select="$id"/>
      <xsl:with-param name="title">
        <xsl:call-template name="print-string">
          <xsl:with-param name="id">show_all_articles_of_category_1</xsl:with-param>
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>
        <xsl:value-of select="$category"/>
        <xsl:call-template name="print-string">
          <xsl:with-param name="id">show_all_articles_of_category_2</xsl:with-param>
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="text">
        <xsl:value-of select="$category"/>
      </xsl:with-param>
      <xsl:with-param name="lang" select="$lang"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="body-onload">
    <xsl:param name="xmlUrl"/>
    <xsl:param name="xsltUrl"/>
    <xsl:attribute name="onload">
      <xsl:text>initXSLT('</xsl:text>
      <xsl:value-of select="$xmlUrl"/>
      <xsl:text>', '</xsl:text>
      <xsl:value-of select="$xsltUrl"/>
      <xsl:text>');</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="get-language">
    <xsl:value-of select="@lang"/>
  </xsl:template>
</xsl:stylesheet>
