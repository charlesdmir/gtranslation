<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Source</h3>
    </div>

    <div class="panel-body">
        <!--<p>${translation?.sourceValue.key}</p>
        -->
        <p id="sourceValueTextId">${this.translation?.sourceValue.defaultValue}</p>
    </div>
</div>

<div class="panel ${this.translation.status == 3 ? 'panel-success' : this.translation.status == 2 ? 'panel-info' :'panel-warning'}">
    <div class="panel-heading">
        <h3 class="panel-title">Translation</h3>
    </div>

    <div id="translationPanel" class="panel-body">
        <g:if test="${flash.message}">
            <div class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                ${flash.message}
            </div>
        </g:if>
        <g:hasErrors bean="${this.translation}">
            <div>
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.translation}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </div>
        </g:hasErrors>
        <g:form name="translationForm" update="messageId" url="[controller: 'translation', action: 'update']"
                method="PUT">
            <input type="hidden" name="id" id="sourceId" value="${this.translation.id}"/>
            <input type="hidden" name="status" id="statusId" value="${this.translation.status}"/>

            <g:if test="${translation.status == com.gTranslation.util.TranslationStatus.CREATED || translation.status == com.gTranslation.util.TranslationStatus.DRAFT}">
                <textarea id="translationEditId" name="value" class="form-control custom-control"
                          rows="6">${this.translation.value}</textarea>
                <hr/>
                <a href="#" id="translateButtonId" data-lang-source="en"
                   data-lang-result="${this.translation.category.locale.getLanguage()}" class="btn btn-default"><span
                        class="glyphicon glyphicon-search" aria-hidden="true"></span> Suggest</a>

                <a href="#" id="saveDraftId" class="btn btn-default"><span class="glyphicon glyphicon-save"
                                                                           aria-hidden="true"></span> Save Draft</a>

                <a href="#" id="readyToReviewId" class="btn btn-default"><span class="glyphicon glyphicon-thumbs-up"
                                                                               aria-hidden="true"></span> Ready to Review
                </a>
            </g:if>

            <g:if test="${this.translation.status == com.gTranslation.util.TranslationStatus.REVIEW || this.translation.status == com.gTranslation.util.TranslationStatus.COMPLETE}">
                <p>${this.translation.value}</p>
                <hr/>
                <g:if test="${this.translation.status == com.gTranslation.util.TranslationStatus.REVIEW}">
                    <a href="#" id="backToDraftId" class="btn btn-default"><span class="glyphicon glyphicon-thumbs-down"
                                                                                 aria-hidden="true"></span> Back to Draft
                    </a>


                    <a href="#" id="reviewCompleteId" class="btn btn-default"><span class="glyphicon glyphicon-ok"
                                                                                    aria-hidden="true"></span> Review Complete
                    </a>
                </g:if>
            </g:if>
        </g:form>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Comments</h3>
    </div>

    <div class="panel-body">
        <div id="comments-container"></div>
    </div>
</div>
