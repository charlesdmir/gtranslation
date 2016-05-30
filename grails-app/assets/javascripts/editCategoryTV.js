/** Created by cmirabella on 11/11/15.*/

function createNewNode(nodeId, parentId, children, label, objId, objName, objLocale, objUseSource) {
    var dom = '<li class="' + (children ? 'branch' : '') + '" data-node-id="'+ nodeId + '">';
    dom += createNode(nodeId, parentId, children,label, objId, objName, objLocale, objUseSource);
    dom += '</li>';
    return dom;
}
function createNode(nodeId, parentId, children,label, objId, objName, objLocale, objUseSource) {
    var dom = '<label>';
    if (children) {
        dom += '<i class="indicator glyphicon glyphicon-chevron-right"></i>';
    }
    dom += label + '</label>';
    dom += '<input type="hidden" class="categoryId" name="id-'+ nodeId + '" value="'+ objId +'">';
    dom += '<input type="hidden" class="categoryName" name="name-'+ nodeId + '" value="'+ objName +'">';
    dom += '<input type="hidden" class="categoryLocale" name="locale-'+ nodeId + '" value="'+ objLocale +'">';
    dom += '<input type="hidden" class="categoryUseSource" name="useSource-'+ nodeId + '" value="'+ objUseSource +'">';
    dom += '<input type="hidden" class="categoryParent" name="parent-'+ nodeId + '" value="'+ parentId +'">';
    return dom;
}
function createDOMTree(obj, parentId, nodeId) {
    var dom = '';

    if (obj) {
        var children = obj.childs ? obj.childs.length : 0;
        if (obj.name) {
            dom += '<li class="' + (children ? 'branch' : '') + '" data-node-id="'+ nodeId + '">';
            dom += createNode(nodeId, parentId, children,obj.name, obj.id, obj.name, obj.locale, obj.useSource);
        }
        if (children) {
            if (obj.name) {
                dom += '<ul style="display: none;">';
            }
            for (var i = 0; i < children; i++) {
                var nodeChild = nodeId +'.'+ i;
                dom += createDOMTree(obj.childs[i],nodeId, nodeChild);
            }
            if (obj.name) {
                dom += '</ul>';
            }
        }
        if (obj.name) {
            dom += '</li>';
        }
    }
    return dom;
}

function toggleBranch(e, $branch, close) {
    e.preventDefault();

    $branch
        [(close ? 'remove' : 'add') + 'Class']('toggled')
        .find('> ul')
        ['slide' + (close ? 'Up' : 'Down')]()
        .end()
        .find('> label > i')
        [(close ? 'remove' : 'add') + 'Class']('glyphicon-chevron-down');
}
function toggleCategoryType($modal, status) {
    if (status) {
        $modal.find('.modal-body #nameGroup').hide();
        $modal.find('.modal-body #langGroup').show();
        $modal.find('.modal-body #sourceGroup').show();
    } else {
        $modal.find('.modal-body #nameGroup').show();
        $modal.find('.modal-body #langGroup').hide();
        $modal.find('.modal-body #sourceGroup').hide();
    }
}


function createCategory(e, $tree, $modal, $selected) {
    var isTranslatable = $modal.find('.modal-body #isTranslatable').is(':checked'),
        categoryName = !isTranslatable ? $modal.find('.modal-body #categoryName').val() : '',
        categoryLocale = isTranslatable ? $modal.find('.modal-body #categoryLocale').val() : '',
        categoryLocaleText = isTranslatable ? $modal.find('.modal-body #categoryLocale option:selected').text() : '',
        useSource = isTranslatable && $modal.find('.modal-body #useSource').is(':checked'),
        label = isTranslatable ? categoryLocaleText : categoryName;
    if ($selected.length == 0) {
        var children = $tree.children().length;
        var dom = createNewNode(children, '', false, label,'', categoryName, categoryLocale, useSource);
        $tree.append(dom);
    } else {
        var $parent = $selected.parent(),
            $childrenNode = $parent.children('ul'),
            parentNodeId = $parent.data('node-id');
        if ($childrenNode.length > 0) {
            var dom = createNewNode(parentNodeId+ '.'+$childrenNode.length, parentNodeId, false, label, '', categoryName, categoryLocale, useSource);
            $childrenNode.append(dom);
        } else {
            var parentLabelText = $selected.text();
            $selected.remove();
            var dom = '<label class="selected"><i class="indicator glyphicon glyphicon-chevron-right"></i>';
            dom += parentLabelText;
            dom += '</label><ul>';
            dom += createNewNode(parentNodeId+ '.0', parentNodeId, false, label, '', categoryName, categoryLocale, useSource);
            dom += '</ul>';
            $parent.append(dom);
            $parent.addClass('branch toggled');
        }
    }
}

