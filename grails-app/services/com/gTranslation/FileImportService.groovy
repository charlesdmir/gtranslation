package com.gTranslation

import com.gTranslation.fileImport.KeyValueJsonParser

class FileImportService {
    static transactional = false
    static final int MAX_PER_TRANSACTION = 1000

    CategoryService categoryService
    SourceValueService sourceValueService

    def importSourceValues(User user,Project project, def params, InputStream uploadedFile) {
        def categoriesList = categoryService.getCategoriesFromParam(params)
        if (!categoriesList) {
            project.errors.reject("file.upload.categories.not.selected.error")
            return false
        }
        def sourceValues = this.importSourceFile(user, uploadedFile, categoriesList, project)
        return sourceValues
    }

    def importSourceFile(User user, InputStream stream, def categories, Project project) {
        def parser = new KeyValueJsonParser()
        def sourceValuesList = parser.parse(stream, project)
        int maxInTransaction = MAX_PER_TRANSACTION /categories.size()
        def auxList = []
        sourceValuesList?.each() { item ->
            auxList.add(item)
            if (auxList.size() > maxInTransaction) {
                importList(auxList, user, categories, project)
                auxList.clear()
            }
        }
        importList(auxList, user, categories, project)
        return sourceValuesList
    }

    private def importList(def sourceValues , User user, def categories, Project project) {
        SourceValue.withTransaction { status ->
            sourceValues.each { item ->
                if (SourceValue.countByKeyAndDefaultValue(item.key, item.defaultValue) == 0) {
                    sourceValueService.createSourceValueAndTranslations(user, item, categories, project, status)
                }

            }
        }
    }
}
