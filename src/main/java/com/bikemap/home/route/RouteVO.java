package com.bikemap.home.route;

public class RouteVO {
	
	private int noroute;
	private String title;
	private String routepoint1;
		private String routepoint1name;
		private String routepoint1point;
	private String routepoint2;
		private String routepoint2name;
		private String routepoint2point;
	private String routepoint3;
		private String routepoint3name;
		private String routepoint3point;
	private String routepoint4;
		private String routepoint4name;
		private String routepoint4point;
	private String routepoint5;
		private String routepoint5name;
		private String routepoint5point;
	private String routepoint6;
		private String routepoint6name;
		private String routepoint6point;
	private String routepoint7;
		private String routepoint7name;
		private String routepoint7point;
	private String geocode;
	private String userid;
	private double distance;
	private double ascent;
	private double descent;
	private String region;
	private String closed;
	private String writedate;
	
	public int getNoroute() {
		return noroute;
	}
	public void setNoroute(int noroute) {
		this.noroute = noroute;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRoutepoint1() {
		return routepoint1;
	}
	public void setRoutepoint1(String routepoint1) {
		this.routepoint1 = routepoint1;
	}
	public String getRoutepoint2() {
		return routepoint2;
	}
	public void setRoutepoint2(String routepoint2) {
		this.routepoint2 = routepoint2;
	}
	public String getRoutepoint3() {
		return routepoint3;
	}
	public void setRoutepoint3(String routepoint3) {
		this.routepoint3 = routepoint3;
	}
	public String getRoutepoint4() {
		return routepoint4;
	}
	public void setRoutepoint4(String routepoint4) {
		this.routepoint4 = routepoint4;
	}
	public String getRoutepoint5() {
		return routepoint5;
	}
	public void setRoutepoint5(String routepoint5) {
		this.routepoint5 = routepoint5;
	}
	public String getRoutepoint6() {
		return routepoint6;
	}
	public void setRoutepoint6(String routepoint6) {
		this.routepoint6 = routepoint6;
	}
	public String getRoutepoint7() {
		return routepoint7;
	}
	public void setRoutepoint7(String routepoint7) {
		this.routepoint7 = routepoint7;
	}
	public String getGeocode() {
		return geocode;
	}
	public void setGeocode(String geocode) {
		this.geocode = geocode;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public double getAscent() {
		return ascent;
	}
	public void setAscent(double ascent) {
		this.ascent = ascent;
	}
	public double getDescent() {
		return descent;
	}
	public void setDescent(double descent) {
		this.descent = descent;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getClosed() {
		return closed;
	}
	public void setClosed(String closed) {
		this.closed = closed;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	
	////////////// 삽질의 시작 /////////////////////
	public String getRoutepoint1name() {
		return routepoint1.substring(0,routepoint1.indexOf("[/]"));
	}
	
	public void setRoutepoint1name(String routepoint1name) {
		this.routepoint1name = routepoint1name;
	}
	public String getRoutepoint1point() {
		return routepoint1.substring(routepoint1.indexOf("[/]")+3);
	}
	public void setRoutepoint1point(String routepoint1point) {
		this.routepoint1point = routepoint1point;
	}
	public String getRoutepoint2name() {
		return routepoint2.substring(0,routepoint2.indexOf("[/]"));
	}
	public void setRoutepoint2name(String routepoint2name) {
		this.routepoint2name = routepoint2name;
	}
	public String getRoutepoint2point() {
		return routepoint2.substring(routepoint2.indexOf("[/]")+3);
	}
	public void setRoutepoint2point(String routepoint2point) {
		this.routepoint2point = routepoint2point;
	}
	public String getRoutepoint3name() {
		return routepoint3.substring(0,routepoint3.indexOf("[/]"));
	}
	public void setRoutepoint3name(String routepoint3name) {
		this.routepoint3name = routepoint3name;
	}
	public String getRoutepoint3point() {
		return routepoint3.substring(routepoint3.indexOf("[/]")+3);
	}
	public void setRoutepoint3point(String routepoint3point) {
		this.routepoint3point = routepoint3point;
	}
	public String getRoutepoint4name() {
		return routepoint4.substring(0,routepoint4.indexOf("[/]"));
	}
	public void setRoutepoint4name(String routepoint4name) {
		this.routepoint4name = routepoint4name;
	}
	public String getRoutepoint4point() {
		return routepoint4.substring(routepoint4.indexOf("[/]")+3);
	}
	public void setRoutepoint4point(String routepoint4point) {
		this.routepoint4point = routepoint4point;
	}
	public String getRoutepoint5name() {
		return routepoint5.substring(0,routepoint5.indexOf("[/]"));
	}
	public void setRoutepoint5name(String routepoint5name) {
		this.routepoint5name = routepoint5name;
	}
	public String getRoutepoint5point() {
		return routepoint5.substring(routepoint5.indexOf("[/]")+3);
	}
	public void setRoutepoint5point(String routepoint5point) {
		this.routepoint5point = routepoint5point;
	}
	public String getRoutepoint6name() {
		return routepoint6.substring(0,routepoint6.indexOf("[/]"));
	}
	public void setRoutepoint6name(String routepoint6name) {
		this.routepoint6name = routepoint6name;
	}
	public String getRoutepoint6point() {
		return routepoint6.substring(routepoint6.indexOf("[/]")+3);
	}
	public void setRoutepoint6point(String routepoint6point) {
		this.routepoint6point = routepoint6point;
	}
	public String getRoutepoint7name() {
		return routepoint7.substring(0,routepoint7.indexOf("[/]"));
	}
	public void setRoutepoint7name(String routepoint7name) {
		this.routepoint7name = routepoint7name;
	}
	public String getRoutepoint7point() {
		return routepoint7.substring(routepoint7.indexOf("[/]")+3);
	}
	public void setRoutepoint7point(String routepoint7point) {
		this.routepoint7point = routepoint7point;
	}
}