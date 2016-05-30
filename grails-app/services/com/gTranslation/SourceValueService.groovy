package com.gTranslation

import com.gTranslation.stat.SourceValueStat
import com.gTranslation.util.TranslationStatus

class SourceValueService {

    static transactional = false
    CategoryService categoryService

    final CATEGORY_PREFIX = "categoryId-"
    final SEPARATOR = "-"

    def getSourceValuesStats(Project project, def params) {
        def sourceValues = SourceValue.createCriteria().list (sort: params.sort, order: params.order, max: params.max, offset: params.offset) {
            eq('project', project)
            if (params.key)
                ilike('key', '%' + params.key + '%')
        }
        def queryResut = Translation.createCriteria().list {
            projections {
                groupProperty('sourceValue')
                groupProperty('status')
                rowCount()
            }
            inList('sourceValue', sourceValues)
        }
        def results = []
        def auxMap = [:]
        queryResut.each { item ->
            SourceValue sourceValue = item[0]
            def status = item[1]
            int count = item[2]
            SourceValueStat stat = auxMap.get(sourceValue)
            if (stat == null) {
                stat = new SourceValueStat(sourceId: sourceValue.id, key: sourceValue.key, value: sourceValue.defaultValue)
                auxMap.put(sourceValue, stat)
                results.add(stat)
            }
            if (status == TranslationStatus.CREATED) {
                stat.created = count
            } else if (status == TranslationStatus.DRAFT) {
                stat.draft = count
            } else if (status == TranslationStatus.REVIEW) {
                stat.review = count
            } else {
                stat.completed = count
            }

        }
        def resultMap = [:]
        resultMap.put('totalCount', sourceValues.totalCount)
        resultMap.put('results', results)
        return resultMap
    }

    def getTranslations(def params) {
        def results = []
        Category category = Category.get(params.category?.id)
        if (category) {
            results = Translation.findAllByCategory(category, [max: params.limit, sort: params.sortField, order: params.order, offset: params.offset])
        }
        return results

    }

    def processSourceValue(User user,Project project, def params) {
        Integer charLimit = params.int("characterLimit")
        def categoriesList = categoryService.getCategoriesFromParam(params)
        SourceValue sv = new SourceValue(key: params.key?.trim(), defaultValue: params.defaultValue ? params.defaultValue.trim() : null, characterLimit:  charLimit ? 0 : charLimit, comments:  params.comments?.trim(), project:  project)
        if (!categoriesList) {
            sv.errors.reject("Please select one or more categories for source value: " + sv.key)
            return false
        }
        SourceValue.withTransaction { status ->
            return createSourceValueAndTranslations(user, sv, categoriesList, project, status)
        }
    }

    def createSourceValueAndTranslations(User user, SourceValue sv, List categoriesList, Project project, def status) {
        sv.save()
        if (sv.hasErrors()) {
            status.setRollbackOnly()
            return sv
        }
        if (!createTranslations(user, categoriesList, project, sv)) {
            status.setRollbackOnly()
            return sv
        }
        return sv
    }

    private def createTranslations(User user, List categoriesList, Project project, SourceValue sourceValue) {
        boolean result = true
        for (Category category in categoriesList) {
            if (!createTranslation(user, category, project, sourceValue) ) {
                result = false
                sourceValue.errors.reject("Failed to create translations for source value: " + sourceValue.key)
                break
            }
        }
        return result
    }

    private def createTranslation(User user, Category category, Project project, SourceValue sourceValue) {
        int status = TranslationStatus.CREATED
        String value = ''
        if (category.useSourceValue) {
            value = sourceValue.defaultValue
            status = TranslationStatus.COMPLETE
        }
        Translation translation = new Translation(category: category,
                                                project: project,
                                                sourceValue: sourceValue,
                                                assignedTo: user,
                                                value: value,
                                                status:status)
        translation.save()
    }
}
