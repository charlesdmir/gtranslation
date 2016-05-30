package com.gTranslation

class Category {

    String name
    boolean useSourceValue
    boolean isTranslatable
    java.util.Locale locale

    static belongsTo = [parent: Category, project: Project]
    static hasMany = [childs: Category, translations: Translation]

    static constraints = {
        name nullable: true
        parent nullable: true
        locale nullable: true
    }
}
