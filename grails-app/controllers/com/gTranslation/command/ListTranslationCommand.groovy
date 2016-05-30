package com.gTranslation.command

import com.gTranslation.Category
import com.gTranslation.Project
import grails.validation.Validateable

/**
 * Created by pgarcia on 11/13/15.
 */

class ListTranslationCommand implements Validateable {

    Category category
    String order = 'desc'
    int limit = 10
    int offset=0
    String sortField = 'lastModified'

}
