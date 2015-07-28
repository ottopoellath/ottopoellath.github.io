		</div>
		<div id="push"></div>
    </div>


    <div id="footer">
      <div class="container">
        <p class="muted credit">
          All posts on this blog are published with a <em>Creative Commons by-nc-sa</em> license.
          <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/2.0/">
            <img alt="Creative Commons License" style="border-width:0" src="https://licensebuttons.net/l/by-nc-sa/2.0/88x31.png">
          </a>
        </p>
      </div>
    </div>
    <p></p>
    
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