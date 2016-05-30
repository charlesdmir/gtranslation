<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'sourceValue.label', default: 'SourceValue')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-sourceValue" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-sourceValue" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="['Source Values']" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.sourceValue}">
                <div class="alert alert-danger" role="alert">
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <span class="sr-only">Error:</span>
                    <span>
                        <ul>
                            <g:eachError bean="${this.sourceValue}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>
                    </span>
                </div>
            </g:hasErrors>


            <g:form resource="${this.sourceValue}" method="PUT">
                <g:hiddenField name="project.id" value="${this.sourceValue?.project.id}"/>
                <g:hiddenField name="version" value="${this.sourceValue?.version}" />
                <div class="form-group">
                    <label class="sr-only" for="key">Key</label>
                    <g:textField name="key" class="form-control" placeholder="Key" value="${this.sourceValue.key}"></g:textField>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="defaultValue">Source Value</label>
                    <g:textArea name="defaultValue" class="form-control" placeholder="Source Value" value="${this.sourceValue.defaultValue}" rows="3"></g:textArea>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="comments">Comments</label>
                    <g:textField name="comments" class="form-control" placeholder="Comments" value="${this.sourceValue.comments}"></g:textField>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="characterLimit">Character Limit</label>
                    <g:textField name="characterLimit" class="form-control" placeholder="Character Limit" value="${this.sourceValue.characterLimit}"></g:textField>
                </div>
                <h3>Categories</h3>
                <g:render template="/category/selectCategoryTree" model="[project: this.sourceValue?.project]"></g:render>
                <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Update')}"/>
            </g:form>
        </div>
    </body>
</html>
