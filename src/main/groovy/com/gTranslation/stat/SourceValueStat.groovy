package com.gTranslation.stat

/**
 * Created by cmirabella on 11/18/15.
 */
class SourceValueStat {

    long sourceId
    String key
    String value
    int created
    int draft
    int review
    int completed

    def getTotal() {
        created + draft + review + completed
    }

    def getCreatedPercentage() {
        return created * 100 / getTotal()
    }
    def getDraftPercentage() {
        return draft * 100 / getTotal()
    }
    def getReviewPercentage() {
        return review * 100 / getTotal()
    }
    def getCompletedPercentage() {
        return completed * 100 / getTotal()
    }

    def getPending() {
        return review + draft + created
    }
}
