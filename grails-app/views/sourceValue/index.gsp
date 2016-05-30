<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'sourceValue.label', default: 'SourceValue')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<ol class="breadcrumb">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li><g:link class="list" controller="project" action="index"><g:message code="default.list.label"
                                                                            args="['Project']"/></g:link></li>
    <li><g:link class="list" controller="project" action="show" params="[id: project.id]">${project.name}</g:link></li>
    <li class="active"><g:message code="default.list.label" args="['Source']"/></li>
</ol>

<h1>Source values</h1>

<p>

<div class="row">
    <div class="col-sm-5">
        <form action="/sourceValue/list" method="GET">
            <div class="input-group">
                <input type="hidden" name="project.id" value="${this.project.id}"/>
                <input type="text" name="key" value="${params.key}" class="form-control" placeholder="Source key">
                <span class="input-group-btn">
                    <input type="submit" class="btn btn-default" id="search" value="Search">
                </span>
            </div>
        </form>
    </div>
    <div class="clearfix visible-xs-inline-block"></div>
    <div class="col-sm-5">
        <g:link class="btn btn-success" controller="sourceValue" action="create"
                params="${['project.id': this.project.id]}">Add new Key</g:link>
        <g:link class="btn btn-success" controller="import" action="upload"
                params="${['project.id': this.project.id]}"><i class="fa fa-cloud-upload"></i> Import Source File</g:link>
    </div>
</div>
</p>
<g:if test="${flash.message}">
    <p>
    <div class="message alert alert-info" role="status">${flash.message}</div>
    </p>
</g:if>
<table class="table table-hover">
    <thead>
    <th>Key</th>
    <th class="hidden-xs">Value</th>
    <th>Pending</th>
    <th>Completed</th>
    </thead>
    <tbody>
    <g:each in="${stats}" var="stat">
        <tr>
            <td><g:link controller="sourceValue" action="show" params="[id: stat.sourceId]"> ${stat.key}</g:link></td>
            <td class="hidden-xs">${stat.value}</td>
            <td>${stat.completed}</td>
            <td>${stat.getPending()}</td>
        </tr>
    </g:each>
    </tbody>
</table>

<div class="">
    <g:paginate total="${sourceValueCount ?: 0}" params="['project.id': project.id]"/>
</div>
</body>
</html>