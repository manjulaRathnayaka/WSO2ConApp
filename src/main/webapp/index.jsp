<%@ page import="com.HelloApp.PlaceDetail" %>
<%@ page import="com.HelloApp.PlaceDetailDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    <title>My Travel Records</title>


    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <%
        PlaceDetailDAO placeDetailDAO = new PlaceDetailDAO();
        PlaceDetail[] myRecords = placeDetailDAO.getPlaceDetails();
        String action = request.getParameter("actionId");
        if (action != null && "Store".equals(action)) {
            PlaceDetail placeDetail = (PlaceDetail) session.getAttribute("PlaceDetailRequest");
            placeDetail.setUserName(request.getParameter("userName"));
            SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
            java.util.Date parsed = format.parse(request.getParameter("visitedDate"));
            placeDetail.setVisitedDate(new java.sql.Date(parsed.getTime()));
            placeDetail.setComment(request.getParameter("comment"));
            placeDetailDAO.insertPlaceDetail(placeDetail);
            response.sendRedirect("index.jsp");
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
            <%
                if (myRecords != null && myRecords.length > 0) {
            %>
            <h1><img src="images/travel.png" alt="Icon" style="width:100px;height:100px;">My Travel Records</h1>

            <div class="pull-right"><img src="images/extended_google_map_icon.png" alt="Add A Place"
                                         style="width:100px;height:100px;" onclick="location.href='search.jsp'"></div>
            <table class="table table-bordered">
                <tr>
                    <th>Name</th>
                    <th>Place</th>
                    <th>Date</th>
                    <th>Address</th>
                    <th>Comment</th>
                    <th>Category</th>
                    <th>Google Page</th>
                </tr>
                <%
                    for (PlaceDetail detail : myRecords) {
                %>
                <tr>
                    <td><%=detail.getUserName()%>
                    </td>
                    <td><%=detail.getName()%>
                    </td>
                    <td><%=detail.getVisitedDate()%>
                    </td>
                    <td><%=detail.getAddress()%>
                    </td>

                    <td><%=detail.getComment()%>
                    </td>
                    <td><img width="50px" height="50px" src="<%=detail.getIconURL()%>" alt="<%=detail.getName()%>"/>

                    </td>
                    <td>
                        <a target="_blank" href="<%=detail.getGoogleURL()%>"><%=detail.getName()%>
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>

            <%
                }else{
                    %>
                <a href="search.jsp">Search Places You Travelled.</a>
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


