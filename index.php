<?php

$document   = DOMDocument::load('blog.xml');
$stylesheet = DOMDocument::load('blog.xslt');
 
$processor = new XSLTProcessor;
$processor->importStylesheet($stylesheet);
 
print $processor->transformToDoc($document)->saveXML();

?>