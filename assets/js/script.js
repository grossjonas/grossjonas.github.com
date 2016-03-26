var globals = {};
globals.height = -1;

document.addEventListener("DOMContentLoaded", function() {
  var navbar = document.getElementsByClassName("navbar")[0];
  var clone = navbar.cloneNode(true);

  navbar.classList.add("original");

  // .append() with vanilla js
  navbar.parentElement.insertBefore(clone, navbar.nextSibling);

  clone.classList.add("clone");

  //clone.style.display = "none";
  clone.style.position = "fixed";
  clone.style.width = "100%";
  clone.style.top = "0px";
  clone.style.left = "0px";
  clone.style.boxShadow = "0px 1px 2px black"

  var bodyStyle = window.getComputedStyle(document.querySelector("body"));
  clone.style.backgroundColor = bodyStyle.backgroundColor;


  var nav = clone.querySelector("nav");
  var pageStyle = window.getComputedStyle(document.querySelector("#page"));
  nav.style.width = pageStyle.width;
  nav.style.margin = "0 auto";

  var headerStyle = window.getComputedStyle(document.querySelector("#header"));
  var headerMarginBottom = parseInt(headerStyle.marginBottom);
  var headerHeight = parseInt(headerStyle.height);
  var navbarHeight = parseInt(window.getComputedStyle(document.querySelector(".original")).height);
  var contentMarginTop = parseInt(window.getComputedStyle(document.querySelector("#content")).marginTop);

  globals.height = headerHeight + headerMarginBottom + navbarHeight + contentMarginTop;

  //TODO: only for wide screens right now
  //setInterval(stickIt, 10);
});

function stickIt(){
  var clone = document.querySelector(".clone");
  var scrollTop = window.scrollY;

  if(scrollTop >= globals.height){
    clone.style.display = "block";
  } else {
    clone.style.display = "none";
  }
}
