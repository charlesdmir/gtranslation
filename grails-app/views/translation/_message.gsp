<g:if test="${flash.message}">
    <div class="alert ${flash.error?'alert-danger':'alert-success'} alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        ${flash.message}
    </div>
</g:if>
<g:if test="${this.translation}">
    <g:hasErrors bean="${this.translation}">
        <ul class="errors" role="alert">
            <g:eachError bean="${this.translation}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
</g:if>