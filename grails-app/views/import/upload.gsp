<%@ page import="com.gTranslation.util.Roles" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'sourceValue.label', default: 'SourceValue')}"/>
    <title><g:message code="default.import.label" args="[entityName]"/></title>
</head>

<body>

<ol class="breadcrumb">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li><g:link class="list" controller="project" action="index"><g:message code="default.list.label"
                                                                            args="['Project']"/></g:link></li>
    <li><g:link class="list" controller="project" action="show" params="[id: project.id]">${project.name}</g:link></li>
    <li class="active"><g:message code="default.import.label" args="['Source values']"/></li>
</ol>

<h1><g:message code="default.import.label" args="['Source Value File']"/></h1>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<g:if test="${flash.errorMessage}">
    <div class="alert alert-danger" role="alert">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <span>${flash.errorMessage}</span>
    </div>
</g:if>
<g:hasErrors bean="${this.project}">
    <div class="alert alert-danger" role="alert">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <span>
            <g:eachError bean="${this.project}" var="error">
                <g:message error="${error}"/>
            </g:eachError>
        </span>
    </div>
</g:hasErrors>
<g:uploadForm action="uploadSourceFile" method="post">
    <g:hiddenField name="project.id" value="${project.id}"/>
    <div style="position:relative;">
        <a class='btn btn-info' href='javascript:;'>
            Choose File...
            <input type="file"
                   style='position:absolute;z-index:2;top:0;left:0;filter: alpha(opacity=0);-ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";opacity:0;background-color:transparent;color:transparent;'
                   name="file_source" size="40" onchange='$("#upload-file-info").html($(this).val());'>
        </a>
        &nbsp;
        <span class='label label-info' id="upload-file-info"></span>
    </div>

    <g:render template="/category/selectCategoryTree" model="[project: this.project]"></g:render>
    <g:submitButton id="importButton" name="import" class="btn btn-primary"
                    value="${message(code: 'default.button.import.label', default: 'Import')}"/>
</g:uploadForm>
<g:render template="/common/pleaseWaitModal"/>
<script type="text/javascript">
    $("#importButton").on('click', function (e) {
        $('#myPleaseWait #pleaseWaitMessage').html('Uploading file. Please Wait...');
        $('#myPleaseWait').modal('show');
    });
</script>
</body>
</html>
