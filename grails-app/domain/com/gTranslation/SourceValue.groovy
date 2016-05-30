package com.gTranslation

class SourceValue {

    String key
    String defaultValue
    String comments
    int characterLimit
    Date created
    Date lastModified


    static belongsTo = [project:Project]
    static hasMany = [translations: Translation]

    static constraints = {
        defaultValue maxSize: 10000
        key unique: ['project']
        comments nullable: true
        created nullable: true
        defaultValue nullable: false
        lastModified nullable: true
        characterLimit defaultValue: "0"
    }

    def beforeInsert() {
        created = new Date()
        lastModified = new Date()
    }

    def beforeUpdate() {
        lastModified = new Date()
    }
}
