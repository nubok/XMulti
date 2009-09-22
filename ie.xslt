<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                exclude-result-prefixes="exslt msxsl">
  <msxsl:script implements-prefix="exslt" language="javascript">
    this['node-set'] =  function (x) {
    return x;
    }
  </msxsl:script>
</xsl:stylesheet>