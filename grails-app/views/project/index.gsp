<%@ page import="com.gTranslation.util.Roles" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="row">
    <div class="col-sm-4 col-md-3">
        <g:render template="projectPanel"></g:render>
    </div>
    <div class="hidden-xs col-sm-8 col-sm-9">
        <div class="jumbotron">
            <h1>Hello, world!</h1>
            <p>Are you ready to connect the world??</p>
        </div>
    </div>
</div>


</div>
</body>
</html>