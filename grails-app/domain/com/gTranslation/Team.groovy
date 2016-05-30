package com.gTranslation

class Team {

    String name
    static hasMany = [projects: Project, users:User]

    static constraints = {
        name blank: false, unique: true
    }
}
