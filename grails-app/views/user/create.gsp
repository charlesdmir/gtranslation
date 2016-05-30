<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
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
<g:hasErrors bean="${this.user}">
    <div class="alert alert-danger">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.user}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </div>
</g:hasErrors>
<g:form action="save" class="form-horizontal">
    <div class="form-group">
        <label for="username" class="col-sm-2 control-label">User name</label>

        <div class="col-sm-4">
            <g:textField name="username" class="form-control" placeholder="Ex: jdoe"
                         value="${this.user.username}"></g:textField>
        </div>
    </div>

    <div class="form-group">
        <label for="password" class="col-sm-2 control-label">Password</label>

        <div class="col-sm-4">
            <g:passwordField name="password" class="form-control" value="${this.user.password}"></g:passwordField>
        </div>
    </div>

    <div class="form-group">
        <label for="accountExpired" class="col-sm-2 control-label">Account Expired</label>

        <div class="col-sm-4">
            <g:checkBox name="accountExpired" value="${this.user.accountExpired}"></g:checkBox>
        </div>
    </div>

    <div class="form-group">
        <label for="accountLocked" class="col-sm-2 control-label">Account Locked</label>

        <div class="col-sm-4">
            <g:checkBox name="accountLocked" value="${this.user.accountLocked}"></g:checkBox>
        </div>
    </div>

    <div class="form-group">
        <label for="enabled" class="col-sm-2 control-label">Enabled</label>

        <div class="col-sm-4">
            <g:checkBox name="enabled" value="${this.user.enabled}"></g:checkBox>
        </div>
    </div>

    <div class="form-group">
        <label for="passwordExpired" class="col-sm-2 control-label">Password Expired</label>

        <div class="col-sm-4">
            <g:checkBox name="passwordExpired" value="${this.user.passwordExpired}"></g:checkBox>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <g:submitButton name="create" class="btn btn-success"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </div>
    </div>
</g:form>

</body>
</html>
