<%@page import="java.sql.*" errorPage="error.jsp"%>
<%!
	PreparedStatement ps;
	ResultSet rs;
%>
<%
	Connection c=(Connection)application.getAttribute("connection");
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>OASIS HOTEL</title>
	<!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    
	<link rel="stylesheet" href="assets/css/morris.css">
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js//raphael-min.js"></script>
	<script src="assets/js/morris.min.js"></script>

   
        <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
     <!-- Google Fonts-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
     <!-- TABLE STYLES-->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body>
    <div id="wrapper">
        
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="home.jsp"><%=session.getAttribute("user")%> </a>
            </div>

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="usersetting.jsp"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="settings.jsp"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="logout.jsp"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
        </nav>
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">

                    <li>
                        <a href="home.jsp"><i class="fa fa-dashboard"></i> Status</a>
                    </li>
                    <li>
                        <a  href="messages.jsp"><i class="fa fa-desktop"></i> News Letters</a>
                    </li>
					<li>
                        <a href="roombook.jsp"><i class="fa fa-bar-chart-o"></i>Room Booking</a>
                    </li>
                    <li>
                        <a  href="payment.jsp"><i class="fa fa-qrcode"></i> Payment</a>
                    </li>
					 <li>
                        <a class="active-menu" href="profit.jsp"><i class="fa fa-qrcode"></i> Profit</a>
                    </li>
                    
                    <li>
                        <a href="logout.jsp" ><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                    </li>
                    

                    
            </div>

        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >
            <div id="page-inner">
			 <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-header">
                           Profit Details<small> </small>
                        </h1>
                    </div>
                </div> 
                 <!-- /. ROW  -->
				 
				 
            <div class="row">
			
				<%
								
					String query = "SELECT * FROM payment";
					ps=c.prepareStatement(query);
					rs=ps.executeQuery();
					String chart_data []= null;
					double tot =0;
					while(rs.next())
					{
						String cout=rs.getString("cout");
						int fintot=rs.getInt	("FNUMBEROT");
					 String chart_data1[] = { "date:"+cout, "profit:"+(fintot*10/100)};
					chart_data=chart_data1;
					 tot = tot + (fintot*10/100);
					}
					//chart_data = chart_data.substring(0, -2);
				
%>
				 
				<br>
				<br>
				<br>
				<br><div id="chart"></div>
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
											<th>ID</th>
                                            <th>Name</th>
                                            <th>Check in</th>
											<th>Check out</th>
                                            <th>Room Rent</th>
											<th>Bed Rent</th>
											<th>Meals </th>
											<th>Gr.Total</th>
											<th>Profit</th>
											
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
				<%
							
				String q="select * from payment";
				ps=c.prepareStatement(query);
				rs=ps.executeQuery();
				while(rs.next())
				{
							
					int id = rs.getInt("id");
											
					if(id % 2 ==1 )
					{%>
						<tr class='gradeC'>
						<td><%=id%> </td>
						<td><%=rs.getString("title")%> <%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
						<td><%=rs.getString("cin")%></td>
						<td><%=rs.getString("cout")%></td>
													
													
						<td><%=rs.getInt("ttot")%></td>
						<td><%=rs.getInt("mepr")%></td>
						<td><%=rs.getInt("btot")%></td>
						<td><%=rs.getInt("FNUMBEROT")%></td>
						<td><%=rs.getInt("FNUMBEROT")*10/100%></td>
						</tr>
					<%}
					else
					{%>
						<tr class='gradeU'>
						<td><%=id%></td>
						<td><%=rs.getString("title")%> <%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
													
						<td><%=rs.getString("cin")%></td>
						<td><%=rs.getString("cout")%></td>
													
													
						<td><%=rs.getInt("ttot")%></td>
						<td><%=rs.getInt("mepr")%></td>
						<td><%=rs.getInt("btot")%></td>
						<td><%=rs.getInt("FNUMBEROT")%></td>
						<td><%=rs.getInt("FNUMBEROT")*10/100%></td>
						</tr>
									
					<%}
							
				}
										
			%>
                                      
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    <!--End Advanced Tables -->
                </div>
            </div>
                <!-- /. ROW  -->
            
                </div>
               
            </div>
        
               
    </div>
             <!-- /. PAGE INNER  -->
            </div>
         <!-- /. PAGE WRAPPER  -->
     <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>
      <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
     <!-- DATA TABLE SCRIPTS -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>
         <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
    
   
</body>
</html>
<script>
Morris.Bar({
 element : 'chart',
 data:[<%=chart_data[0]+" "+chart_data[1]%>],
 xkey:'date',
 ykeys:['profit'],
 labels:['Profit'],
 hideHover:'auto',
 stacked:true
});
</script>
