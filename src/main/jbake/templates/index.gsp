<%include "header.gsp"%>

	<%include "menu.gsp"%>

	<%published_posts.each {post ->%>
		<a href="${post.uri}"><h1>${post.title}</h1></a>
		<p>${post.date.format("dd MMMM yyyy")}</p>
		<p>${post.body}</p>
  	<%}%>
	
	<hr />
	
<%include "footer.gsp"%>