<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="iso-8859-1"%>

<html><head>
    <%@ include file="head.jsp" %>
    <%@ include file="websocket.jsp" %>
    <link rel="alternate" type="application/rss+xml" title="Airsonic Podcast" href="podcast.view?suffix=.rss">
    <style>
        iframe {
            border: none;
        }
        .entire-panel {
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
        .main-navigation {
            width: 100%;
        }
        .lower {
            flex: 100%;
            display: flex;
            flex-direction: row;
            height: 100%;
        }
        div.left-nav-container {
            width: 16%;
            min-width: 16%;
        }
        .left-navigation {
            width: 100%;
            height: 100%;
        }
        div.non-left-navigation-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            height: 100%;
            width: 84%;
        }
        .main-right-container {
            flex: 1;
            display: flex;
            flex-direction: row;
        }
        .playqueue-container {
            padding-left: 1em;
            padding-right: 1em;
        }
        .main-panel {
            flex: 80%;
        }
        .right-info-container {
            flex: 20%;
        }
        .right-info {
            width: 100%;
            height: 100%;
        }
        .hidden-panel {
            display: none;
        }
    </style>
	

</head>

<body class="bgcolor2" style="height: 100%; margin: 0; overflow-y: hidden">
    <div class="entire-panel">
        <iframe id="upper" name="upper" src="top.view?" onload='javascript:(function(o){o.style.height=o.contentWindow.document.body.scrollHeight+"px";}(this));' class="main-navigation" style="background-color:#175d7b; color: #fff; min-height: 80px;"></iframe>

        <div class="lower">
            <div class="non-left-navigation-container">
                <div class="main-right-container">
                    <iframe id="main" name="main" src="${empty param.main? 'nowPlaying.view' : param.main}" class="bgcolor1 main-panel" allowfullscreen></iframe>
                </div>
                <div class="bgcolor2 playqueue-container">
                    <c:import url="/playQueue.view" />
                </div>
                
           </div>
       </div>
       <iframe id="hidden" name="hidden" class="hidden-panel"></iframe>       
   </div>
   
   <script>
    $(window).on('resize', function(){
        var top = $("#upper");
        top.style.height=top.contentWindow.document.body.scrollHeight+"px";
    });
   </script>
    
</body>
</html>
