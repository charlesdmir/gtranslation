<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<ol class="breadcrumb">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li class="active"><g:message code="default.list.label" args="[entityName]"/></li>
</ol>

<h1><g:message code="default.list.label" args="[entityName]"/></h1>
<g:if test="${flash.message}">
    <div class="message alert alert-info" role="status">${flash.message}</div>
</g:if>

<div class="row">
    <div class="col-sm-5">
        <form action="/user/index">
            <div class="input-group">
                <input type="text" name="username" class="form-control" placeholder="User name">
                <span class="input-group-btn">
                    <input type="submit" class="btn btn-default" id="search" value="Search Users"/>
                </span>
            </div>
        </form>
    </div>
    <sec:ifAllGranted roles="${com.gTranslation.util.Roles.ADMIN}">
    <div class="clearfix visible-xs-inline-block"></div>
        <div class="col-sm-5">
        <g:link class="btn btn-primary" action="create"><g:message code="default.new.label"
                                                                   args="[entityName]"/></g:link>
    </div>
    </sec:ifAllGranted>
</div>
<hr/>
<div class="row">
    <div class="col-xs-12">
        <table class="table table-hover">
            <thead>
            <th>User name</th>
            <th>Enabled</th>
            <th>Is Expired</th>
            <th>Is Locked</th>
            <th>Password Expired</th>
            </thead>
            <tbody>
            <g:each in="${userList}" var="user">
                <tr>
                    <td>
                        <g:link action="edit" params="[id: user.id]">${user.username}</g:link>
                    </td>
                    <td><span class="glyphicon ${user.enabled ? 'glyphicon-ok' : 'glyphicon-remove'}"/></td>
                    <td><span class="glyphicon ${user.accountExpired ? 'glyphicon-ok' : 'glyphicon-remove'}"/></td>
                    <td><span class="glyphicon ${user.accountLocked ? 'glyphicon-ok' : 'glyphicon-remove'}"/></td>
                    <td><span class="glyphicon ${user.passwordExpired ? 'glyphicon-ok' : 'glyphicon-remove'}"/></td>
                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="pull-right">
            <g:paginate total="${userCount ?: 0}"/>
        </div>
    </div>
</div>
</body>
</html>