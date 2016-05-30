<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<ol class="breadcrumb">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
    <li class="active"><g:message code="default.create.label" args="[entityName]"/></li>
</ol>

<h1><g:message code="default.create.label" args="[entityName]"/></h1>
<g:if test="${flash.message}">
    <div class="message alert alert-info" role="status">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.project}">
    <div class="alert alert-danger">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.project}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </div>
</g:hasErrors>
<g:form action="save" class="form-horizontal">
    <div class="form-group">
        <label for="name" class="col-sm-2 control-label">Project Name:</label>

        <div class="col-sm-4">
            <g:textField name="name" class="form-control" value="${this.project.name}"></g:textField>
        </div>
    </div>
    <h4>Categories</h4>

    <g:render template="/category/editCategoryTree"></g:render>
    <g:submitButton name="create" class="btn btn-default"
                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>

</g:form>
</body>
</html>
