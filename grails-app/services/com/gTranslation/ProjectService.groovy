package com.gTranslation

import grails.transaction.Transactional

class ProjectService {

    public static final String PARENT_PREFIX = 'parent-'
    public static final String ID_PREFIX = 'id-'
    public static final String NAME_PREFIX = 'name-'
    public static final String LOCALE_PREFIX = 'locale-'
    public static final String USE_SOURCE_PREFIX = 'useSource-'


    def getProjectByUser(User user) {
        return Project.list()
        //FIXME
        def teams = Team.withCriteria {
            users {
                eq('id', user.id)
            }
        }
        def projects = []
        teams.each { team ->
            projects.addAll(team.projects)
        }
        return projects
    }

    def createCategory(Project project, Category parentCategory, def parentId, def params) {
        def parentList = params.findAll { it.key.startsWith(PARENT_PREFIX) && it.value == parentId }
        parentList.each { key, value ->
            String id = key.substring(PARENT_PREFIX.length())
            String name = params[NAME_PREFIX + id]
            def localeStr = params[LOCALE_PREFIX + id]
            def useSource = params[USE_SOURCE_PREFIX + id]
            Locale locale = localeStr ? new Locale(localeStr) : null
            Category category = new Category(project: project, parent: parentCategory, name: name, locale: locale, isTranslatable: locale != null, useSource: useSource.asBoolean())
            category.save()
            createCategory(project, category, id, params)
        }
    }

    @Transactional
    def saveProject(Project project, def params) {
        project.save()
        createCategory(project, null, '', params)
    }

}
