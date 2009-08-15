﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template name="header">
    <div class = "ag-logotext">aber-glaube.net</div>

    <div id="bodypicture-hauptseite">
      <a name="a7"  id="a7">&#xA0;</a>&#xA0;
    </div>

    <!--hauptnavigation-->
    <div id="ag-navcontainer">
      <ul>
        <li>
          <a href="../jugend.html">&#x2022; Für Kinder und Jugendliche ab 8</a>
        </li>
        <li>
          <a href="../allgemein.html">&#x2022; Für Aussteiger und Betroffene</a>
        </li>
        <li>
          <a href="../erziehung.html">&#x2022; Informationen für Pädagogen,...</a>
        </li>
        <li>
          <a href="../business.html">&#x2022; Informationen für Unternehmen</a>
        </li>
      </ul>
    </div>

    <!--metanavigation Sprachauswahl-->
    <div id="agmeta-navcontainer">
      <ul>
        <li>
          <a  class="current" href="#">deutsch</a>
        </li>
        <li>
          <a href="#">&#x2022; français</a>
        </li>
        <li>
          <a href="#">&#x2022; italiano</a>
        </li>
        <li>
          <a href="#">&#x2022; pусский</a>
        </li>
        <li>
          <a href="#">&#x2022; türkçe</a>
        </li>
      </ul>
    </div>

    <!--metanavigation zum Impressum-->
    <div id="agmeta-i-navcontainer">
      <ul>
        <li>
          <a href="../adressen/">&#x2022; Adressen</a>
        </li>
        <li>
          <a href="../infomaterial/">&#x2022; Infomaterial</a>
        </li>
        <li>
          <a class="current" href="#">&#x2022; News-Blog</a>
        </li>
        <li>
          <a href="../forum/">&#x2022; Forum</a>
        </li>
        <li>
          <a href="../impressum.html">&#x2022; Kontakt</a>
        </li>
      </ul>
    </div>

    <!--metanavigation zu hauptseite-->
    <div id="agmeta-h-navcontainer">
      <ul>
        <li>
          <a href="../hauptseite.html">&#x2022; Zurück zur Hauptseite</a>
        </li>
      </ul>
    </div>
  </xsl:template>

  <xsl:template name="footer">
    <div id="footer">
      <!-- footer START -->
      <div class= "textbereich-footer-b">
        Creative Commons <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/de/" target="_blank">by-nc-nd</a> 2009 by aber-glaube.net/Christian Romacker/Wolfgang Keller<br />
        <a href="#a7">
          <img src="http://www.aber-glaube.net/basics/logos/oben.gif" alt="nach oben" width="47" height="11" style="border: 0" />
        </a>
        <br />
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>