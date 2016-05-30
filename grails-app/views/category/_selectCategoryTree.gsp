<div id="categoryTree" class="panel panel-default">
    <div class="panel-heading">
        <a href="#" class="btn btn-default btn-sm selectAll">Select All</a>
        <a href="#" class="btn btn-default btn-sm deselectAll">Deselect All</a>
        <a href="#" class="btn btn-default btn-sm expandAll">Expand All</a>
        <a href="#" class="btn btn-default btn-sm collapseAll">Collapse All</a>
    </div>

    <div class="panel-body">
        <!-- TREEVIEW CODE -->
        <ul class="tree" data-tree-url="${createLink(controller: 'category', action: 'getCategoriesByProject', params: [id: project.id])}">
        </ul>
        <!-- TREEVIEW CODE -->
    </div>
</div>

<asset:javascript src="selectCategoryTV.js"/>
