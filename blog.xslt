<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                exclude-result-prefixes="exslt msxsl">
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
  <xsl:include href="header_footer.xslt"/>
  <xsl:include href="blog_head_area.xslt"/>
  <xsl:include href="util.xslt"/>
  <xsl:include href="html.xslt"/>
  <!--<xsl:include href="ie.xslt"/>-->

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
              <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/user_edit_home.gif" alt="Eingetragen von" />
              <!-- Print the names of the authors -->
              <span class="postedby">
                <xsl:text>Eingetragen von </xsl:text>
                <xsl:variable name="authors_root">
                  <xsl:call-template name="authors-from-article">
                    <xsl:with-param name="authors" select="."/>
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
              <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/folder_page_home.gif" alt="Filed To" />
              <span class="filedto">
                <xsl:text>Abgelegt unter </xsl:text>
                <xsl:variable name="categories_root">
                  <xsl:call-template name="categories-from-article">
                    <xsl:with-param name="categories" select="."/>
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
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="print_categories_list">
    <ul>
      <xsl:for-each select="document('categories.xml')/categories/category">
        <xsl:sort select="."/>
        <!-- For current current category add 'current-cat' after 'cat-item' -->
        <li class="cat-item">
          <xsl:call-template name="show_all_articles_of_category_a">
            <xsl:with-param name="category" select="."/>
          </xsl:call-template>
          <xsl:text> (</xsl:text>69<xsl:text>)</xsl:text>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template name="print_authors_list">
    <ul>
      <xsl:for-each select="document('authors.xml')/authors/author">
        <xsl:sort select="surname"/>
        <xsl:sort select="prename"/>
        <li>
          <xsl:call-template name="show_all_articles_of_author_a">
            <xsl:with-param name="prename" select="prename"/>
            <xsl:with-param name="surname" select="surname"/>
          </xsl:call-template>
          <xsl:text> (</xsl:text>42<xsl:text>)</xsl:text>
        </li>
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
        <title>
          <xsl:value-of select="/page/title" />
        </title>
      </head>
      <body>
        <xsl:call-template name="header" />
        <div id="page">
          <div id="wrap">
            <div id="sidebar">
              <h2>Suche</h2>
              <form method="get" id="searchform" action="http://www.aber-glaube.net/blog">
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
            <div class="archivetitle">
              <h2>Archiv ':: Internes'</h2>
            </div>
            <div class="navigation">
              <div class="alignleft"></div>
              <div class="alignright"></div>
            </div>

            <xsl:call-template name="print_articles" />
            
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
