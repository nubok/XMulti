<?php

$document   = DOMDocument::load('blog.xml');
$stylesheet = DOMDocument::load('blog_articles.xslt');

$parameters = array('type', 'value', 'lang');

$processor = new XSLTProcessor;
$processor->importStylesheet($stylesheet);

foreach ($parameters as $parameter)
{
	$processor->setParameter('', $parameter, $_GET[$parameter]);
}

print $processor->transformToDoc($document)->saveXML();

?>