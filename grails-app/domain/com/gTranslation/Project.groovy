package com.gTranslation

class Project {

    String name
    static belongsTo = [owner: User]

    static hasMany = [categories:Category, sourceValues: SourceValue]

    static constraints = {
        name unique: true
        owner nullable: true
    }
}
