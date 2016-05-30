<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'sourceValue.label', default: 'SourceValue')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<ol class="breadcrumb">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li><g:link class="list" controller="project" action="show" params="[id: project.id]">${project.name}</g:link></li>
    <li class="active"><g:message code="default.create.label" args="['Source Values']"/></li>
</ol>

<h1><g:message code="default.create.label" args="['Source Values']"/></h1>
<g:if test="${flash.message}">
    <div class="message alert alert-info" role="status">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.sourceValue}">
    <div class="alert alert-danger" role="alert">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <span>
            <ul>
                <g:eachError bean="${this.sourceValue}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </ul>
        </span>
    </div>
</g:hasErrors>
<g:form action="save">
    <g:hiddenField name="project.id" value="${project.id}"/>
    <div class="row">
        <div class="form-group col-md-6">
            <label class="sr-only" for="key">Key</label>
            <g:textField name="key" class="form-control" placeholder="Key"
                         value="${this.sourceValue.key}"></g:textField>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-6">
            <label class="sr-only" for="defaultValue">Source Value</label>
            <g:textArea name="defaultValue" class="form-control" placeholder="Source Value"
                        value="${this.sourceValue.defaultValue}" rows="3"></g:textArea>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-6">
            <label class="sr-only" for="comments">Comments</label>
            <g:textField name="comments" class="form-control" placeholder="Comments"
                         value="${this.sourceValue.comments}"></g:textField>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-3">
            <label class="control-label" for="characterLimit">Character Limit</label>
            <g:textField name="characterLimit" class="form-control" placeholder="Character Limit"
                         value="${this.sourceValue.characterLimit}"></g:textField>
        </div>
    </div>

    <h3>Categories</h3>
    <g:render template="/category/selectCategoryTree" model="[project: this.project]"></g:render>
    <g:submitButton name="create" class="btn btn-primary"
                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
</g:form>
</body>
</html>
