<%@ page import="com.HelloApp.PlaceDetail" %>
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
    <title>Search place you travelled.</title>
    <%
        String action = request.getParameter("actionId");
        if (action != null && "Save".equals(action)) {
            PlaceDetail placeDetail = new PlaceDetail();
            placeDetail.setName(request.getParameter("name"));
            placeDetail.setAddress(request.getParameter("address"));
            placeDetail.setLatitude(Double.valueOf(request.getParameter("latitude")));
            placeDetail.setLongitude(Double.valueOf(request.getParameter("longitude")));
            placeDetail.setIconURL(request.getParameter("iconURL"));
            placeDetail.setGoogleURL(request.getParameter("googleURL"));
            session.setAttribute("PlaceDetailRequest", placeDetail);
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
            <h1>Save Place</h1>

            <form action="index.jsp">

                <table class="table table-bordered">
                    <tr>
                        <td>Your Name</td>
                        <td><input type="text" name="userName"/></td>
                    </tr>
                    <tr>
                        <td>Date(Format:dd-MM-yyyy)</td>
                        <td><input type="date" name="visitedDate"/></td>
                    </tr>
                    <tr>
                        <td>Comments</td>
                        <td>
                            <textarea rows="4" cols="50" name="comment">Add your travel experience here...</textarea>

                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" value="Store" name="actionId" id="actionId"/>
                            <input type="submit" value="Store "/>
                        </td>
                    </tr>
                </table>
            </form>


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

