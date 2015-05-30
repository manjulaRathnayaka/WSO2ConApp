package com.HelloApp;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//CREATE TABLE IF NOT EXISTS PlaceDetails ( Name VARCHAR (100), UserName VARCHAR (20), Address VARCHAR(100), Latitude DOUBLE, Longitude DOUBLE, GoogleURL VARCHAR(100), IconURL VARCHAR(100), VisitedDate DATE, Comment Text, CONSTRAINT PLACE_PKEY PRIMARY KEY (Name, UserName,VisitedDate) );


public class PlaceDetailDAO {
    private static Log log = LogFactory.getLog(PlaceDetailDAO.class);
    public PlaceDetail[] getPlaceDetails() {
        List<PlaceDetail> list = new ArrayList<PlaceDetail>();
        try {
            DataSource dataSource = getDataSource();
            Connection connection = dataSource.getConnection();

            PreparedStatement prepStmt = connection.prepareStatement("select * from PlaceDetails");
            ResultSet results = prepStmt.executeQuery();
            while (results.next()) {
                String name = results.getString("Name");
                String userName = results.getString("UserName");
                String address = results.getString("Address");
                Double latitude = results.getDouble("Latitude");
                Double longitude = results.getDouble("Longitude");
                String googleURL = results.getString("GoogleURL");
                String iconURL = results.getString("IconURL");
                Date visitedDate = results.getDate("VisitedDate");
                String comment = results.getString("Comment");
                PlaceDetail placeDetail = new PlaceDetail();
                placeDetail.setName(name);
                placeDetail.setUserName(userName);
                placeDetail.setAddress(address);
                placeDetail.setLatitude(latitude);
                placeDetail.setLongitude(longitude);
                placeDetail.setGoogleURL(googleURL);
                placeDetail.setIconURL(iconURL);
                placeDetail.setVisitedDate(visitedDate);
                placeDetail.setComment(comment);
                list.add(placeDetail);
            }
            results.close();
            prepStmt.close();
            connection.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            log.error("============ERROR===========",e);

        }
        return list.toArray(new PlaceDetail[list.size()]);
    }

    public void insertPlaceDetail(PlaceDetail placeDetail) {
        try {
            DataSource dataSource = getDataSource();
            Connection connection = dataSource.getConnection();

            PreparedStatement prepStmt = connection.prepareStatement(
                    "insert into PlaceDetails(Name, UserName, Address, Latitude, Longitude, GoogleURL, IconURL, VisitedDate, Comment) values(?, ?, ?,?, ?, ?,?, ?, ?)");
            prepStmt.setString(1, placeDetail.getName());
            prepStmt.setString(2, placeDetail.getUserName());
            prepStmt.setString(3, placeDetail.getAddress());
            prepStmt.setDouble(4, placeDetail.getLatitude());
            prepStmt.setDouble(5, placeDetail.getLongitude());
            prepStmt.setString(6, placeDetail.getGoogleURL());
            prepStmt.setString(7, placeDetail.getIconURL());
            prepStmt.setDate(8, placeDetail.getVisitedDate());
            prepStmt.setString(9, placeDetail.getComment());
            prepStmt.executeUpdate();
            prepStmt.close();
            connection.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            log.error("============ERROR===========",e);
        }
    }


    private DataSource getDataSource() {
        DataSource dataSource = null;
        Hashtable<String, String> env = new Hashtable<String, String>();
        try {
            InitialContext context = new InitialContext();
            if (env.size() > 0) {
                context = new InitialContext(env);
            }
            dataSource = (DataSource) context.lookup("jdbc/PlacesDS");
        } catch (NamingException e) {
            e.printStackTrace();
            log.error("============ERROR===========",e);
        }
        return dataSource;
    }
}
