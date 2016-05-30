/**
 * Created by cmirabella on 11/11/15.
 */
function createDOMTree(obj) {
    var dom = '';

    if (obj) {
        var children = obj.childs ? obj.childs.length : 0;
        if (obj.name) {
            dom += '<li class="' + (children ? 'branch' : '') + '"><label>';
            if (children) {
                dom += '<i class="indicator glyphicon glyphicon-chevron-right"></i>';
            }
            if (obj.leaf) {
                dom += '<input type="checkbox" name="'+ obj.id + '">';
            }
            dom += obj.name + '</label>';
        }
        if (children) {
            if (obj.name) {
                dom += '<ul style="display: none;">';
            }
            for (var i = 0; i < children; i++) {
                dom += createDOMTree(obj.childs[i]);
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

var TREE_VIEW_SELECTOR = '#categoryTree';

$(window).on('load', function () {
    // vars
    var $treeView = $(TREE_VIEW_SELECTOR),
        $tree = $treeView.find('.tree'),
        $selectAll = $treeView.find('.selectAll'),
        $deselectAll = $treeView.find('.deselectAll'),
        $expandAll = $treeView.find('.expandAll'),
        $collapseAll = $treeView.find('.collapseAll'),
        toggleCheck = function (e) {
            e.preventDefault();
            $tree.find('input').prop('checked', e.data.value);
            toggleBranch(e, $tree.find('.branch'));
        };

    // listeners
    $selectAll.on('click', {value: true}, toggleCheck);
    $deselectAll.on('click', {value: false}, toggleCheck);
    $expandAll.on('click', function (e) {
        toggleBranch(e, $tree.find('.branch'));
    });
    $collapseAll.on('click', function (e) {
        toggleBranch(e, $tree.find('.branch'), true);
    });
    $tree.on('click', '.branch > label', function (e) {
        var $branch = $(this).parent();
        toggleBranch(e, $branch, $branch.hasClass('toggled'));
    });

    // main
    $.ajax({
            url: $tree.data('tree-url'),
            dataType: 'json'
        })
        .done(function (data) {
            var treeData = createDOMTree({
                childs: data
            });
            $tree.html(treeData);
        });
})
