<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
<g:set var="entityName" value="${message(code: 'sourceValue.label', default: 'SourceValue')}"/>
<title>Translate Source</title>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/bootstrap-table.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/bootstrap-table.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/locale/bootstrap-table-en-US.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/extensions/export/bootstrap-table-export.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.9.1/extensions/filter-control/bootstrap-table-filter-control.min.js"></script>
<script src="//rawgit.com/hhurz/tableExport.jquery.plugin/master/tableExport.min.js"></script>
</head>
<body>
<ol class="breadcrumb">
    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li><g:link class="list" controller="project" action="index"><g:message code="default.list.label"
                                                                            args="['Project']"/></g:link></li>
    <li><g:link class="list" controller="project" action="show" params="[id: project.id]">${project.name}</g:link></li>
    <li><g:link class="list" controller="sourceValue" action="index" params="['project.id': project.id]"><g:message
            code="default.list.label" args="['Source']"/></g:link></li>
    <li class="active"><g:message code="default.list.label" args="['Source']"/></li>
</ol>

<h1>${sourceValue.key}</h1>

<div class="row">
    <div class="col-md-6">
        <div id="toolbar">
            <div class="btn-group">
                <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                    Actions <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="#">Reviewed</a></li>
                    <li><a href="#">Comment</a></li>
                </ul>
            </div>
        </div>
        <table id="table"
               data-url="/translation/listbysource?sourceValue.id=${sourceValue?.id}"
               data-toolbar="#toolbar"
               data-search="true"
               data-show-refresh="true"
               data-show-toggle="true"
               data-show-columns="true"
               data-show-export="true"
               data-minimum-count-columns="2"
               data-pagination="true"
               data-side-pagination="server"
               data-id-field="id"
               data-page-list="[10, 25, 50, 100]"
               data-show-footer="false"
               data-row-style="rowStyle">
            <thead>
            <tr>
                <th data-field="state" data-checkbox="true"></th>
                <th data-field="id">Id</th>
                <th data-field="sourceValue" data-sortable="true">Source Value</th>
                <th data-field="category" data-sortable="true">Category</th>
                <th data-field="status" data-sortable="true">Status</th>
                <th data-field="translation" data-sortable="true">Translation</th>
                <th data-field="assignedTo" data-sortable="true">Assgined To</th>
                <th data-field="lastModified" data-sortable="true">Modified</th>
            </tr>
            </thead>
        </table>
    </div>

    <div id="translationPanel" class="col-md-6">
        <div class="jumbotron">
            <p>Select a source to translate</p>
        </div>
    </div>
    <asset:javascript src="jquery-comments.min.js"/>
    <asset:stylesheet src="jquery-comments.css"/>
    <asset:javascript src="translations.js"/>
    <asset:javascript src="comments.js"/>
</body>
</body>
</html>
