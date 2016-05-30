package com.gTranslation.tree

class CategoryTree {

    public static String PREFIX_ID = "categoryId-"

    String id
    String name
    String locale
    boolean useSource
    boolean leaf

    List<CategoryTree> childs = [];

    def addChild(CategoryTree categoryTree) {
        childs.add(categoryTree)
    }

    def addAllChilds(List<CategoryTree> categories) {
        childs.addAll(categories)
    }
}
