<div id="show-project" class="content scaffold-show" role="main">
    <h1>${this.project.name}</h1>
    <g:if test="${flash.message}">
        <div class="alert alert-info" role="alert">${flash.message}</div>
    </g:if>
    <f:display bean="project" />
    <g:form resource="${this.project}" method="DELETE">
        <fieldset class="buttons">
            <g:link class="edit" action="edit" resource="${this.project}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
            <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
    </g:form>
    <g:render template="/category/selectCategoryTree"></g:render>
</div>