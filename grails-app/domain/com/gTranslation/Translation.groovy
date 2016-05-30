package com.gTranslation

class Translation {

    String value
    int status
    Date created
    Date lastModified

    static hasMany = [comments: Comment]
    static belongsTo = [project: Project, sourceValue: SourceValue, category: Category, assignedTo: User]

    static constraints = {
        value nullable: true, maxSize: 10000
        created nullable: true
        lastModified nullable: true
        assignedTo nullable: true  //FIXME
    }

    def beforeInsert() {
        created = new Date()
        lastModified = new Date()
    }

    def beforeUpdate() {
        lastModified = new Date()
    }

}
