<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                exclude-result-prefixes="exslt msxsl">
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:include href="util.xslt"/>

  <xsl:template match="/">
    <xsl:text>Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.</xsl:text>
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

      <xsl:call-template name="print-article"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="print-article">
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