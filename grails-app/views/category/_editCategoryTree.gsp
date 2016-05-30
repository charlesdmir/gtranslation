<div id="categoryTree" class="panel panel-default">
    <div class="panel-heading">
        <a href="#" class="btn btn-default btn-sm create"><span class="glyphicon glyphicon-plus"></span> Create</a>
        <a href="#" class="btn btn-default btn-sm edit"><span class="glyphicon glyphicon-pencil"></span> Edit</a>
        <a href="#" class="btn btn-default btn-sm delete"><span class="glyphicon glyphicon-remove"></span> Delete</a>
        <a href="#" class="btn btn-default btn-sm expandAll"><span class="glyphicon glyphicon-chevron-down"></span> Expand All</a>
        <a href="#" class="btn btn-default btn-sm collapseAll"><span class="glyphicon glyphicon-chevron-right"></span> Collapse All</a>
    </div>

    <div class="panel-body">
        <!-- TREEVIEW CODE -->
        <ul class="tree" data-tree-url="${createLink(controller: 'category', action: 'getCategoriesByProject', params: [id: project.id])}">
        </ul>
        <!-- TREEVIEW CODE -->
    </div>
</div>
<g:render template="/category/editCategoryModal"></g:render>

<asset:javascript src="editCategoryTV.js"/>
