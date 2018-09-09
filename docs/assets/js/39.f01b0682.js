(window.webpackJsonp=window.webpackJsonp||[]).push([[39],{197:function(e,t,s){"use strict";s.r(t);var a=s(0),i=Object(a.a)({},function(){var e=this,t=e.$createElement,s=e._self._c||t;return s("div",{staticClass:"content"},[e._m(0),e._v(" "),s("p",[e._v("As a way to air my frustrations at inconsistencies and bad design decisions in the Linux OS, specifically server distributions, I put together a list of ways I thought that the OS and its many daemons could be standardised and simplified. Here are my thoughts, from back in the early 2000s:")]),e._v(" "),e._m(1),e._v(" "),e._m(2),e._v(" "),e._m(3),e._v(" "),e._m(4),e._v(" "),s("p",[e._v("e.g. For tar, default should be file as an input, so tar -f should be redundant.")]),e._v(" "),e._m(5),e._v(" "),s("p",[e._v("e.g.")]),e._v(" "),e._m(6),e._v(" "),s("p",[e._v("Currently, verbose and very verbose can be:")]),e._v(" "),e._m(7),e._v(" "),e._m(8),e._v(" "),e._m(9),e._v(" "),s("p",[e._v("Program config files in /etc/program/xxx.conf.")]),e._v(" "),e._m(10),e._v(" "),s("p",[e._v("program.conf, programd.conf, program-function.conf, etc")]),e._v(" "),e._m(11),e._v(" "),e._m(12),e._v(" "),s("p",[e._v("A la "),s("a",{attrs:{href:"http://www.gobolinux.org/?page=at_a_glance",target:"_blank",rel:"noopener noreferrer"}},[e._v("http://www.gobolinux.org/?page=at_a_glance"),s("OutboundLink")],1)]),e._v(" "),e._m(13),e._v(" "),s("p",[e._v("Packages as a single file (zip or similar), can be dragged and dropped to a folder and run from there.")]),e._v(" "),e._m(14),e._v(" "),s("p",[e._v("Log files follow a consistent XML DTD, with fields for date, time, event code, description, etc.")])])},[function(){var e=this.$createElement,t=this._self._c||e;return t("h1",{attrs:{id:"my-thoughts-on-the-perfect-os"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#my-thoughts-on-the-perfect-os","aria-hidden":"true"}},[this._v("#")]),this._v(" My thoughts on the perfect OS")])},function(){var e=this.$createElement,t=this._self._c||e;return t("h2",{attrs:{id:"config-files-as-xml"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#config-files-as-xml","aria-hidden":"true"}},[this._v("#")]),this._v(" Config files as XML")])},function(){var e=this.$createElement,t=this._self._c||e;return t("ul",[t("li",[this._v("DTDs allow proper sanity checks")]),this._v(" "),t("li",[this._v("DTD and XSL allow easy editing through text and graphical interfaces - config programs are updated dynamically!")])])},function(){var e=this.$createElement,t=this._self._c||e;return t("p",[t("em",[this._v("Offenders: Sendmail, Procmail")])])},function(){var e=this.$createElement,t=this._self._c||e;return t("h2",{attrs:{id:"sensible-command-line-defaults"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#sensible-command-line-defaults","aria-hidden":"true"}},[this._v("#")]),this._v(" Sensible command line defaults")])},function(){var e=this.$createElement,t=this._self._c||e;return t("h2",{attrs:{id:"standardised-command-line-options"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#standardised-command-line-options","aria-hidden":"true"}},[this._v("#")]),this._v(" Standardised command-line options")])},function(){var e=this,t=e.$createElement,s=e._self._c||t;return s("ul",[s("li",[e._v("--help for help")]),e._v(" "),s("li",[e._v("-i for input file")]),e._v(" "),s("li",[e._v("-o for output file")]),e._v(" "),s("li",[e._v("-v for verbose (with -vv, -vvv)")]),e._v(" "),s("li",[e._v("etc.")])])},function(){var e=this.$createElement,t=this._self._c||e;return t("ul",[t("li",[this._v("-v, -vv, -vvv (tcpdump)")]),this._v(" "),t("li",[this._v("-v, -v -v, -v -v -v (lilo)")]),this._v(" "),t("li",[this._v("-e, -e -e || -ee (netstat)")])])},function(){var e=this.$createElement,t=this._self._c||e;return t("p",[t("em",[this._v("Offenders: lilo, netstat")])])},function(){var e=this.$createElement,t=this._self._c||e;return t("h2",{attrs:{id:"consistent-file-locations"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#consistent-file-locations","aria-hidden":"true"}},[this._v("#")]),this._v(" Consistent file locations")])},function(){var e=this.$createElement,t=this._self._c||e;return t("h2",{attrs:{id:"consistent-file-names"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#consistent-file-names","aria-hidden":"true"}},[this._v("#")]),this._v(" Consistent file names")])},function(){var e=this.$createElement,t=this._self._c||e;return t("p",[t("em",[this._v("Offenders: sshd_config")])])},function(){var e=this.$createElement,t=this._self._c||e;return t("h2",{attrs:{id:"sensible-filesystem-layout"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#sensible-filesystem-layout","aria-hidden":"true"}},[this._v("#")]),this._v(" Sensible filesystem layout")])},function(){var e=this.$createElement,t=this._self._c||e;return t("h2",{attrs:{id:"easy-deploy-packages"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#easy-deploy-packages","aria-hidden":"true"}},[this._v("#")]),this._v(" Easy deploy packages")])},function(){var e=this.$createElement,t=this._self._c||e;return t("h2",{attrs:{id:"standardised-logs"}},[t("a",{staticClass:"header-anchor",attrs:{href:"#standardised-logs","aria-hidden":"true"}},[this._v("#")]),this._v(" Standardised Logs")])}],!1,null,null,null);i.options.__file="perfectos.md";t.default=i.exports}}]);