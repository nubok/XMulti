<?php

/*error_reporting(E_ALL);
ini_set("display_errors", 1);*/

//print_r(get_loaded_extensions());

$document   = DOMDocument::load('blog.xml');
$stylesheet = DOMDocument::load('blog.xslt');
 
$processor = new XSLTProcessor;
$processor->importStylesheet($stylesheet);
 
print $processor->transformToDoc($document)->saveXML();

?>