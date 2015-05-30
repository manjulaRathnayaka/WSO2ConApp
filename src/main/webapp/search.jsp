<%@page import="java.util.List" %>
<%@page import="se.walkercrou.places.Place" %>
<%@ page import="com.HelloApp.PlaceAPIDataRetriever" %>
<%@ page import="se.walkercrou.places.Photo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <title>Search place you travelled.</title>
    <%
        List<Place> places = null;
        String action = request.getParameter("actionId");
        if (action != null && "Search".equals(action)) {
            String placeParam = request.getParameter("placeId");
            PlaceAPIDataRetriever placeAPIDataRetriever = new PlaceAPIDataRetriever();
            places = placeAPIDataRetriever.searchPlace(placeParam);
        }
    %>

</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">

            <a class="navbar-brand" href="index.jsp">My Travel Records</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse"></div>
        <!--/.navbar-collapse -->
    </div>
</nav>


<div class="container">
    <!-- Example row of columns -->
    <div class="row">
        <div class="col-md-12">

            <%--My content starts here--%>
            <h1>Search Place</h1>

            <form action="search.jsp">
                <input type="text" name="placeId" id="placeId"/>
                <input type="hidden" value="Search" name="actionId" id="actionId"/>
                <input type="submit" value="Search"/>
            </form>

            <% if (places != null && places.size() > 0) {
            %>
            <form action="save.jsp">
                <table class="table table-bordered">
                    <tr>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Icon</th>
                        <th>Photo</th>
                        <th>Actions</th>
                    </tr>
                    <%
                        for (Place p : places) {
                            Place detailedPlace = p.getDetails();
                            List<Photo> photos = detailedPlace.getPhotos();
                    %>
                    <tr>
                        <td><%=p.getName()%>
                        </td>
                        <td><%=p.getAddress()%>
                        </td>

                        <td>
                            <img src="<%= detailedPlace.getIconUrl()%>" alt="<%=p.getAddress()%>"/>
                        </td>
                        <td>
                            <%
                                if (photos.size() > 0) {

                                    String link =
                                            "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" +
                                            photos.get(0).getReference() + "&key=" + p.getClient().getApiKey();
                            %>
                            <img width="200px" height="200px" src="<%=link%>" alt="<%=p.getAddress()%>"
                                    <%
                                    } else {
                                    %>
                                 N/A
                            <%
                                }
                            %>

                        </td>
                        <td>
                            <input type="submit" value="Store This Place"/>
                            <input type="hidden" value="Save" name="actionId"/>
                            <input type="hidden" value="<%=detailedPlace.getName()%>" name="name"/>
                            <input type="hidden" value="<%=detailedPlace.getAddress()%>" name="address"/>
                            <input type="hidden" value="<%=detailedPlace.getLongitude()%>" name="longitude"/>
                            <input type="hidden" value="<%=detailedPlace.getLatitude()%>" name="latitude"/>
                            <input type="hidden" value="<%=detailedPlace.getIconUrl()%>" name="iconURL"/>
                            <input type="hidden" value="<%=detailedPlace.getGoogleUrl()%>" name="googleURL"/>
                        </td>
                    </tr>
                    <%

                        }
                    %>
                </table>
            </form>
            <%
                }

            %>
            <%--My content ends here--%>

        </div>
    </div>

    <hr>

    <footer>
        <p>&copy; WSO2Con 2015</p>
    </footer>
</div>
<!-- /container -->

</body>
</html>

