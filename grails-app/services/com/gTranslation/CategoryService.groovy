package com.gTranslation

import com.gTranslation.tree.CategoryTree
import grails.transaction.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class CategoryService {
    final CATEGORY_PREFIX = "categoryId-"

    def getCategoriesByProject(Project project) {
        def categories = Category.findAllByProjectAndParent(project, null, [sort: "name", order: "asc"])
        List<CategoryTree> results = []
        categories.each { category ->
            results.addAll(processCategory(category))
        }
        return results
    }

    def processCategory(Category category) {
        List<CategoryTree> results = []
        def name = category.name
        if (category.locale != null) {
            name = category.locale.getDisplayName()
        }
        CategoryTree categoryTree = new CategoryTree(id: CategoryTree.PREFIX_ID + category.id, name: name, leaf: category.locale != null, useSource: category.useSourceValue, locale: category.locale ? category.locale : '')
        category.childs.each { childCategory ->
            categoryTree.addAllChilds(processCategory(childCategory))
        }
        results.add(categoryTree)
        return results
    }

    def getCategoriesFromParam(GrailsParameterMap params) {
        def categoryList = []

        def categoriesListFromParams = params.findAll{ it.key.startsWith(CATEGORY_PREFIX)}

        categoriesListFromParams?.each { key, value ->
            categoryList.add(Category.get(key[CATEGORY_PREFIX.length()..-1]));
        }

        return categoryList
    }

    def getCategoriesFromParam(HashMap params) {
        def categoryList = []

        def categoriesListFromParams = params.findAll{ it.key.startsWith(CATEGORY_PREFIX)}

        categoriesListFromParams?.each { key, value ->
            categoryList.add(Category.get(key[CATEGORY_PREFIX.length()..-1]));
        }

        return categoryList

    }
}
