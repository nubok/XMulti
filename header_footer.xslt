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
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:hf="urn:schemas-xmulti:header-footer">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="node()" mode="header-footer">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@* | node()" mode="header-footer"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@* | comment() | text()" mode="header-footer">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="header-footer"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="header">
    <xsl:for-each select="document('header_footer.xml')/hf:header-footer/hf:header">
      <xsl:apply-templates mode="header-footer"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="footer">
    <xsl:for-each select="document('header_footer.xml')/hf:header-footer/hf:footer">
      <xsl:apply-templates mode="header-footer"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>