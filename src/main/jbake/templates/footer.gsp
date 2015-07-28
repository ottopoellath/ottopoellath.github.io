		</div>
		<div id="push"></div>
    </div>


    
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/jquery-1.11.1.min.js"></script>
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/bootstrap.min.js"></script>
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/prettify.js"></script>

    <script type="text/javascript">
      \$(function() {
        hljs.tabReplace = '  '; //4 spaces
        hljs.initHighlighting();
      });
    </script>
  </body>
</html>