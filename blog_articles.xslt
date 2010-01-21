<?xml version="1.0" encoding="utf-8"?>
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
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                exclude-result-prefixes="exslt msxsl">
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

  <xsl:include href="util.xslt"/>
  <xsl:include href="html.xslt"/>

  <xsl:param name="type"/>
  <xsl:param name="value"/>

  <xsl:template match="/">
    <xsl:call-template name="print_articles"/>
  </xsl:template>

  <!-- Print the articles -->
  <xsl:template name="print_articles">
    <xsl:for-each select="document('articles.xml')/articles/article">
      <!-- Order articles by date and time -->
      <xsl:sort order="descending" select="creation_timestamp/@year" data-type="number" />
      <xsl:sort order="descending" select="creation_timestamp/@month" data-type="number" />
      <xsl:sort order="descending" select="creation_timestamp/@day" data-type="number" />
      <xsl:sort order="descending" select="creation_timestamp/@hours" data-type="number" />
      <xsl:sort order="descending" select="creation_timestamp/@minutes" data-type="number" />
      <xsl:sort order="descending" select="creation_timestamp/@seconds" data-type="number" />

      <xsl:choose>
        <xsl:when test="$type=''">
          <xsl:apply-templates mode="print-article" select="."/>
        </xsl:when>
        <xsl:when test="$type='category'">
          <xsl:for-each select="categories/category">
            <xsl:if test="@id=$value">
              <xsl:apply-templates mode="print-article" select="../.."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="$type='author'">
          <xsl:for-each select="authors/author">
            <xsl:if test="@id=$value">
              <xsl:apply-templates mode="print-article" select="../.."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="print-article" match="*">
    <div class="entry-archive">
      <!-- Print title of article -->
      <div class="entrytitle">
        <h2>
          <a href="#">
            <xsl:value-of select="title"/>
          </a>
        </h2>
      </div>
      <!-- Print date of creation -->
      <h3>
        <xsl:call-template name="format-date">
          <xsl:with-param name="year" select="creation_timestamp/@year"/>
          <xsl:with-param name="month" select="creation_timestamp/@month"/>
          <xsl:with-param name="day" select="creation_timestamp/@day"/>
        </xsl:call-template>
      </h3>
      <!-- Print article content -->
      <div class="entrybody">
        <xsl:apply-templates mode="html" select="content/*"/>
      </div>
      <div class="entrymeta">
        <div class="postinfo">
          <p>
            <img src="themes/XMulti/images/User.png" class="icon" alt="Eingetragen von" />
            <!-- Print the names of the authors -->
            <span class="postedby">
              <xsl:text>Eingetragen von </xsl:text>
              <xsl:variable name="authors_root">
                <xsl:call-template name="author-names-from-author-ids">
                  <xsl:with-param name="authors-ids" select="."/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:for-each select="exslt:node-set($authors_root)/authors/author">
                <xsl:call-template name="show_all_articles_of_author_a">
                  <xsl:with-param name="prename" select="prename"/>
                  <xsl:with-param name="surname" select="surname"/>
                </xsl:call-template>
                <xsl:if test="position()!=last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </span>
            <br />
            <img src="themes/XMulti/images/Folder.png" class="icon" alt="Abgelegt unter" />
            <span class="filedto">
              <xsl:text>Abgelegt unter </xsl:text>
              <xsl:variable name="categories_root">
                <xsl:call-template name="category-names-from-category-ids">
                  <xsl:with-param name="category-ids" select="."/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:for-each select="exslt:node-set($categories_root)/categories/category">
                <xsl:call-template name="show_all_articles_of_category_a">
                  <xsl:with-param name="category" select="."/>
                </xsl:call-template>
                <xsl:if test="position()!=last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </span>
          </p>
          <p>&#xA0;</p>
        </div>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>