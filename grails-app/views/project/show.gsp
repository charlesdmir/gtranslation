<%@ page import="com.gTranslation.util.CategoryUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<ol class="hidden-sm hidden-md hidden-lg breadcrumb">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li><g:link class="list" controller="project" action="index"><g:message code="default.list.label" args="['Project']"/></g:link></li>
    <li class="active"><g:message code="default.show.label" args="['Project']"/></li>
</ol>

<div class="row">
    <div class="hidden-xs col-sm-4 col-md-3">
        <g:render template="projectPanel" model="[project: this.project]"></g:render>
    </div>
    <div class="col-sm-8 col-md-9">
            <h1>${this.project.name}</h1>
            <g:link class="btn btn-success" controller="sourceValue" action="create"
                    params="${['project.id': this.project.id]}">Add new Key</g:link>
            <g:link class="btn btn-success" controller="import" action="upload"
                    params="${['project.id': this.project.id]}"><i class="fa fa-cloud-upload"></i> Import Source File</g:link>
            <g:link class="btn btn-info" controller="sourceValue" action="index"
                    params="${['project.id': this.project.id]}">Source Values</g:link>
            <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_COORDINATOR}">
                <g:link class="btn btn-primary" controller="project" action="edit"
                        params="${[id: this.project.id]}">Edit project</g:link>
            </sec:ifAnyGranted>


        <div class="btn-group pull-right">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Sort by: <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><g:link controller="project" action="show" params="[id: this.project.id, sort:'category']">Category</g:link></li>
                <li><g:link controller="project" action="show" params="[id: this.project.id, sort:'locale']">Lang</g:link></li>
                <li><g:link controller="project" action="show" params="[id: this.project.id, sort:'pending']">Pending</g:link></li>
                <li><g:link controller="project" action="show" params="[id: this.project.id, sort:'completed']">Completed</g:link></li>
            </ul>
        </div>

        <hr>
        <g:each in="${stats}" var="stat">
            <div class="row">
                <div class="col-xs-8">
                    <strong><g:link controller="project" action="showTranslations"
                                params="[id: stat.categoryId]">${stat.categoryLocale}</g:link></strong> <g:message code="category.localePercentage" args="[stat.locale ,stat.getCompletedPercentage() ]"/>

                </div>
                <div class="col-xs-4 text-right">
                    <strong><g:link controller="project" action="showTranslations"
                                    params="[id: stat.categoryId]">${stat.getPending()}</g:link></strong> keys to translate <span class="badge"><g:message code="default.percentage" args="[stat.getCompletedPercentage()]"/></span>
                </div>
                <div class="col-xs-12">
                    <div class="progress">
                        <div class="progress-bar"
                             style="width: ${stat.getCompletedPercentage()}%">
                        </div>
                        <div class="progress-bar progress-bar-info progress-bar-striped"
                             style="width: ${stat.getReviewPercentage()}%">
                        </div>
                    </div>

                </div>
            </div>
        </g:each>
    </div>
</div>
</body>
</html>
