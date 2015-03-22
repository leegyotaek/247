$(document).on "page:change", ->
  for polymerElement in Polymer.elements
    for domElement in document.body.querySelectorAll("paper-char-counter")
      domElement.parentNode.replaceChild(document.importNode(domElement, true), domElement);