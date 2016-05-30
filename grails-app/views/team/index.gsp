<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'team.label', default: 'Team')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<ol class="breadcrumb">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li class="active"><g:message code="default.list.label" args="[entityName]"/></li>
</ol>

<h1>Teams</h1>
<g:if test="${flash.message}">
    <div class="message alert alert-info" role="status">${flash.message}</div>
</g:if>
<div class="row">
    <div class="col-sm-5">
        <form action="/team/index">
            <div class="input-group">
                <input type="text" name="name" class="form-control" placeholder="Team name">
                <span class="input-group-btn">
                    <input type="submit" class="btn btn-default" id="search" value="Search Teams"/>
                </span>
            </div>
        </form>
    </div>
    <sec:ifAllGranted roles="${com.gTranslation.util.Roles.ADMIN}">
        <div class="clearfix visible-xs-inline-block"></div>
        <div class="col-md-5">
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
            <th class="col-xs-1"></th>
            <th>Team Name</th>
            <th>Members</th>
            </thead>
            <tbody>
            <g:each in="${teamList}" var="team">
                <tr>
                    <td><g:link class="btn btn-default btn-xs" action="edit" params="[id: team.id]">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    </g:link>
                    </td>
                    <td>${team.name}</td>
                    <td>${team.users}</td>
                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="pull-right">
            <g:paginate total="${teamCount ?: 0}"/>
        </div>
    </div>
</div>

</body>
</html>