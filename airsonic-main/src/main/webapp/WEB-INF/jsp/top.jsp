<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="iso-8859-1"%>

<html><head>
    <%@ include file="head.jsp" %>
    <%@ include file="jquery.jsp" %>

    <script type="text/javascript">
        var previousQuery = "";
        var instantSearchTimeout;
        var showSideBar = ${model.showSideBar};

        function init() {
            top.StompClient.subscribe("top.jsp", {
                "/user/queue/settings/sidebar": function(msg) {
                    toggleLeftFrameCallback(JSON.parse(msg.body));
                }
            });

            top.StompClient.onConnect.push(function() {
                setConnectedImage();
            });

            top.StompClient.onDisconnect.push(function() {
                setDisconnectedImage();
            });

            top.StompClient.onConnecting.push(function() {
                setConnectingImage();
            });

            // in case this frame instantiates too late
            if (top.StompClient.state == 'connected') {
                setConnectedImage();
            }
        }

        function setConnectedImage() {
            $("#connectionStatus img").attr("src", "<spring:theme code='connectedImage'/>");
            $("#connectionStatus div").text("<fmt:message key='top.connected' />");
        }

        function setDisconnectedImage() {
            $("#connectionStatus img").attr("src", "<spring:theme code='disconnectedImage'/>");
            $("#connectionStatus div").text("<fmt:message key='top.disconnected' />");
        }

        function setConnectingImage() {
            $("#connectionStatus img").attr("src", "<spring:theme code='connectingImage'/>");
            $("#connectionStatus div").text("<fmt:message key='top.connecting' />");
        }

        function toggleLeftFrameCallback(show) {
            if (showSideBar != show) {
                if (show) {
                    doShowLeftFrame();
                } else {
                    doHideLeftFrame();
                }
            }
        }

        function triggerInstantSearch() {
            if (instantSearchTimeout) {
                window.clearTimeout(instantSearchTimeout);
            }
            instantSearchTimeout = window.setTimeout(executeInstantSearch, 300);
        }

        function executeInstantSearch() {
            var query = $("#query").val().trim();
            if (query.length > 1 && query != previousQuery) {
                previousQuery = query;
                document.searchForm.submit();
            }
        }

        function showLeftFrame() {
            doShowLeftFrame();
            top.StompClient.send("/app/settings/sidebar", true);
        }

        function doShowLeftFrame() {
            $("div.left-nav-container", window.parent.document).show('slide', {direction:"left"}, 100, function() {
                $("#show-left-frame").hide();
                $("#hide-left-frame").show();
                showSideBar = true;
            });
        }

        function hideLeftFrame() {
            doHideLeftFrame();
            top.StompClient.send("/app/settings/sidebar", false);
        }

        function doHideLeftFrame() {
            $("div.left-nav-container", window.parent.document).hide('slide', {direction:"left"}, 100, function() {
                $("#hide-left-frame").hide();
                $("#show-left-frame").show();
                showSideBar = false;
            });
        }
        
        function toggleConnectionStatus() {
            setConnectingImage();
            if (top.StompClient.state == 'connected') {
                top.StompClient.disconnect();
            } else if (top.StompClient.state == 'dc') {
                top.StompClient.connect();
            }
        }

        function airsonicLogout() {
            $("#logoutForm")[0].submit();
        }
    </script>
</head>

<body class="topframe" style="margin:0.4em 1em 0 1em;" onload="init()">

<span id="dummy-animation-target" style="max-width:0;display: none"></span>

<fmt:message key="top.home" var="home"/>
<fmt:message key="top.now_playing" var="nowPlaying"/>
<fmt:message key="top.starred" var="starred"/>
<fmt:message key="left.playlists" var="playlists"/>
<fmt:message key="top.settings" var="settings"/>
<fmt:message key="top.status" var="status" />
<fmt:message key="top.podcast" var="podcast"/>
<fmt:message key="top.bookmarks" var="bookmarks"/>
<fmt:message key="top.more" var="more"/>
<fmt:message key="top.help" var="help"/>
<fmt:message key="top.search" var="search"/>

    <h1 class="logo">Booksonic</h1>
    <nav>
        <ul>
            <li class="navli"><a href="home.view?" target="main" style="color: #fff;">${home}</a></li>
        	<li class="navli"><a href="left.view?" target="main" style="color: #fff;">Author</a></li>
            <li class="navli"><a href="nowPlaying.view?" target="main" style="color: #fff;">${nowPlaying}</a></li>
            <li class="navli"><a href="starred.view?" target="main" style="color: #fff;">${starred}</a></li>
            <li class="navli"><a href="playlists.view?" target="main" style="color: #fff;">${playlists}</a></li>
            <li class="navli"><a href="podcastChannels.view?" target="main" style="color: #fff;">${podcast}</a></li>
            <li class="navli"><a href="bookmarks.view?" target="main" style="color: #fff;">${bookmarks}</a></li>
			<c:if test="${model.user.settingsRole}">
				<li class="navli"><a href="settings.view?" target="main" style="color: #fff;">${settings}</a></li>
			</c:if>
			<li class="navli"><a href="status.view?" target="main" style="color: #fff;">${status}</a></li>
			<li class="navli"><a href="more.view?" target="main" style="color: #fff;">${more}</a></li>
			<li class="navli"><a href="help.view?" target="main" style="color: #fff;">${help}</a></li>
			<li class="navli"><a href="login.view?logout" style="color: #fff;">Logout</a></li>
		</ul>
	</nav>


    <div style="float: right; margin-top: 10px;">
		<form method="post" action="search.view" target="main" name="searchForm">
			<input required="" type="text" name="query" id="query" size="60" placeholder="Search" onclick="select();" onkeyup="triggerInstantSearch();">
			<a href="javascript:document.searchForm.submit()"><img src="icons/default_dark/search.png" alt="Search" title="Search"></a>
		</form>
    </div>


    <form id="logoutForm" action="<c:url value='/logout'/>"  method="POST" style="display:none">
        <sec:csrfInput />
    </form>

</body></html>
