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