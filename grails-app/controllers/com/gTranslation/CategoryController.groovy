package com.gTranslation

import grails.converters.JSON
import grails.transaction.Transactional
import org.apache.commons.lang.LocaleUtils

@Transactional(readOnly = true)
class CategoryController {

    CategoryService categoryService

    static allowedMethods = []


    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def getCategoriesByProject(Project project) {
        def categories = categoryService.getCategoriesByProject(project)
        render categories as JSON
    }

    def getLocaleList() {
        def locales = java.util.Locale.getAvailableLocales().sort().collect { locale ->
            locale.getDisplayName() + '|' + locale.toString()
        }
        render locales as JSON
    }
}
