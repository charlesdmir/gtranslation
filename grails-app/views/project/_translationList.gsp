<%@ page import="com.gTranslation.util.CategoryUtil" %>
<div class="table-responsive">
    <table class="table table-hover">
        <thead>
        <th></th>
        <th>Source Key</th>
        <th>Source Value</th>
        <th>Category</th>
        <th>Language</th>
        <th>Value</th>
        </thead>
        <tbody>
        <g:each in="${translations}" var="translation">
            <tr class="${(translation.status == 0) ? 'active' : (translation.status == 1) ? 'warning' : 'info' }">
                <td class="col-xs-1">
                    <g:link class="btn btn-default btn-xs" controller="translation" action="edit" params="${[id:translation.id]}">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    </g:link>
                </td>
                <td>
                    ${translation.sourceValue.key}
                </td>
                <td>
                    ${translation.sourceValue.defaultValue}
                </td>
                <td>
                    ${com.gTranslation.util.CategoryUtil.getCategoryName(translation.category)}
                </td>
                <td>
                    ${translation.category.locale.getDisplayName()}
                </td>
                <td>
                    ${translation.value}
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>