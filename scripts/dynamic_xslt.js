var platformMoz = (document.implementation && document.implementation.createDocument);
var platformIE = (!platformMoz && document.getElementById && window.ActiveXObject);
var noXSLT = (!platformMoz && !platformIE);

var target;

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

function initXSLT() {
    if (noXSLT) {
        alert("No XSLT processor found. Please use IE8 or Mozilla Firefox");
    }
    else {
        target = document.getElementById("articleContainerDiv");
    }
}

function createContent(paramType, paramValue) {
    alert("'" + paramType + "': '" + paramValue + "'");
}
