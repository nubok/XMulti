<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                exclude-result-prefixes="exslt msxsl">
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  <!--<xsl:include href="ie.xslt"/>-->
  <xsl:include href="header_footer.xslt"/>
  <xsl:include href="blog_head_area.xslt"/>
  <xsl:include href="blog_articles.xslt"/>
  <xsl:include href="html.xslt"/>

  <xsl:template name="print_categories_list">
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
              <xsl:with-param name="category" select="."/>
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
              <xsl:with-param name="prename" select="prename"/>
              <xsl:with-param name="surname" select="surname"/>
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
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="description">
          <xsl:attribute name="content">
            <xsl:value-of select="/page/description" />
          </xsl:attribute>
        </meta>
        <xsl:call-template name="head_area" />
        <script type="text/javascript" src="scripts/dynamic_xslt.js">
          <xsl:text> </xsl:text>
        </script>
        <title>
          <xsl:value-of select="/page/title" />
        </title>
      </head>
      <body>
        <xsl:call-template name="header"/>
        <div id="page">
          <div id="wrap">
            <div id="sidebar">
              <h2>Suche</h2>
              <form method="get" id="searchform" action="javascript:alert('Searching is not yet implemented.')">
                <div>
                  <input type="text" name="s" id="s" />
                </div>
              </form>
              <br />
              <h2>Seiten</h2>
              <ul>
                <li>
                  <a href="http://www.aber-glaube.net/blog/">Home</a>
                </li>
              </ul>
              <br />
              <h2>Kategorien</h2>
              <xsl:call-template name="print_categories_list" />
              <br />
              <h2>Autoren</h2>
              <xsl:call-template name="print_authors_list" />
              <br />
            </div>
          </div>
          <div id="content">
            <div class="navigation">
              <div class="alignleft"></div>
              <div class="alignright"></div>
            </div>
            <div id="articleContainerDiv">
              <xsl:call-template name="print_articles"/>
            </div>
            <div class="navigation">
              <div class="alignleft"></div>
              <div class="alignright"></div>
            </div>
          </div>
          <xsl:call-template name="footer" />
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
