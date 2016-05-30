/**
 * Created by pgarcia on 11/18/15.
 */

function renderComements () {

    $('#comments-container').comments({
        profilePictureURL: 'https://app.viima.com/static/media/user_profiles/user-icon.png',

        postComment: function (commentJSON, success, error) {
            $.ajax({
                type: 'post',
                url: '/comment/create?translationId=' + $('#sourceId').val(),
                data: commentJSON,
                success: function (comment) {
                    success(comment)
                },
                error: error
            });
        },

        upvoteComment: function (commentJSON, success, error) {
            var upvotesURL = '/comment/upvote/' + commentJSON.id;
            var downvotesURL = '/comment/downvote/' + commentJSON.id;

            if (commentJSON.user_has_upvoted) {
                $.ajax({
                    type: 'post',
                    url: upvotesURL,
                    success: function () {
                        success(commentJSON)
                    },
                    error: error
                });
            } else {
                $.ajax({
                    type: 'post',
                    url: downvotesURL,
                    success: function () {
                        success(commentJSON)
                    },
                    error: error
                });
            }
        },

        deleteComment: function (commentJSON, success, error) {
            $.ajax({
                type: 'post',
                url: '/comment/delete/' + commentJSON.id,
                success: success,
                error: error
            });
        },

        putComment: function (commentJSON, success, error) {
            $.ajax({
                type: 'post',
                url: '/comment/update/' + commentJSON.id,
                data: commentJSON,
                success: function (comment) {
                    success(comment)
                },
                error: error
            });
        },

        getComments: function (success, error) {
            $.ajax({
                type: 'get',
                url: '/comment/list/' + $('#sourceId').val(),
                success: function (commentsArray) {
                    success(commentsArray)
                },
                error: error
            });
        }

    });
}
