<div class="panel panel-default">
    <div class="panel-heading">
        <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_COORDINATOR}">
            <div class="btn-group pull-right" style="margin-top:-5px;">
                <g:link class="btn btn-info btn-sm" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link>
            </div>
        </sec:ifAnyGranted>
        <strong>Projects</strong>
    </div>

    <div id="projectList" class="panel-body">
        <ul class="nav nav-pills nav-stacked">
            <g:each in="${projectList}" var="item">
                <li class="${project != null && project.id == item.id ? 'active' : ''}">
                    <a href='${createLink(controller:'project', action:'show', params:[id:item.id])}' data-result-id="ajaxResult">${item.name}</a>
                </li>
            </g:each>
        </ul>
    </div>
</div>