function editCategory(e, $tree, $modal, $selected) {
    var isTranslatable = $modal.find('.modal-body #isTranslatable').is(':checked'),
        categoryName = !isTranslatable ? $modal.find('.modal-body #categoryName').val() : '',
        categoryLocale = isTranslatable ? $modal.find('.modal-body #categoryLocale').val() : '',
        categoryLocaleText = isTranslatable ? $modal.find('.modal-body #categoryLocale option:selected').text() : '',
        useSource = isTranslatable && $modal.find('.modal-body #useSource').is(':checked'),
        label = isTranslatable ? categoryLocaleText : categoryName;
}

function removeCategory(e, $tree) {
    e.preventDefault();
    var $selected = $tree.find('.selected');
    if ($selected.length > 0) {
        var $parentSelected = $selected.parent();
        var result = confirm("Are you sure you want to remove the Category selected?");
        if (result) {
            var $parent = $parentSelected.parent();
            $parentSelected.remove();
            if ($parent.has('ul').length == 0) {
                $parent.removeClass('branch toggled');
            }

        }
    }
}
function launchModal($modal, modalType, translatable, categoryName, locale, useSource) {
    $modal.find('.modal-body #isTranslatable').prop('checked', translatable);

    $modal.find('.modal-body #categoryName').val(categoryName);
    $modal.find('.modal-body #categoryLocale').val(locale);
    $modal.find('.modal-body #useSource').prop('checked', useSource);

    toggleCategoryType($modal, translatable);

    $modal.find(".modal-body input[name='modalType']").val(modalType);
    $modal.modal();
}

var TREE_VIEW_SELECTOR = '#categoryTree';


$(window).on('load', function () {
    // vars
    var $treeView = $(TREE_VIEW_SELECTOR),
        $tree = $treeView.find('.tree'),
        $expandAll = $treeView.find('.expandAll'),
        $collapseAll = $treeView.find('.collapseAll'),
        $create = $treeView.find('.create'),
        $edit = $treeView.find('.edit'),
        $delete = $treeView.find('.delete'),
        $modal = $('#categoryModal'),
        $confirmModal = $modal.find('.modalSave');

    // listeners
    $modal.find('.modal-body #isTranslatable').on('click', function (e) {
        toggleCategoryType($modal, $(this).is(':checked'));

    });

    $create.on('click', function (e) {
        e.preventDefault();
        var $modal = $('#categoryModal');
        var $selected = $tree.find('.selected');
        if ($selected.length > 0) {
            var $parentSelected = $selected.parent(),
                nodeId = $parentSelected.data('node-id'),
                $categoryLocale = $parentSelected.find("[name='locale-"+nodeId+"']"),
                locale = $categoryLocale.val();
            if (locale != '' || locale) {
                alert("It is not allowed to create a category inside a translatable category.");
                return;
            }
        }
        launchModal($modal, 'create', false, '', '', false);
    });

    $edit.on('click', function (e) {
        e.preventDefault();

        var $selected = $tree.find('.selected');
        var translatable = false,
            categoryName = '',
            locale = '',
            useSource = false;
        if ($selected.length > 0) {
            var $parentSelected = $selected.parent(),
                nodeId = $parentSelected.data('node-id'),
                $categoryName = $parentSelected.find("[name='name-"+nodeId+"']"),
                $categoryLocale = $parentSelected.find("[name='locale-"+nodeId+"']"),
                $categoryUseSource = $parentSelected.find("[name='useSource-"+nodeId+"']"),
                categoryName = $categoryName.val(),
                locale = $categoryLocale.val(),
                useSource = $categoryUseSource.val() == 'true',
                translatable = locale != '' || locale;

        }
        launchModal($modal, 'edit',translatable, categoryName, locale, useSource);
    });
    $confirmModal.on('click',function (e) {
        e.preventDefault();
        var $selected = $tree.find('.selected');
        if ($modal.find(".modal-body input[name='modalType']").val() == 'edit') {

        } else {
            createCategory(e, $tree, $modal, $selected);
        }
    });


    $delete.on('click', function (e) {
        removeCategory(e, $tree);

    });
    $expandAll.on('click', function (e) {
        toggleBranch(e, $tree.find('.branch'));
    });
    $collapseAll.on('click', function (e) {
        toggleBranch(e, $tree.find('.branch'), true);
    });
    $tree.on('click', 'li > label', function (e) {
        var $branch = $(this).parent();
        var isSelected = $(this).hasClass('selected');
        $treeView.find('.selected').removeClass('selected');
        if (!isSelected) {
            $(this).addClass('selected');
        }
       toggleBranch(e, $branch, $branch.hasClass('toggled'));
    });

    // main
    $.ajax({
            url: $tree.data('tree-url'),
            dataType: 'json'
        })
        .done(function (data) {
            var children = data ? data.length : 0;
            if (children) {
                for (var i = 0; i < children; i++) {
                    var node = i;
                    var treeData = createDOMTree(data[i], '', node);
                    $tree.append(treeData);
                }
            }
        });
})
