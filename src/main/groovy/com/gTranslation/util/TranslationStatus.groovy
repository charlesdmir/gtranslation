package com.gTranslation.util

/**
 * Created by cmirabella on 11/19/15.
 */
class TranslationStatus {

    public static final CREATED = 0
    public static final DRAFT = 1
    public static final REVIEW = 2
    public static final COMPLETE = 3

    static def getStatusText(int status) {
        def message = ''
        switch (status) {
            case CREATED:
                message = 'Created'
                break
            case DRAFT:
                message = 'Draft'
                break
            case REVIEW:
                message = 'In Review'
                break
            case COMPLETE:
                message = 'Completed'
                break
        }
        return message
    }
}
