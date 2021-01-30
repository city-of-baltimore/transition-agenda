# Load Baltimore City header and footer for app

  #---------------------------------------

  # Load packages (only matters for publishing on shiny.io)

  library(shinyjs)
  
  #---------------------------------------
  
  # Header

  headerBaltimoreCity <- HTML('
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;0,800;1,300;1,400;1,600;1,700;1,800&display=swap" rel="stylesheet">
  
    <style type="text/css">
    .top-nav-bar {
      background: #42484f;
      width: 100%;
      text-align: center;
      margin: 0px;
      padding: 0px;
    }
  
    ul.menu {
      max-width:800px;
      margin:auto;
      # height: 57px;
      max-height: 180px;
      line-height: 57px;
      padding: 0;
      display: flex;
      flex-direction: row;
      flex-wrap: wrap;
      justify-content: flex-start;
      padding-left: 24px;
      padding-right: 24px;
    }
    
    ul.menu li {
      margin: 0;
      padding: 0;
      display: inline-block;
    }
    
    ul.menu li a {
      color: #fff;
      font-family: \'Open Sans\',sans-serif;
      font-size: 14px;
      font-weight: normal;
      padding: 0px 8px;
      border-top: 3px solid transparent;
      background: transparent;
      height: 57px;
      line-height: 57px;
      text-transform: none;
      display: inline-block;
      text-decoration: none;
      z-index:100;
    }
    
    ul.menu li.active a {
      border-top-color: rgb(222, 182, 75);
    }
    
    ul.menu li.home a{ 
      background: url(http://www.baltimorecity.gov/sites/all/themes/custom/flight_city/images/smugmug/logo.png)  0 0 no-repeat;
      text-indent: -1000em;
      width: 47px
    }
    
    .footer {
      background-color: rgb(36, 40, 44);
    }
    
    .footer-bottom {
      background-color: #1A1C20;
      font-size: 10px;
    }
    
    .footer-inner {
      padding-top: 20px;
      padding-bottom: 20px;
    }
    
    .footer .footer-inner p {
      font-family: \'Open Sans\',sans-serif !important;
      font-size: 1em;
    }
    
    .footer-inner h2 {
      font-family: \'Open Sans\',sans-serif !important;
      font-size: 1.6em;
      font-weight: 400;
    }
    
    .copyright p {
      color: #fff;
      font-family: \'Open Sans\',sans-serif;
      font-size: .8rem;
      font-weight: 400;
      line-height: 1.6;
      opacity: 0.5;  
    }
    
    .footer-inner .right {
      float: right;
    }
    
    .footer-inner .right p,
    .footer h2 {
      margin-bottom: 20px;
    }
    
    .footer h2,
    .footer a,
    .footer-bottom a{
      color: rgb(140, 235, 255) !important;
      font-family: \'Open Sans\',sans-serif;
    }
    
    .footer p {
      color: #fff;
      margin-bottom: 20px
      font-family: \'Open Sans\',sans-serif;
    }
    
    .footer strong {
      font-weight: bold;
      color: #fcac31;
    }
    </style>
    
    
    <div class="top-nav-bar">
      <ul class="menu">
        <li class="home"><a href="http://www.baltimorecity.gov">Home</a></li>
        <li><a href="https://cityservices.baltimorecity.gov/paysys/" title="Pay your water, license and other bills online or in person">Online Payments</a></li>
        <li><a href="http://www.baltimorecity.gov/answers" title="">How Do I?</a></li>
        <li><a href="http://www.baltimorecity.gov/311-services" title="">311 Services</a></li>
        <li><a href="http://www.baltimorecity.gov/government" title="">Government</a></li>
        <li><a href="http://www.baltimorecity.gov/events" title="">Events</a></li>
        <li class="active"><a href="http://mayor.baltimorecity.gov" title="">Office of the Mayor</a></li>
        <li><a href="http://www.baltimorecity.gov/connect" title="Connect with all city entities and programs on social media">Connect</a></li>
      </ul>
    </div>
    '
  )
  
  #---------------------------------------
  
  # Footer
  
  footerBaltimoreCity <- HTML('
    <div class="footer">
        <div class="footer-inner">
          <h2 class="block-title" style="max-width:800px;margin:auto;padding: 0px 24px;">City of Baltimore</h2>
          <p style="max-width:800px;margin:auto;padding: 0px 24px;"><em>City Hall - Room 250<br/>100 N. Holliday St, Baltimore, MD 21202<br/>City Operator: (410) 396-3100</em></p>
        </div>
      </div>
      <div class="footer-bottom">
        <div class="footer-inner copyright">
          <p style="max-width:800px;margin:auto;padding: 0px 24px;">Copyright ? 2014 City of Baltimore &amp; Brandon M. Scott, Mayor.<br>All Rights Reserved.</p>
        </div>
    </div>
  ')
  
  #---------------------------------------
