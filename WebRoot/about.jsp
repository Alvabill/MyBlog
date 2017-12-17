<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE HTML>
<html>
<head>
    <meta content="text/html;charset=utf-8">
    <title>小组介绍</title>
    <link rel="stylesheet" href="asset/css/font-awesome.min.css">
    <style>
        * {
        	margin:0 auto;
        	padding:0;
        	font:24px 黑体;
        }
        li{list-style-type:none}
        body {background:rgb(255, 255, 129);}
        .clear {clear:both}
        .main{
            position: relative;
            width: 600px;
            margin: 0 auto;
            height: 600px;
            top:50px;
        }
        .row1{
        	background:#F88;
            position:absolute;
        	height: 35%;
            width: 35%;
        	top:9%;
            left:9%;

            float: left;
            border-radius: 10%;
            box-shadow: 6px 6px 8px rgb(247,174,220);
        }
        .row1:hover{
            top: 8%;
            left: 8%;
        }
        .row1:hover~.row11{
            opacity: 0.5;
        }
        .row2{
        	background:#88F;
            position:absolute;
        	height: 40%;
            width: 40%;
        	top:8%;
            right:9%;
            float: right;
            border-radius: 10%;
            box-shadow: 6px 6px 8px rgb(171,224,250);
        }
        .row2:hover{
            top: 7%;
            right: 8%;
        }
        .row2:hover~.row22{
            opacity: 0.5;
        }
        .row3{
            background:#888;
            position:absolute;
            height: 40%;
            width: 40%;
            bottom: 8%;
            left:8%;

            float: left;
            border-radius: 10%;
            box-shadow: 6px 6px 8px rgb(185,199,200);
        }
        .row3:hover{
            bottom: 7%;
            left: 7%;
        }
        .row3:hover~.row33{
            opacity: 0.5;
        }
        .row4{
            background:rgb(233,189,70);
            height: 37%;
            width: 37%;
            bottom:9%;
            right:9%;
            position:absolute;
            float: left;
            border-radius: 10px;
            box-shadow: 6px 6px 8px rgb(225,193,83);
        }
        .row4:hover{
            bottom: 7%;
            right: 7%;
        }
        .row4:hover~.row44{
            opacity: 0.5;
        }

        .row11,.row22,.row33,.row44{
            opacity: 0;
        }
        .row11{
            position: absolute;
            width:40%;
            height: 30%;
            top: 10%;
            left: -35%;
        }
        .row22{
            position: absolute;
            width:40%;
            height: 30%;
            top: 11%;
            right: -35%;
        }
        .row33{
            position: absolute;
            width:40%;
            height: 30%;
            bottom: 10%;
            left: -35%;
        }
        .row44{
            position: absolute;
            width:40%;
            height: 30%;
            bottom: 11%;
            right: -35%;
        }
        .photo{
            position: absolute;
            margin:0 auto;
            width: 100%;
            overflow: hidden;
        }
        .photo img {
          border-radius: 10%;
          width: 90%;
        }
        .btn {
          position: fixed;
          bottom: 2rem;
          right: 3rem;
          cursor: pointer;

        }
    </style>
</head>
<body>
    <div class="btn">
      <a href="/myBlog"> <img src="asset/img/about_btn.jpg" alt="返回主页"></a>
    </div>
    <div id="main1_outer" class="main_outer">
        <div class="main">
            <div class="row1">
                <div class="photo">
                   <img src="asset/img/cm.jpg">
                </div>
            </div>
            <div class="row2">
                <div class="photo">
                   <img src="asset/img/ty.jpg">
                </div>
            </div>
            <div class="row3">
                <div class="photo">
                   <img src="asset/img/wy.jpg">
                </div>
            </div>
            <div class="row4">
               <div class="photo">
                   <img src="asset/img/wb.jpg">
                </div>
            </div>
            <div class="row11">
                <p><i class="fa fa-female"></i>&nbsp;王长敏</p>
                <p><i class="fa fa-birthday-cake"></i>&nbsp;1997-10-05</p>
                <p><i class="fa fa-address-card-o"></i>&nbsp;15352326</p>
                <p><i class="fa fa-envelope"></i>&nbsp;1015529847@qq.com </p>
            </div>
            <div class="row22">
                <p><i class="fa fa-female"></i>&nbsp;吴天祎</p>
                <p><i class="fa fa-birthday-cake"></i>&nbsp;1999-06-14</p>
                <p><i class="fa fa-address-card-o"></i>&nbsp;15352342</p>
                <p><i class="fa fa-envelope"></i>&nbsp;826605735@qq.com</p>
            </div>
            <div class="row33">
                <p><i class="fa fa-female"></i>&nbsp;王煜</p>
                <p><i class="fa fa-birthday-cake"></i>&nbsp;1997-07-12</p>
                <p><i class="fa fa-address-card-o"></i>&nbsp;15352324</p>
                <p><i class="fa fa-envelope"></i>&nbsp;823224092@qq.com</p>
            </div>
            <div class="row44">
                <p><i class="fa fa-male"></i>&nbsp;吴文标</p>
                <p><i class="fa fa-birthday-cake"></i>&nbsp;1996-10-19</p>
                <p><i class="fa fa-address-card-o"></i>&nbsp;15352344</p>
                <p><i class="fa fa-envelope"></i>&nbsp;wwb.bill@qq.com</p>
            </div>
        </div><!--main-->
        <div class="clear"></div>
    </div> <!--main1_outer-->
</body>
</html>
