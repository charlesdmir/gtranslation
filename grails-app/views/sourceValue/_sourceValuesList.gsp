<div class="table-responsive">
    <table class="table table-hover">
        <thead>
        <th></th>
        <th>Key</th>
        <th>Value</th>
        </thead>
        <tbody>
        <g:each in="${sourceValueList}" var="sourceValue">
            <tr>
                <td class="col-xs-1">
                    <g:link class="btn btn-default btn-xs" controller="sourceValue" action="edit" params="${[id:sourceValue.id]}">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    </g:link>
                </td>
                <td>
                    ${sourceValue.key}
                </td>
                <td>
                    ${sourceValue.defaultValue}
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pull-right">
        <g:paginate total="${sourceValueCount ?: 0}"/>
    </div>
</div>