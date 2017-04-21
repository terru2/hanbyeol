<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>  
<%@ page session="false" %>
<html>
<head>
	<title><tiles:insertAttribute name="title" /> </title>
</head>
<body>
<h1>
	Main!
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
