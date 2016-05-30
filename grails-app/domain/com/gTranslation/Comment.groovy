package com.gTranslation

class Comment {

    static belongsTo = [parent: Comment]

    Date created
    Date modified
    String content
    String username
    int upvoteCount = 0
    boolean userHasUpvoted = false

    static constraints = {
        created nullable: true
        modified nullable: true
    }

    def beforeInsert() {
        created = new Date()
        modified = new Date()
    }

    def beforeUpdate() {
        modified = new Date()
    }
}
