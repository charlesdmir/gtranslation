package com.gTranslation

import grails.converters.JSON

class CommentController {

    static allowedMethods = [create: "POST", upvote:"POST", downvote: "POST", delete:"POST", update:'POST']

    def springSecurityService

    def index() {}

    def create (){
        Comment comment = new Comment()
        Translation translation = Translation.get(params.translationId)
        // todo: check translation

        bindData(comment, params, [exclude: ['id','created','modified']])
        comment.username = springSecurityService.currentUser.username

        if (comment.parent){
            comment.parent = Comment.get(params.parent)
        }
        translation?.addToComments(comment)
        if (!comment.save()) {
            comment.errors.each {
                println it
            }
        }

        render comment as JSON
    }

    def upvote(Comment comment){
        if (comment){
            comment.upvoteCount = comment.upvoteCount + 1
            comment.save()
            render comment as JSON
        }

    }

    def downvote(Comment comment){
        if (comment){
            comment.upvoteCount = comment.upvoteCount - 1
            comment.save()
            render comment as JSON
        }
    }

    def delete(Comment comment){
        if (comment) {
            comment.delete()
        }

        render status:200

    }

    def update (Comment comment){
        if (comment){
            comment.save()
        }
        render comment as JSON
    }

    def list(Translation translation){
        render translation.comments as JSON
    }
}
