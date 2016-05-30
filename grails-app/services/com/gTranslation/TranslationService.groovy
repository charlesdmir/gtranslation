package com.gTranslation

import com.gTranslation.stat.TranslationStat
import com.gTranslation.util.CategoryUtil
import com.gTranslation.util.TranslationStatus

import javax.xml.transform.Source

class TranslationService {

    def getPendingByProject(Project project) {
        def list = getTranslationByProjectAndStatus(project, TranslationStatus.CREATED)
        list.addAll(getTranslationByProjectAndStatus(project, TranslationStatus.DRAFT))
        return list
    }

    def getToReviewByProject(Project project) {
        getTranslationByProjectAndStatus(project, TranslationStatus.REVIEW)
    }

    def getCompletedByProject(Project project) {
        getTranslationByProjectAndStatus(project, TranslationStatus.COMPLETE)
    }

    def getTranslationByProjectAndStatus(Project project, int status) {
        Translation.findAllByProjectAndStatus(project, status)
    }

    def getTranslationsStats(Project project, def sort) {
        def queryResut = Translation.createCriteria().list {
            category {
                isNotNull('locale')
            }
            projections {
                groupProperty('category')
                groupProperty('status')
                rowCount()
            }
            if (project)
                eq('project', project)
        }
        def result = []
        def auxMap = [:]
        queryResut.each { item ->
            def category = item[0]
            int status = item[1]
            int count = item[2]
            TranslationStat stat = auxMap.get(category.id)
            if (stat == null) {
                stat = new TranslationStat(categoryId: category.id, locale: category.locale, category: CategoryUtil.getCategoryName(category), categoryLocale: CategoryUtil.getCategoryNameWithLocale(category))
                auxMap.put(category.id, stat)
                result.add(stat)
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
        return sortTranslationList(result, sort)
    }

    private def sortTranslationList(def result, def sort) {
        return result.sort { a, b ->
            if (sort == 'locale')
                a.locale.compareToIgnoreCase b.locale
            else if (sort == 'completed')
                b.completed.compareTo(a.completed)  //Bigger first
            else if (sort == 'pending')
                b.pending.compareTo(a.pending) //Bigger first
            else
                a.categoryLocale.compareToIgnoreCase b.categoryLocale
        }
    }

    def getTranslations(def params) {
        Integer max = Integer.parseInt(params.limit)
        params.limit = Math.min(max ?: 10, 100)
        if (params.sort == 'key') {
            params.sort = 'sourceValue.key'
        }
        def results = []
        Category category = Category.get(params.category?.id)
        if (category) {
            results = Translation.createCriteria().list(max: params.limit, sort: params.sort ?: 'lastModified', order: params.order, offset: params.offset) {
                eq('category', category)
                if (params.search){
                    sourceValue {
                        ilike('key', '%'+params.search+'%')
                    }
                }

            }
        }
        return results
    }

    def getTranslationsBySourceValue(def params) {
        Integer max = Integer.parseInt(params.limit)
        params.limit = Math.min(max ?: 10, 100)
        def results = []
        SourceValue sourceValue = SourceValue.get(params.sourceValue?.id)
        if (sourceValue) {
            results = Translation.createCriteria().list(max: params.limit, sort: params.sort ?: 'lastModified', order: params.order, offset: params.offset) {
                eq('sourceValue', sourceValue)
                if (params.search){
                    sourceValue {
                        ilike('key', '%'+params.search+'%')
                    }
                }
            }
        }
        return results
    }
}