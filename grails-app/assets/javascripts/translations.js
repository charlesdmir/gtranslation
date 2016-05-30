/**
 * Created by pgarcia on 11/14/15.
 */
var $table = $('#table'),
    $waitModal =$('#myPleaseWait'),
    $waitMessage = $('#myPleaseWait #pleaseWaitMessage');

$(window).on('load', function() {
    initTable();
});

function loadTranslation(id) {
    showLoading();
    $.ajax({
        url: "/translation/editComponent/"+ id,
        success: function(response) {
            $('#translationPanel').html(response);
            initButtons();
            renderComements();
        },
        complete: function() {
            hideLoading();
        }
    });
}
function updateTranslation() {
    var $form = $('#translationForm')
    showLoading();
    $.ajax({
        data: $form.serialize(),
        type: $form.attr('method'),
        url: $form.attr('action') + '/' + $('#sourceId').val(),
        success: function(response) {
            $('#translationPanel').html(response);
            initButtons();
            renderComements();
            $table.bootstrapTable('refresh');
        },
        complete: function() {
            hideLoading();
        }
    });
}

function initButtons() {
    var $translate = $('#translateButtonId'),
        $saveDraftButton = $('#saveDraftId'),
        $toReviewButton = $('#readyToReviewId'),
        $backToDraftButton = $('#backToDraftId'),
        $reviewCompleteButton = $('#reviewCompleteId');

    $saveDraftButton.on('click', function (e) {
        $('#translationPanel #statusId').val(1);
        updateTranslation();
        e.preventDefault();

    });
    $toReviewButton.on('click', function (e) {
        $('#translationPanel #statusId').val(2);
        updateTranslation();
        e.preventDefault();

    });
    $backToDraftButton.on('click', function (e) {
        $('#translationPanel #statusId').val(1);
        updateTranslation();
        e.preventDefault();

    });
    $reviewCompleteButton.on('click', function (e) {
        $('#translationPanel #statusId').val(3);
        updateTranslation();
        e.preventDefault();

    });
    $translate.on('click', function (e) {
        var fromLan = $(this).data('lang-source'),
            toLang = $(this).data('lang-result'),
            text = $('#sourceValueTextId').text();
        e.preventDefault();
        translate(fromLan,toLang, text);
    });
}

function initTable() {
    $table.bootstrapTable({
        locale:'en-US',
        showExport:true,
        exportDataType: 'all',
        exportTypes:['json', 'xml', 'csv', 'txt']
    });
    //disabled some columns
    $table.bootstrapTable('hideColumn', 'id');
    $table.bootstrapTable('hideColumn', 'sourceValue');
    $table.bootstrapTable('hideColumn', 'translation');

    // sometimes footer render error.
    setTimeout(function () {
        $table.bootstrapTable('resetView');
    }, 200);

    $(window).resize(function () {
        $table.bootstrapTable('resetView', {
            height: getHeight()
        });
    });
}

$('#table').on('click-row.bs.table', function (e, row, $element) {

    $table.find('.selected').removeClass('selected');
    $element.addClass('selected');
    loadTranslation(row.id);
});

function getIdSelections() {
    return $.map($table.bootstrapTable('getSelections'), function (row) {
        return row.id
    });
}

function getHeight() {
    return $(window).height() - $('h2').outerHeight(true);
}

function translate(fromLang, toLang, text) {
    showLoading();
    $.ajax({
        url: 'https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20151116T163443Z.79b72cb9b264a329.89065eb2b3776962653ea94bfde97b0122400f70&lang='+fromLang+'-'+toLang+'&text='+text,
        dataType:'jsonp',
        success: function (data) {
            $('#translationEditId').text(data.text);
        },
        complete: function() {
            hideLoading();
        }
    });
}

function showLoading() {
    var over = '<div id="loadingOverlay">' +
        '<i class="fa fa-spinner fa-spin fa-5x fa-fw"></i>' +
        '</div>';
    $('#translationPanel').append(over);
}
function hideLoading() {
    $("#loadingOverlay").remove();
}

function rowStyle(row, index) {
    var classes = ['active', 'success', 'info', 'warning', 'danger'];

    if (row.status == 'Completed') {
        return {
            classes: 'success'
        };
    } else if (row.status == 'In Review') {
        return {
            classes: 'info'
        };
    }
    return {
        classes: 'warning'
    }
}


