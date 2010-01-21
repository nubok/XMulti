/*
Copyright (c) 2009-2010, Wolfgang Keller
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    3. The name of the author may not be used to endorse or promote products derived from this software without specific prior written permission. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var platformMoz = (document.implementation && document.implementation.createDocument);
var platformIE = (!platformMoz && document.getElementById && window.ActiveXObject);
var noXSLT = (!platformMoz && !platformIE);

var xmlUrl = null;
var xsltUrl = null;

var targetDiv = null;

var docXml = null;
var docXslt = null;

function getMsxmlDOM() {
    if (Web.Application.get_type() == Web.ApplicationType.InternetExplorer) {
        var progIDs = ['Msxml2.DOMDocument.6.0', 'Msxml2.DOMDocument.3.0'];

        for (var i = 0; i < progIDs.length; i++) {
            try {
                var xmlDOM = new ActiveXObject(progIDs[i]);
                return xmlDOM;
            }
            catch (ex) {
            }
        }

        return null;
    }
}

function initXSLT(paramXmlUrl, paramXsltUrl) {
    xmlUrl = paramXmlUrl;
    xsltUrl = paramXsltUrl;

    if (noXSLT) {
        alert("No XSLT processor found. Please use IE8 or Mozilla Firefox");
    }
    else {
        target = document.getElementById("articleContainerDiv");
    }
}

function createContent(paramType, paramValue) {
    docXml = null;
    docXslt = null;

    if (document.implementation) {
        docXml = document.implementation.createDocument('', '', null);
        docXslt = document.implementation.createDocument('', '', null);

        if (docXml.load) {
            docXml.addEventListener('load', function() {
                docXslt.addEventListener('load', function() {
                    transform(paramType, paramValue);
                }, false);
                docXslt.load(xsltUrl);
            }, false);
            docXml.load(xmlUrl);
        }
        else {
            var xmlHttpXml = new window.XMLHttpRequest();
            xmlHttpXml.onreadystatechange = function() {
                if (this.readyState == 4) {
                    if (this.status == 200) {
                        docXml = this.responseXML.documentElement;
                        if (docXml && docXslt)
                            transform(paramType, paramValue);
                    } else {
                        alert('There was a problem retrieving file ' +
                    xmlUrl + '\n' + this.statusText);
                    }
                }
            };
            xmlHttpXml.open('GET', xmlUrl, true);
            xmlHttpXml.send(null);

            var xmlHttpXslt = new window.XMLHttpRequest();
            xmlHttpXslt.onreadystatechange = function() {
                if (this.readyState == 4) {
                    if (this.status == 200) {
                        docXslt = this.responseXML.documentElement;
                        if (docXml && docXslt)
                            transform(paramType, paramValue);
                    } else {
                        alert('There was a problem retrieving file ' +
                    xsltUrl + '\n' + this.statusText);
                    }
                }
            };
            xmlHttpXslt.open('GET', xsltUrl, true);
            xmlHttpXslt.send(null);
        }
    }
}

function transform(paramType, paramValue) {
    if (platformMoz) {
        var processor = new XSLTProcessor();
        processor.importStylesheet(docXslt);

        processor.setParameter(null, 'type', paramType);
        processor.setParameter(null, 'value', paramValue);

        var fragment = processor.transformToFragment(docXml, document);

        while (target.hasChildNodes())
            target.removeChild(target.childNodes[0]);

        target.appendChild(fragment);
    }
}