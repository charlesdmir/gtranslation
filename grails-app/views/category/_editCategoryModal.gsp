<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="titleLabel">Category</h4>
            </div>

            <div class="modal-body">
                <input type="hidden" name="modalType"/>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" id="isTranslatable"> Translatable
                    </label>
                </div>

                <div id="nameGroup">
                    <label for="categoryName" class="control-label">Category Name:</label>
                    <input type="text" class="form-control" id="categoryName">
                </div>

                <div id="langGroup">
                    <label for="categoryLocale" class="control-label">Language:</label>
                    <select class="form-control" id="categoryLocale">
                        <g:each in="${java.util.Locale.availableLocales.sort { it.displayName }}" var="item">
                            <option value="${item.toString()}">${item.getDisplayName()}</option>
                        </g:each>
                    </select>
                </div>

                <div id="sourceGroup" class="checkbox">
                    <label>
                        <input type="checkbox" id="useSource"> Use Source Value
                    </label>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary modalSave" data-dismiss="modal">Save</button>
            </div>
        </div>
    </div>
</div>