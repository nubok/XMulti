<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
  <xsl:include href="header_footer.xslt"/>
  <xsl:include href="blog_head_area.xslt"/>
  <xsl:include href="util.xslt"/>
  
  <!-- Text in paragraph in article -->
  <xsl:template match="p/text()">
    <xsl:value-of select="."/>
  </xsl:template>

  <!-- Links in paragraph in article -->
  <xsl:template match="p/a">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@href"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </a>
  </xsl:template>
  
  <!-- Print the articles -->
  <xsl:template match="/articles">
    <xsl:for-each select="article">
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
          <xsl:for-each select="content/p">
            <p>
              <xsl:apply-templates/>
            </p>
          </xsl:for-each>
        </div>
        <div class="entrymeta">
          <div class="postinfo">
            <p>
              <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/user_edit_home.gif" alt="Eingetragen von" />
              <!-- Print the names of the authors -->
              <span class="postedby">
                Eingetragen von
                <xsl:for-each select="authors/author">
                  <xsl:call-template name="format-author">
                    <xsl:with-param name="author-id" select="@id"/>
                    <xsl:with-param name="authors" select="document('authors.xml')"/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
                </xsl:for-each>
              </span>

              <br />
              <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/folder_page_home.gif" alt="Filed To" />
              <span class="filedto">
                Abgelegt unter:
                <a href="http://www.aber-glaube.net/blog/?cat=1" title="Alle Artikel in :: Internes anzeigen" rel="category">:: Internes</a>,  <a href="http://www.aber-glaube.net/blog/?cat=5" title="Alle Artikel in :: für Pädagogen anzeigen" rel="category">:: für Pädagogen</a>,  <a href="http://www.aber-glaube.net/blog/?cat=6" title="Alle Artikel in :: für Unternehmer anzeigen" rel="category">:: für Unternehmer</a>
              </span>
            </p>
            <p>&#xA0;</p>
          </div>
        </div>
      </div>
    </xsl:for-each>
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
              <ul>
                <li class="cat-item cat-item-5">
                  <a href="http://www.aber-glaube.net/blog/?cat=5" title="Alle in :: für Pädagogen gespeicherten Artikel anzeigen">:: für Pädagogen</a> (1)
                </li>
                <li class="cat-item cat-item-6">
                  <a href="http://www.aber-glaube.net/blog/?cat=6" title="Alle in :: für Unternehmer gespeicherten Artikel anzeigen">:: für Unternehmer</a> (1)
                </li>
                <li class="cat-item cat-item-1 current-cat">
                  <a href="http://www.aber-glaube.net/blog/?cat=1" title="Alle in :: Internes gespeicherten Artikel anzeigen">:: Internes</a> (3)
                </li>
              </ul>
              <br />
              <h2>Autoren</h2>
              <ul>
                <li>
                  <a href="http://www.aber-glaube.net/blog/?author=1" title="Beiträge von admin">Christian Romacker</a> (3)
                </li>
              </ul>
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

            <xsl:apply-templates select="document('articles.xml')/articles" />

            <div class="entry-archive">
              <div class="entrytitle">
                <h2>
                  <a href="http://www.aber-glaube.net/blog/?p=9" rel="bookmark" title="Permanent Link to Neuer Testbeitrag">Neuer Testbeitrag</a>
                </h2>
              </div>

              <h3>30. Mai 2009</h3>

              <div class="entrybody">
                <p>Dies ist ein zweiter Testbeitrag</p>
              </div>
              <div class="entrymeta">
                <div class="postinfo">

                  <p>
                    <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/user_edit_home.gif" alt="Eingetragen von" />
                    <span class="postedby">
                      Eingetragen von
                      admin
                    </span>

                    <br />
                    <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/folder_page_home.gif" alt="Filed To" />
                    <span class="filedto">
                      Abgelegt unter:
                      <a href="http://www.aber-glaube.net/blog/?cat=1" title="Alle Artikel in :: Internes anzeigen" rel="category">:: Internes</a>,  <a href="http://www.aber-glaube.net/blog/?cat=5" title="Alle Artikel in :: für Pädagogen anzeigen" rel="category">:: für Pädagogen</a>,  <a href="http://www.aber-glaube.net/blog/?cat=6" title="Alle Artikel in :: für Unternehmer anzeigen" rel="category">:: für Unternehmer</a>
                    </span>
                  </p>
                  <p>&#xA0;</p>
                </div>
              </div>
            </div>

            <div class="entry-archive">
              <div class="entrytitle">
                <h2>
                  <a href="http://www.aber-glaube.net/blog/?p=3" rel="bookmark" title="Permanent Link to Test">Test</a>
                </h2>
              </div>
              <h3>18. Oktober 2008</h3>

              <div class="entrybody">
                <p>Sehr geehrter Besucher,</p>

                <p>Hier entsteht in enger Zusammenarbeit mit Behörden, Parteien, Religionsgemeinschaften und privaten Organisationen das Internet-Portal für „Sekten“ -Aussteiger, -Betroffene, Pädagogen und Unternehmrer in Deutschland, Österreich und der Schweiz.</p>
                <p>Bitte haben Sie Verständnis, dass bedingt durch die Fülle an Informationen und Recherchen noch kein funktionierender Web-Auftritt möglich ist.</p>
                <p>
                  Alle Inhalte, die in der nächsten Zeit hier zu finden sind, dienen vorerst nur zu Testzwecken. Interessierte können sich jedoch schon jetzt über unser <a href="../../kontaktformular.html">Kontaktformular</a> an uns wenden.
                </p>
                <p>Ihr Aber-Glaube Team</p>
              </div>
              <div class="entrymeta">
                <div class="postinfo">

                  <p>
                    <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/user_edit_home.gif" alt="Eingetragen von" />
                    <span class="postedby">
                      Eingetragen von
                      admin
                    </span>


                    <br />
                    <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/folder_page_home.gif" alt="Filed To" />
                    <span class="filedto">
                      Abgelegt unter:
                      <a href="http://www.aber-glaube.net/blog/?cat=1" title="Alle Artikel in :: Internes anzeigen" rel="category">:: Internes</a>
                    </span>

                  </p>
                  <p>&#xA0;</p>
                </div>
              </div>
            </div>

            <div class="entry-archive">
              <div class="entrytitle">
                <h2>
                  <a href="http://www.aber-glaube.net/blog/?p=1" rel="bookmark" title="Permanent Link to Herzlich Willkommen!">Herzlich Willkommen!</a>
                </h2>
              </div>

              <h3>4. Oktober 2008</h3>

              <div class="entrybody">
                <p>Willkommen bei WordPress. Dies ist Ihr erster Beitrag. Bearbeiten oder löschen Sie Ihn, und fangen Sie dann mit dem Bloggen an!</p>
              </div>
              <div class="entrymeta">
                <div class="postinfo">

                  <p>
                    <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/user_edit_home.gif" alt="Eingetragen von" />
                    <span class="postedby">
                      Eingetragen von
                      admin
                    </span>

                    <br />
                    <img src="http://www.aber-glaube.net/blog/wp-content/themes/theorem_deutsch/images/icons/gif/folder_page_home.gif" alt="Filed To" />
                    <span class="filedto">
                      Abgelegt unter:
                      <a href="http://www.aber-glaube.net/blog/?cat=1" title="Alle Artikel in :: Internes anzeigen" rel="category">:: Internes</a>
                    </span>
                  </p>
                  <p>&#xA0;</p>
                </div>
              </div>
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
