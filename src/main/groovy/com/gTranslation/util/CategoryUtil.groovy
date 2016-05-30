package com.gTranslation.util

/**
 * Created by carlosmirabella on 11/11/15.
 */
class CategoryUtil {

    def static getCategoryName(com.gTranslation.Category category) {
        def result = ''
        if (category.parent != null) {
            result = getCategoryName(category.parent)
        }
        if (category.locale == null) {
            if (category.parent != null ) {
                result += ' -> '
            }
            result += category.name
        }
        return result
    }

    def static getCategoryNameWithLocale(com.gTranslation.Category category) {
        return getCategoryName(category) + ' -> '+ category.locale.getDisplayName()
    }

    def static getCategoryNameList(com.gTranslation.Category category) {
        def result = []
        if (category.parent != null) {
            result.addAll(getCategoryName(category.parent))
        }
        if (category.locale == null) {
            result.add(category.name)
        }
        return result
    }

    def static getCategoryNameWithLocaleList(com.gTranslation.Category category) {
        def result = getCategoryNameList(category).add(category.locale.getDisplayName())
        return result
    }
}
