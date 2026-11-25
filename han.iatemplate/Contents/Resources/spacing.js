(() => {
    "use strict";

    const CJK = "[\\u3400-\\u4DBF\\u4E00-\\u9FFF\\uF900-\\uFAFF]";
    const LATIN = "[A-Za-z0-9]";
    const SKIP = new Set(["SCRIPT", "STYLE", "CODE", "PRE", "KBD", "SAMP", "TT"]);

    const cjkToLatin = new RegExp(`(${CJK})(${LATIN})`, "g");
    const latinToCjk = new RegExp(`(${LATIN})(${CJK})`, "g");

    function insertSpaces(value) {
        return value
            .replace(cjkToLatin, "$1 $2")
            .replace(latinToCjk, "$1 $2");
    }

    function shouldSkip(node) {
        let parent = node.parentNode;
        while (parent) {
            if (SKIP.has(parent.nodeName)) return true;
            parent = parent.parentNode;
        }
        return false;
    }

    function processTextNodes(root) {
        if (!root) return;

        const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, {
            acceptNode(node) {
                return shouldSkip(node)
                    ? NodeFilter.FILTER_REJECT
                    : NodeFilter.FILTER_ACCEPT;
            },
        });

        let node;
        while ((node = walker.nextNode())) {
            const original = node.nodeValue;
            if (!original) continue;
            const updated = insertSpaces(original);
            if (updated !== original) node.nodeValue = updated;
        }
    }

    function processDocument() {
        processTextNodes(document.body);
    }

    document.addEventListener("ia-writer-change", processDocument, true);
    document.addEventListener("DOMContentLoaded", processDocument);
    window.addEventListener("load", processDocument);
})();
