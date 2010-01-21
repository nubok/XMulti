﻿<?xml version="1.0" encoding="utf-8"?>
<!--
Copyright (c) 2009-2010, Wolfgang Keller
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the Wolfgang Keller nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->
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

  <xsl:template name="category-names-from-category-ids">
    <xsl:param name="category-ids"/>

    <categories>
      <xsl:for-each select="document('categories.xml')/categories/category">
        <xsl:sort select="."/>

        <xsl:variable name="act_category" select="."/>

        <xsl:for-each select="$category-ids/categories/category">
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

  <xsl:template name="author-names-from-author-ids">
    <xsl:param name="authors-ids"/>

    <authors>
      <xsl:for-each select="document('authors.xml')/authors/author">
        <xsl:sort select="surname"/>
        <xsl:sort select="prename"/>

        <xsl:variable name="act_author" select="."/>

        <xsl:for-each select="$authors-ids/authors/author">
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

  <xsl:template name="articles-from-category-id">
    <xsl:param name="category-id"/>

    <articles>
      <xsl:for-each select="document('articles.xml')/articles/article">
        <xsl:variable name="act-category">
          <xsl:copy-of select="."/>
        </xsl:variable>
        <xsl:for-each select="categories/category">
          <xsl:if test="@id=$category-id">
            <xsl:copy-of select="$act-category"/>
          </xsl:if>
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
        <xsl:for-each select="authors/author">
          <xsl:if test="@id=$author-id">
            <xsl:copy-of select="$act-article"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </articles>
  </xsl:template>

  <xsl:template name="show_home_a">
    <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="href">
        <xsl:text>javascript:createContent('', '');</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:text>Zur Startseite</xsl:text>
      </xsl:attribute>
      <xsl:text>Home</xsl:text>
    </xsl:element>
  </xsl:template>

  <xsl:template name="show_all_articles_of_author_a">
    <xsl:param name="id"/>
    <xsl:param name="prename"/>
    <xsl:param name="surname"/>
    <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="href">
        <xsl:text>javascript:createContent('author', '</xsl:text>
        <xsl:value-of select="$id"/>
        <xsl:text>');</xsl:text>
      </xsl:attribute>
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
    <xsl:param name="id"/>
    <xsl:param name="category"/>

    <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="href">
        <xsl:text>javascript:createContent('category', '</xsl:text>
        <xsl:value-of select="$id"/>
        <xsl:text>');</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:text>Alle in '</xsl:text>
        <xsl:value-of select="$category"/>
        <xsl:text>' gespeicherten Artikel anzeigen</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$category"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="body_onload">
    <xsl:attribute name="onload">initXSLT();</xsl:attribute>
  </xsl:template>
</xsl:stylesheet>
