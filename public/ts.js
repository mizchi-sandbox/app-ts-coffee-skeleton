var A;
(function (A) {
    var B = (function () {
        function B() {
        }
        return B;
    })();
    A.B = B;
})(A || (A = {}));

jQuery(function () {
    console.log("onload typescirpt");
});
//# sourceMappingURL=ts.js.map
