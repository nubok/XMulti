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
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  <xsl:include href="data/common/xslt/ie.xslt"/>
  <xsl:include href="header_footer.xslt"/>
  <xsl:include href="blog_head_elements.xslt"/>
  <xsl:include href="blog_articles.xslt"/>
  <xsl:include href="util_html.xslt"/>

  <xsl:template name="print_pages_list">
    <xsl:param name="lang"/>
    
    <ul>
      <li class="selected">
        <xsl:call-template name="show_home_a">
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>
      </li>
    </ul>
  </xsl:template>

  <xsl:template name="print_categories_list">
    <xsl:param name="lang"/>
    
    <ul>
      <xsl:for-each select="document('categories.xml')/categories/category">
        <xsl:sort select="."/>
        <xsl:variable name="articles-of-category">
          <xsl:call-template name="articles-from-category-id">
            <xsl:with-param name="category-id" select="@id"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="article-count" select="count(exslt:node-set($articles-of-category)/articles/article)"/>
        <xsl:if test="$article-count>0">
          <!-- For current current category add 'current-cat' after 'cat-item' -->
          <li class="cat-item">
            <xsl:call-template name="show_all_articles_of_category_a">
              <xsl:with-param name="id" select="@id"/>
              <xsl:with-param name="category" select="."/>
              <xsl:with-param name="lang" select="$lang"/>
            </xsl:call-template>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$article-count"/>
            <xsl:text>)</xsl:text>
          </li>
        </xsl:if>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template name="print_authors_list">
    <xsl:param name="lang"/>
    
    <ul>
      <xsl:for-each select="document('authors.xml')/authors/author">
        <xsl:sort select="surname"/>
        <xsl:sort select="prename"/>
        <xsl:variable name="articles-of-author">
          <xsl:call-template name="articles-from-author-id">
            <xsl:with-param name="author-id" select="@id"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="article-count" select="count(exslt:node-set($articles-of-author)/articles/article)"/>
        <xsl:if test="$article-count>0">
          <li>
            <xsl:call-template name="show_all_articles_of_author_a">
              <xsl:with-param name="id" select="@id"/>
              <xsl:with-param name="prename" select="prename"/>
              <xsl:with-param name="surname" select="surname"/>
              <xsl:with-param name="lang" select="$lang"/>
            </xsl:call-template>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$article-count"/>
            <xsl:text>)</xsl:text>
          </li>
        </xsl:if>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- Call main template -->
  <xsl:template match="/">
    <xsl:apply-templates select="document('page.xml')/page"/>
  </xsl:template>

  <!-- Main template -->
  <xsl:template match="/page">
    <xsl:variable name="lang">
      <xsl:call-template name="get-language"/>
    </xsl:variable>
    <html>
      <head>
        <xsl:call-template name="canonical_head_elements"/>
        <xsl:call-template name="blog_head_elements" />
      </head>
      <body>
        <xsl:call-template name="body-onload">
          <xsl:with-param name="xmlUrl">blog.xml</xsl:with-param>
          <xsl:with-param name="xsltUrl">blog_articles.xslt</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="header"/>
        <div id="page">
          <div id="wrap">
            <div id="sidebar">
              <h2>
                <xsl:call-template name="print-string">
                  <xsl:with-param name="lang" select="$lang"/>
                  <xsl:with-param name="id">search</xsl:with-param>
                </xsl:call-template>
              </h2>
              <form method="get" id="searchform" action="javascript:alert('Searching is not yet implemented.')">
                <div>
                  <input type="text" name="s" id="s" />
                </div>
              </form>
              <br/>
              <h2>
                <xsl:call-template name="print-string">
                  <xsl:with-param name="lang" select="$lang"/>
                  <xsl:with-param name="id">pages</xsl:with-param>
                </xsl:call-template>
              </h2>
              <xsl:call-template name="print_pages_list">
                <xsl:with-param name="lang" select="$lang"/>
              </xsl:call-template>
              <br/>
              <h2>
                <xsl:call-template name="print-string">
                  <xsl:with-param name="lang" select="$lang"/>
                  <xsl:with-param name="id">categories</xsl:with-param>
                </xsl:call-template>
              </h2>
              <xsl:call-template name="print_categories_list">
                <xsl:with-param name="lang" select="$lang"/>
              </xsl:call-template>
              <br/>
              <h2>
                <xsl:call-template name="print-string">
                  <xsl:with-param name="lang" select="$lang"/>
                  <xsl:with-param name="id">authors</xsl:with-param>
                </xsl:call-template>
              </h2>
              <xsl:call-template name="print_authors_list">
                <xsl:with-param name="lang" select="$lang"/>
              </xsl:call-template>
              <br />
            </div>
          </div>
          <div id="content">
            <div class="navigation">
              <div class="alignleft"/>
              <div class="alignright"/>
            </div>
            <div id="articleContainerDiv">
              <xsl:call-template name="print-articles">
                <xsl:with-param name="lang" select="$lang"/>
              </xsl:call-template>
            </div>
            <div class="navigation">
              <div class="alignleft"/>
              <div class="alignright"/>
            </div>
          </div>
          <xsl:call-template name="footer"/>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
